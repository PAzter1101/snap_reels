import 'package:freezed_annotation/freezed_annotation.dart';

part 'cache_item.freezed.dart';
part 'cache_item.g.dart';

/// On-disk cache entry tracked by the LRU manager.
@freezed
abstract class CacheItem with _$CacheItem {
  /// Creates a [CacheItem] for a single cached file.
  const factory CacheItem({
    required String cacheKey,
    required String filePath,
    required String url,
    required DateTime createdAt,
    required int fileSize,
    required DateTime lastAccessTime,
    required DateTime expiryTime,
  }) = _CacheItem;

  const CacheItem._();

  /// Deserializes a [CacheItem] from JSON.
  factory CacheItem.fromJson(Map<String, Object?> json) =>
      _$CacheItemFromJson(json);

  /// True once the entry's [expiryTime] has passed.
  bool get isExpired => DateTime.now().isAfter(expiryTime);
}

/// Snapshot of cache directory state for diagnostics and UI.
@freezed
abstract class CacheStats with _$CacheStats {
  /// Creates a [CacheStats] aggregate.
  const factory CacheStats({
    required int totalFiles,
    required int totalSize,
    required int expiredFiles,
    required String cacheDirectory,
  }) = _CacheStats;

  const CacheStats._();

  /// Empty stats, useful as an initial value before the cache is scanned.
  factory CacheStats.empty() => const CacheStats(
    totalFiles: 0,
    totalSize: 0,
    expiredFiles: 0,
    cacheDirectory: '',
  );

  /// Human-readable size with binary unit suffix.
  String get humanReadableSize {
    if (totalSize < 1024) return '${totalSize}B';
    if (totalSize < 1024 * 1024) {
      return '${(totalSize / 1024).toStringAsFixed(1)}KB';
    }
    if (totalSize < 1024 * 1024 * 1024) {
      return '${(totalSize / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
    return '${(totalSize / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }
}
