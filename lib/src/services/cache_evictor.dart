import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:snap_reels/src/models/cache_item.dart';

/// Removes expired and least-recently-used entries from a cache index.
///
/// All methods operate in-place on the passed `index` map. File deletion
/// errors are logged and swallowed; the index entry is still removed so
/// the state stays consistent with reality.
class CacheEvictor {
  const CacheEvictor._();

  /// Drops entries whose [CacheItem.expiryTime] has passed and deletes
  /// their files. Returns the keys that were removed.
  static Future<List<String>> evictExpired(
    Map<String, CacheItem> index,
  ) async {
    final now = DateTime.now();
    final expiredKeys = <String>[];
    for (final entry in index.entries) {
      if (now.isAfter(entry.value.expiryTime)) {
        expiredKeys.add(entry.key);
        await _deleteFile(entry.value.filePath);
      }
    }
    expiredKeys.forEach(index.remove);
    return expiredKeys;
  }

  /// Drops least-recently-used entries until the total size fits inside
  /// [maxBytes]. Returns the entries that were evicted.
  static Future<List<CacheItem>> evictToFit(
    Map<String, CacheItem> index,
    int maxBytes,
  ) async {
    final totalSize = index.values.fold<int>(
      0,
      (sum, item) => sum + item.fileSize,
    );
    if (totalSize <= maxBytes) return const [];

    final sorted = index.values.toList()
      ..sort((a, b) => a.lastAccessTime.compareTo(b.lastAccessTime));

    var remaining = totalSize;
    final removed = <CacheItem>[];
    for (final item in sorted) {
      if (remaining <= maxBytes) break;
      removed.add(item);
      remaining -= item.fileSize;
    }

    for (final item in removed) {
      await _deleteFile(item.filePath);
      index.remove(item.cacheKey);
    }
    return removed;
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
