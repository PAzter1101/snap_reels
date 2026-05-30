import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:snap_reels/src/models/cache_item.dart';

/// Removes expired and least-recently-used entries from a cache index.
/// Operates in-place; collapses entries sharing a `filePath`.
class CacheEvictor {
  const CacheEvictor._();

  /// Drops entries whose [CacheItem.expiryTime] has passed and deletes
  /// their files. Returns the keys that were removed (including aliases).
  static Future<List<String>> evictExpired(
    Map<String, CacheItem> index,
  ) async {
    final now = DateTime.now();
    final expiredPaths = <String>{
      for (final entry in index.entries)
        if (now.isAfter(entry.value.expiryTime)) entry.value.filePath,
    };
    if (expiredPaths.isEmpty) return const [];
    for (final path in expiredPaths) {
      await _deleteFile(path);
    }
    return _removeByFilePath(index, expiredPaths);
  }

  /// Drops least-recently-used entries until the total size fits inside
  /// [maxBytes]. Entries sharing a `filePath` are collapsed by path.
  static Future<List<CacheItem>> evictToFit(
    Map<String, CacheItem> index,
    int maxBytes,
  ) async {
    final sizeByPath = <String, int>{};
    final oldestByPath = <String, DateTime>{};
    for (final item in index.values) {
      sizeByPath[item.filePath] =
          (sizeByPath[item.filePath] ?? 0) + item.fileSize;
      final current = oldestByPath[item.filePath];
      if (current == null || item.lastAccessTime.isBefore(current)) {
        oldestByPath[item.filePath] = item.lastAccessTime;
      }
    }

    final totalSize = sizeByPath.values.fold<int>(0, (sum, v) => sum + v);
    if (totalSize <= maxBytes) return const [];

    final paths = sizeByPath.keys.toList()
      ..sort((a, b) => oldestByPath[a]!.compareTo(oldestByPath[b]!));

    var remaining = totalSize;
    final removedPaths = <String>{};
    for (final path in paths) {
      if (remaining <= maxBytes) break;
      removedPaths.add(path);
      remaining -= sizeByPath[path]!;
    }

    for (final path in removedPaths) {
      await _deleteFile(path);
    }
    final removed = [
      for (final entry in index.entries)
        if (removedPaths.contains(entry.value.filePath)) entry.value,
    ];
    _removeByFilePath(index, removedPaths);
    return removed;
  }

  static List<String> _removeByFilePath(
    Map<String, CacheItem> index,
    Set<String> paths,
  ) {
    final keys = [
      for (final entry in index.entries)
        if (paths.contains(entry.value.filePath)) entry.key,
    ];
    keys.forEach(index.remove);
    return keys;
  }

  static Future<void> _deleteFile(String path) async {
    final file = File(path);
    if (!file.existsSync()) return;
    try {
      await file.delete();
    } catch (e) {
      debugPrint('Error deleting cache file $path: $e');
    }
  }
}
