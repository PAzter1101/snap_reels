import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:snap_reels/src/models/cache_item.dart';

/// JSON-backed persistence for the cache index.
class CacheIndexStorage {
  /// Creates a storage rooted at [directory].
  CacheIndexStorage(this.directory);

  /// Directory holding the index file.
  final Directory directory;

  File get _indexFile => File('${directory.path}/cache_index.json');

  /// Loads the index from disk; empty map on missing/unreadable file.
  Future<Map<String, CacheItem>> load() async {
    try {
      final file = _indexFile;
      if (!file.existsSync()) return <String, CacheItem>{};
      final raw = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
      return raw.map(
        (key, value) =>
            MapEntry(key, CacheItem.fromJson(value as Map<String, dynamic>)),
      );
    } catch (e) {
      debugPrint('Error loading cache index: $e');
      return <String, CacheItem>{};
    }
  }

  /// Persists [index] to disk.
  Future<void> save(Map<String, CacheItem> index) async {
    try {
      final encoded = index.map(
        (key, value) => MapEntry(key, value.toJson()),
      );
      await _indexFile.writeAsString(jsonEncode(encoded));
    } catch (e) {
      debugPrint('Error saving cache index: $e');
    }
  }
}
