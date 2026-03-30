/// Cache item data model
class CacheItem {
  final String cacheKey;
  final String filePath;
  final String url;
  final DateTime createdAt;
  final int fileSize;
  DateTime lastAccessTime; // Mutable for LRU tracking
  final DateTime expiryTime;

  CacheItem({
    required this.cacheKey,
    required this.filePath,
    required this.url,
    required this.createdAt,
    required this.fileSize,
    required this.lastAccessTime,
    required this.expiryTime,
  });

  bool get isExpired => DateTime.now().isAfter(expiryTime);

  Map<String, dynamic> toJson() => {
        'cacheKey': cacheKey,
        'filePath': filePath,
        'url': url,
        'createdAt': createdAt.toIso8601String(),
        'fileSize': fileSize,
        'lastAccessTime': lastAccessTime.toIso8601String(),
        'expiryTime': expiryTime.toIso8601String(),
      };

  factory CacheItem.fromJson(Map<String, dynamic> json) => CacheItem(
        cacheKey: json['cacheKey'] as String,
        filePath: json['filePath'] as String,
        url: json['url'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        fileSize: json['fileSize'] as int,
        lastAccessTime: DateTime.parse(json['lastAccessTime'] as String),
        expiryTime: DateTime.parse(json['expiryTime'] as String),
      );
}

/// Cache statistics
class CacheStats {
  final int totalFiles;
  final int totalSize;
  final int expiredFiles;
  final String cacheDirectory;

  const CacheStats({
    required this.totalFiles,
    required this.totalSize,
    required this.expiredFiles,
    required this.cacheDirectory,
  });

  factory CacheStats.empty() {
    return const CacheStats(
      totalFiles: 0,
      totalSize: 0,
      expiredFiles: 0,
      cacheDirectory: '',
    );
  }

  /// Get human readable size
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

  @override
  String toString() {
    return 'CacheStats(files: $totalFiles, size: $humanReadableSize, expired: $expiredFiles)';
  }
}
