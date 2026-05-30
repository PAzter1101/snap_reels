import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import 'package:snap_reels/src/models/cache_item.dart';
import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/services/cache_evictor.dart';
import 'package:snap_reels/src/services/cache_index_storage.dart';
import 'package:snap_reels/src/utils/url_utils.dart' as url_utils;

export '../models/cache_item.dart';

/// LRU disk cache for video files and thumbnails, backed by a JSON
/// index file in the temporary directory.
class CacheManager {
  /// Returns the singleton instance, creating it on first access.
  factory CacheManager() => _instance ??= CacheManager._internal();
  CacheManager._internal();
  static CacheManager? _instance;

  late Dio _dio;
  late Directory _cacheDirectory;
  late CacheIndexStorage _storage;
  late CacheConfig _config;
  bool _isInitialized = false;

  final Map<String, CacheItem> _cacheIndex = {};
  final Map<String, Future<String?>> _downloadFutures = {};
  final Map<String, String> _memoryFileCache = {};

  /// Initialize the cache manager. Safe to call multiple times — only the
  /// first call assigns [dio] / [config]; subsequent calls are no-ops.
  ///
  /// Pass a pre-configured [dio] (e.g. with `NativeAdapter` + `CronetEngine`)
  /// to reuse the host application's HTTP stack, including its connection
  /// pool, TLS session cache and interceptors. When omitted, a plain [Dio]
  /// is used.
  Future<void> initialize({Dio? dio, CacheConfig? config}) async {
    if (_isInitialized) {
      if (dio != null && !identical(dio, _dio)) {
        debugPrint(
          'CacheManager: already initialized with a different Dio; '
          'keeping the first one',
        );
      }
      return;
    }
    _cacheDirectory = await getTemporaryDirectory();
    _storage = CacheIndexStorage(_cacheDirectory);
    _dio = dio ?? Dio();
    _config = config ?? const CacheConfig();
    _cacheIndex
      ..clear()
      ..addAll(await _storage.load());
    final expired = await CacheEvictor.evictExpired(_cacheIndex);
    if (expired.isNotEmpty) {
      await _storage.save(_cacheIndex);
      debugPrint('Cleaned up ${expired.length} expired cache items');
    }
    await _enforceSize();
    _isInitialized = true;
  }

  /// Returns the cached file path for [url], or `null` if absent/expired.
  /// Touches `lastAccessTime` on hit.
  String? getCachedFilePath(String url) {
    final cacheKey = _cacheKey(url);
    final item = _cacheIndex[cacheKey];
    if (item != null && !item.isExpired) {
      _cacheIndex[cacheKey] = item.copyWith(lastAccessTime: DateTime.now());
      return item.filePath;
    }
    return null;
  }

  /// Downloads [url] to disk (deduplicating concurrent calls) and returns
  /// the resulting local path, or `null` on failure.
  Future<String?> downloadAndCache(
    String url, {
    void Function(int received, int total)? onProgress,
    CancelToken? cancelToken,
  }) async {
    if (!_isInitialized) await initialize();

    final cachedPath = getCachedFilePath(url);
    if (cachedPath != null) return cachedPath;

    final pending = _downloadFutures[url];
    if (pending != null) return pending;

    final future = _performDownload(
      url,
      onProgress: onProgress,
      cancelToken: cancelToken,
    );
    _downloadFutures[url] = future;
    try {
      return await future;
    } finally {
      unawaited(_downloadFutures.remove(url));
    }
  }

  Future<String?> _performDownload(
    String url, {
    void Function(int received, int total)? onProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final cacheKey = _cacheKey(url);
      final filePath = '${_cacheDirectory.path}/${_fileName(url)}';

      await _dio.download(
        url,
        filePath,
        onReceiveProgress: onProgress,
        cancelToken: cancelToken,
      );

      final file = File(filePath);
      if (!file.existsSync()) {
        throw Exception('Downloaded file does not exist');
      }
      final fileSize = await file.length();
      if (fileSize == 0) {
        await file.delete();
        throw Exception('Downloaded file is empty');
      }

      final now = DateTime.now();
      _cacheIndex[cacheKey] = CacheItem(
        url: url,
        filePath: filePath,
        cacheKey: cacheKey,
        fileSize: fileSize,
        createdAt: now,
        lastAccessTime: now,
        expiryTime: now.add(_config.cacheDuration),
      );
      await _storage.save(_cacheIndex);
      await _enforceSize();
      return filePath;
    } catch (e) {
      debugPrint('Cache download error for $url: $e');
      return null;
    }
  }

  /// Fire-and-forget batch prefetch.
  Future<void> preloadUrls(List<String> urls) async {
    await Future.wait(urls.map(downloadAndCache));
  }

  /// Whether [url] is currently cached and unexpired.
  Future<bool> isCached(String url) async => getCachedFilePath(url) != null;

  /// Aggregate cache statistics for diagnostics and UI.
  Future<CacheStats> getCacheStats() async {
    if (!_isInitialized) return CacheStats.empty();
    final totalFiles = _cacheIndex.length;
    var totalSize = 0;
    var expiredFiles = 0;
    final now = DateTime.now();
    for (final item in _cacheIndex.values) {
      totalSize += item.fileSize;
      if (now.isAfter(item.expiryTime)) expiredFiles++;
    }
    return CacheStats(
      totalFiles: totalFiles,
      totalSize: totalSize,
      expiredFiles: expiredFiles,
      cacheDirectory: _cacheDirectory.path,
    );
  }

  /// Removes all cached files and the persisted index.
  Future<void> clearCache() async {
    try {
      for (final item in _cacheIndex.values) {
        final file = File(item.filePath);
        if (file.existsSync()) await file.delete();
      }
      _cacheIndex.clear();
      await _storage.save(_cacheIndex);
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  /// Adds an alias entry pointing to an already-cached file. Used when a
  /// resource was downloaded via a different URL (e.g. server-side proxy)
  /// and should also be retrievable by the original URL on subsequent
  /// lookups via [getCachedFilePath].
  ///
  /// No-op if no cache entry exists for [existingUrl] or the alias entry
  /// already exists. Does not copy the file — both keys reference the
  /// same path.
  Future<void> linkCachedUrl(String aliasUrl, String existingUrl) async {
    if (!_isInitialized) return;
    final existing = _cacheIndex[_cacheKey(existingUrl)];
    if (existing == null) return;
    final aliasKey = _cacheKey(aliasUrl);
    if (_cacheIndex.containsKey(aliasKey)) return;
    _cacheIndex[aliasKey] = CacheItem(
      url: aliasUrl,
      filePath: existing.filePath,
      cacheKey: aliasKey,
      fileSize: 0,
      createdAt: existing.createdAt,
      lastAccessTime: DateTime.now(),
      expiryTime: existing.expiryTime,
    );
    await _storage.save(_cacheIndex);
  }

  /// Removes the entry for [url] and deletes its file. Any alias entries
  /// pointing at the same file are removed as well so the index stays
  /// consistent with disk state.
  Future<void> removeCachedUrl(String url) async {
    if (!_isInitialized) return;
    final cacheKey = _cacheKey(url);
    final item = _cacheIndex[cacheKey];
    if (item == null) return;
    final file = File(item.filePath);
    if (file.existsSync()) await file.delete();
    _cacheIndex.removeWhere((_, entry) => entry.filePath == item.filePath);
    await _storage.save(_cacheIndex);
  }

  /// Clears the in-memory file path cache (called on memory pressure).
  void clearMemoryCache() {
    _memoryFileCache.clear();
  }

  /// Drops references to in-flight download futures.
  void cancelAllDownloads() {
    _downloadFutures.clear();
  }

  /// Releases internal state. Files on disk are preserved.
  void dispose() {
    _downloadFutures.clear();
  }

  Future<void> _enforceSize() async {
    final evicted = await CacheEvictor.evictToFit(
      _cacheIndex,
      _config.maxCacheSize,
    );
    if (evicted.isEmpty) return;
    await _storage.save(_cacheIndex);
    debugPrint(
      'Removed ${evicted.length} cache items to enforce size limit',
    );
  }

  String _cacheKey(String url) => url_utils.generateCacheKey(url);

  String _fileName(String url) {
    final extension = Uri.parse(url).path.split('.').last;
    return '${_cacheKey(url).substring(0, 16)}.$extension';
  }
}
