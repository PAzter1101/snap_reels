/// Configuration for caching
class CacheConfig {
  /// Maximum cache size in bytes (default: 100MB)
  final int maxCacheSize;

  /// Cache duration (default: 7 days)
  final Duration cacheDuration;

  /// Number of videos to preload (default: 2)
  final int preloadCount;

  /// Whether to cache thumbnails
  final bool cacheThumbnails;

  /// Custom cache directory name
  final String? cacheDirectoryName;

  const CacheConfig({
    this.maxCacheSize = 100 * 1024 * 1024, // 100MB
    this.cacheDuration = const Duration(days: 7),
    this.preloadCount = 2,
    this.cacheThumbnails = true,
    this.cacheDirectoryName,
  });
}

/// Configuration for preloading
class PreloadConfig {
  /// Number of videos to preload ahead
  final int preloadAhead;

  /// Number of videos to preload behind
  final int preloadBehind;

  /// Whether to preload on WiFi only
  final bool preloadOnWiFiOnly;

  /// Maximum videos to keep preloaded
  final int maxPreloaded;

  /// Automatically reduce preload on low-end devices.
  final bool adaptivePreload;

  const PreloadConfig({
    this.preloadAhead = 2,
    this.preloadBehind = 1,
    this.preloadOnWiFiOnly = false,
    this.maxPreloaded = 5,
    this.adaptivePreload = true,
  });

  PreloadConfig copyWith({
    int? preloadAhead,
    int? preloadBehind,
    bool? preloadOnWiFiOnly,
    int? maxPreloaded,
    bool? adaptivePreload,
  }) {
    return PreloadConfig(
      preloadAhead: preloadAhead ?? this.preloadAhead,
      preloadBehind: preloadBehind ?? this.preloadBehind,
      preloadOnWiFiOnly: preloadOnWiFiOnly ?? this.preloadOnWiFiOnly,
      maxPreloaded: maxPreloaded ?? this.maxPreloaded,
      adaptivePreload: adaptivePreload ?? this.adaptivePreload,
    );
  }
}
