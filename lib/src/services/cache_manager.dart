import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '../models/cache_item.dart';
import '../models/reel_config.dart';
import '../utils/url_utils.dart' as url_utils;

export '../models/cache_item.dart';

/// Advanced cache manager for video files and thumbnails
class CacheManager {
  static CacheManager? _instance;
  static CacheManager get instance => _instance ??= CacheManager._internal();

  CacheManager._internal();

  late Dio _dio;
  late Directory _cacheDirectory;
  late CacheConfig _config;
  bool _isInitialized = false;

  final Map<String, CacheItem> _cacheIndex = {};
  final Map<String, Future<String?>> _downloadFutures = {};

  // Max cache size for video files (200MB)
  final int _maxCacheFileSize = 200 * 1024 * 1024;

  // In-memory cache for recently used files (fast access)
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
          'CacheManager: already initialized with a different Dio; keeping the first one',
        );
      }
      return;
    }
    final cacheDir = await getTemporaryDirectory();
    _dio = dio ?? Dio();
    _config = config ?? const CacheConfig();
    _cacheDirectory = cacheDir;
    await _loadCacheIndex();
    await _cleanupExpiredCache();
    await _enforceCacheSize();
    _isInitialized = true;
  }

  /// Get cached file path for a URL (check memory cache first)
  String? getCachedFilePath(String url) {
    final cacheKey = _generateCacheKey(url);
    final item = _cacheIndex[cacheKey];
    if (item != null && !item.isExpired) {
      item.lastAccessTime = DateTime.now();
      return item.filePath;
    }
    return null;
  }

  /// Download and cache a file
  Future<String?> downloadAndCache(
    String url, {
    Function(int received, int total)? onProgress,
    CancelToken? cancelToken,
  }) async {
    if (!_isInitialized) await initialize();

    final cachedPath = getCachedFilePath(url);
    if (cachedPath != null) return cachedPath;

    if (_downloadFutures.containsKey(url)) {
      return await _downloadFutures[url];
    }

    final downloadFuture =
        _performDownload(url, onProgress: onProgress, cancelToken: cancelToken);
    _downloadFutures[url] = downloadFuture;

    try {
      final result = await downloadFuture;
      return result;
    } finally {
      _downloadFutures.remove(url);
    }
  }

  Future<String?> _performDownload(
    String url, {
    Function(int received, int total)? onProgress,
    CancelToken? cancelToken,
  }) async {
    try {
      final cacheKey = _generateCacheKey(url);
      final fileName = _generateFileName(url);
      final filePath = '${_cacheDirectory.path}/$fileName';

      await _dio.download(
        url,
        filePath,
        onReceiveProgress: onProgress,
        cancelToken: cancelToken,
      );

      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('Downloaded file does not exist');
      }

      final fileSize = await file.length();
      if (fileSize == 0) {
        await file.delete();
        throw Exception('Downloaded file is empty');
      }

      final cacheItem = CacheItem(
        url: url,
        filePath: filePath,
        cacheKey: cacheKey,
        fileSize: fileSize,
        createdAt: DateTime.now(),
        lastAccessTime: DateTime.now(),
        expiryTime: DateTime.now().add(_config.cacheDuration),
      );

      await _addToCacheIndex(cacheItem);
      await _enforceCacheSize();

      return filePath;
    } catch (e) {
      debugPrint('Cache download error for $url: $e');
      return null;
    }
  }

  /// Preload multiple URLs
  Future<void> preloadUrls(List<String> urls) async {
    final futures = urls.map((url) => downloadAndCache(url)).toList();
    await Future.wait(futures, eagerError: false);
  }

  /// Check if a URL is cached
  Future<bool> isCached(String url) async {
    final cachedPath = getCachedFilePath(url);
    return cachedPath != null;
  }

  /// Get cache statistics
  Future<CacheStats> getCacheStats() async {
    if (!_isInitialized) return CacheStats.empty();

    int totalFiles = _cacheIndex.length;
    int totalSize = 0;
    int expiredFiles = 0;

    for (final item in _cacheIndex.values) {
      totalSize += item.fileSize;
      if (DateTime.now().isAfter(item.expiryTime)) {
        expiredFiles++;
      }
    }

    return CacheStats(
      totalFiles: totalFiles,
      totalSize: totalSize,
      expiredFiles: expiredFiles,
      cacheDirectory: _cacheDirectory.path,
    );
  }

  /// Clear all cache
  Future<void> clearCache() async {
    try {
      for (final item in _cacheIndex.values) {
        final file = File(item.filePath);
        if (await file.exists()) {
          await file.delete();
        }
      }
      _cacheIndex.clear();
      await _saveCacheIndex();
    } catch (e) {
      debugPrint('Error clearing cache: $e');
    }
  }

  /// Add an alias entry pointing to an already-cached file. Used when a
  /// resource was downloaded via a different URL (e.g. server-side proxy)
  /// and should also be retrievable by the original URL on subsequent
  /// lookups via [getCachedFilePath].
  ///
  /// No-op if no cache entry exists for [existingUrl] or the alias entry
  /// already exists. Does not copy the file — both keys reference the
  /// same path.
  Future<void> linkCachedUrl(String aliasUrl, String existingUrl) async {
    if (!_isInitialized) return;
    final existingKey = _generateCacheKey(existingUrl);
    final existing = _cacheIndex[existingKey];
    if (existing == null) return;
    final aliasKey = _generateCacheKey(aliasUrl);
    if (_cacheIndex.containsKey(aliasKey)) return;
    _cacheIndex[aliasKey] = CacheItem(
      url: aliasUrl,
      filePath: existing.filePath,
      cacheKey: aliasKey,
      fileSize: existing.fileSize,
      createdAt: existing.createdAt,
      lastAccessTime: DateTime.now(),
      expiryTime: existing.expiryTime,
    );
    await _saveCacheIndex();
  }

  /// Remove specific URL from cache
  Future<void> removeCachedUrl(String url) async {
    if (!_isInitialized) return;

    final cacheKey = _generateCacheKey(url);
    final cacheItem = _cacheIndex[cacheKey];

    if (cacheItem != null) {
      final file = File(cacheItem.filePath);
      if (await file.exists()) {
        await file.delete();
      }
      _cacheIndex.remove(cacheKey);
      await _saveCacheIndex();
    }
  }

  String _generateCacheKey(String url) {
    return url_utils.generateCacheKey(url);
  }

  String _generateFileName(String url) {
    final uri = Uri.parse(url);
    final extension = uri.path.split('.').last;
    final cacheKey = _generateCacheKey(url);
    final shortKey = cacheKey.substring(0, 16);
    return '$shortKey.$extension';
  }

  Future<void> _loadCacheIndex() async {
    try {
      final file = File('${_cacheDirectory.path}/cache_index.json');
      if (await file.exists()) {
        final json =
            jsonDecode(await file.readAsString()) as Map<String, dynamic>;
        _cacheIndex.clear();
        _cacheIndex.addAll(json.map((key, value) =>
            MapEntry(key, CacheItem.fromJson(value as Map<String, dynamic>))));
      }
    } catch (e) {
      debugPrint('Error loading cache index: $e');
      _cacheIndex.clear();
    }
  }

  Future<void> _saveCacheIndex() async {
    try {
      final file = File('${_cacheDirectory.path}/cache_index.json');
      final json =
          _cacheIndex.map((key, value) => MapEntry(key, value.toJson()));
      await file.writeAsString(jsonEncode(json));
    } catch (e) {
      debugPrint('Error saving cache index: $e');
    }
  }

  Future<void> _cleanupExpiredCache() async {
    final now = DateTime.now();
    final expiredKeys = <String>[];

    for (final entry in _cacheIndex.entries) {
      if (now.isAfter(entry.value.expiryTime)) {
        expiredKeys.add(entry.key);
        final file = File(entry.value.filePath);
        if (await file.exists()) {
          try {
            await file.delete();
          } catch (e) {
            debugPrint('Error deleting expired cache file: $e');
          }
        }
      }
    }

    for (final key in expiredKeys) {
      _cacheIndex.remove(key);
    }

    if (expiredKeys.isNotEmpty) {
      await _saveCacheIndex();
      debugPrint('Cleaned up \\${expiredKeys.length} expired cache items');
    }
  }

  Future<void> _enforceCacheSize() async {
    final stats = await getCacheStats();
    if (stats.totalSize <= _config.maxCacheSize) return;

    final sortedItems = _cacheIndex.values.toList()
      ..sort((a, b) => a.lastAccessTime.compareTo(b.lastAccessTime));

    int currentSize = stats.totalSize;
    final itemsToRemove = <CacheItem>[];

    for (final item in sortedItems) {
      if (currentSize <= _config.maxCacheSize) break;
      itemsToRemove.add(item);
      currentSize -= item.fileSize;
    }

    for (final item in itemsToRemove) {
      final file = File(item.filePath);
      if (await file.exists()) {
        try {
          await file.delete();
        } catch (e) {
          debugPrint('Error deleting cache file: $e');
        }
      }
      _cacheIndex.remove(item.cacheKey);
    }

    if (itemsToRemove.isNotEmpty) {
      await _saveCacheIndex();
      debugPrint(
          'Removed ${itemsToRemove.length} cache items to enforce size limit');
    }
  }

  /// Clear in-memory caches (called on memory pressure).
  void clearMemoryCache() {
    _memoryFileCache.clear();
  }

  /// Cancel all ongoing downloads
  void cancelAllDownloads() {
    _downloadFutures.clear();
  }

  Future<void> _addToCacheIndex(CacheItem cacheItem) async {
    _cacheIndex[cacheItem.cacheKey] = cacheItem;
    await _saveCacheIndex();
    await _evictIfOverCacheSize();
  }

  Future<void> _evictIfOverCacheSize() async {
    int totalSize =
        _cacheIndex.values.fold(0, (sum, item) => sum + item.fileSize);
    if (totalSize <= _maxCacheFileSize) return;

    final sorted = _cacheIndex.values.toList()
      ..sort((a, b) => a.lastAccessTime.compareTo(b.lastAccessTime));

    final futures = <Future>[];
    for (final item in sorted) {
      if (totalSize <= _maxCacheFileSize) break;
      futures.add(() async {
        final file = File(item.filePath);
        if (await file.exists()) {
          await file.delete();
        }
        totalSize -= item.fileSize;
        _cacheIndex.remove(item.cacheKey);
        _memoryFileCache.remove(item.cacheKey);
      }());
    }
    await Future.wait(futures);
    await _saveCacheIndex();
  }

  /// Dispose the cache manager
  void dispose() {
    _downloadFutures.clear();
  }
}
