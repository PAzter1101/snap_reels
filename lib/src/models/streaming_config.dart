/// Enum for preferred streaming format
enum PreferredStreamingFormat {
  hls,
  dash,
  mp4,
  auto, // Automatically choose best format
}

/// Extension for PreferredStreamingFormat
extension PreferredStreamingFormatExtension on PreferredStreamingFormat {
  String get name {
    switch (this) {
      case PreferredStreamingFormat.hls:
        return 'hls';
      case PreferredStreamingFormat.dash:
        return 'dash';
      case PreferredStreamingFormat.mp4:
        return 'mp4';
      case PreferredStreamingFormat.auto:
        return 'auto';
    }
  }
}

/// Configuration for streaming
class StreamingConfig {
  /// Preferred streaming format (default: HLS)
  final PreferredStreamingFormat preferredFormat;

  /// Enable adaptive bitrate streaming.
  ///
  /// Not implemented — `video_player` does not expose bitrate control.
  @Deprecated('Has no effect. Will be removed in v2.0.')
  final bool enableAdaptiveBitrate;

  /// Enable low latency streaming for HLS
  final bool enableLowLatency;

  /// Maximum bitrate for streaming (in kbps)
  final int? maxBitrate;

  /// Minimum bitrate for streaming (in kbps)
  final int? minBitrate;

  /// Enable subtitle support
  final bool enableSubtitles;

  /// Enable audio track selection
  final bool enableAudioTrackSelection;

  /// Enable quality selection
  final bool enableQualitySelection;

  /// Fallback to MP4 if streaming fails
  final bool fallbackToMp4;

  /// Network timeout for streaming (in seconds)
  final int networkTimeout;

  /// Retry attempts for failed streams
  final int retryAttempts;

  /// Enable DRM support
  final bool enableDrm;

  /// DRM configuration
  final Map<String, String>? drmHeaders;

  /// Enable caching
  final bool enableCaching;

  /// Initial volume
  final double initialVolume;

  const StreamingConfig({
    this.preferredFormat = PreferredStreamingFormat.auto,
    this.enableAdaptiveBitrate = true,
    this.enableLowLatency = false,
    this.maxBitrate,
    this.minBitrate,
    this.enableSubtitles = true,
    this.enableAudioTrackSelection = true,
    this.enableQualitySelection = true,
    this.fallbackToMp4 = true,
    this.networkTimeout = 30,
    this.retryAttempts = 3,
    this.enableDrm = false,
    this.drmHeaders,
    this.enableCaching = true,
    this.initialVolume = 1.0,
  });

  StreamingConfig copyWith({
    PreferredStreamingFormat? preferredFormat,
    bool? enableAdaptiveBitrate,
    bool? enableLowLatency,
    int? maxBitrate,
    int? minBitrate,
    bool? enableSubtitles,
    bool? enableAudioTrackSelection,
    bool? enableQualitySelection,
    bool? fallbackToMp4,
    int? networkTimeout,
    int? retryAttempts,
    bool? enableDrm,
    Map<String, String>? drmHeaders,
    bool? enableCaching,
    double? initialVolume,
  }) {
    return StreamingConfig(
      preferredFormat: preferredFormat ?? this.preferredFormat,
      enableAdaptiveBitrate:
          enableAdaptiveBitrate ?? this.enableAdaptiveBitrate,
      enableLowLatency: enableLowLatency ?? this.enableLowLatency,
      maxBitrate: maxBitrate ?? this.maxBitrate,
      minBitrate: minBitrate ?? this.minBitrate,
      enableSubtitles: enableSubtitles ?? this.enableSubtitles,
      enableAudioTrackSelection:
          enableAudioTrackSelection ?? this.enableAudioTrackSelection,
      enableQualitySelection:
          enableQualitySelection ?? this.enableQualitySelection,
      fallbackToMp4: fallbackToMp4 ?? this.fallbackToMp4,
      networkTimeout: networkTimeout ?? this.networkTimeout,
      retryAttempts: retryAttempts ?? this.retryAttempts,
      enableDrm: enableDrm ?? this.enableDrm,
      drmHeaders: drmHeaders ?? this.drmHeaders,
      enableCaching: enableCaching ?? this.enableCaching,
      initialVolume: initialVolume ?? this.initialVolume,
    );
  }
}
