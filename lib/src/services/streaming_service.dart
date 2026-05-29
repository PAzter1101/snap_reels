import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';
import 'package:snap_reels/src/services/cache_manager.dart';

/// Service for handling advanced video streaming with HLS, DASH, and MP4.
///
/// Resolves the optimal streaming URL based on platform, network conditions,
/// and caching state. Players are managed by the ReelController pool.
class StreamingService {
  /// Returns the singleton instance.
  factory StreamingService() => _instance;
  StreamingService._internal();
  static final StreamingService _instance = StreamingService._internal();

  /// Resolve the best URL for the given reel and streaming config.
  ///
  /// Returns a cached file path (prefixed with `file://`) when available,
  /// otherwise the original network URL.
  Future<String> resolveStreamingUrl(
    ReelModel reel,
    StreamingConfig config,
  ) async {
    final videoSource = reel.videoSource;
    final format = await _determineOptimalFormat(videoSource, config);
    final url = videoSource.getUrlForFormat(format);

    // Check cache first.
    if (config.enableCaching) {
      final cachedPath = CacheManager().getCachedFilePath(url);
      if (cachedPath != null) return 'file://$cachedPath';

      // Trigger background caching.
      unawaited(
        Future<void>.microtask(() => CacheManager().downloadAndCache(url)),
      );
    }

    return url;
  }

  Future<VideoFormat> _determineOptimalFormat(
    VideoSource videoSource,
    StreamingConfig config,
  ) async {
    switch (config.preferredFormat) {
      case PreferredStreamingFormat.hls:
        if (videoSource.hasFormat(VideoFormat.hls)) return VideoFormat.hls;
      case PreferredStreamingFormat.dash:
        if (videoSource.hasFormat(VideoFormat.dash)) return VideoFormat.dash;
      case PreferredStreamingFormat.mp4:
        if (videoSource.hasFormat(VideoFormat.mp4)) return VideoFormat.mp4;
      case PreferredStreamingFormat.auto:
        final isLowBandwidth = await _isLowBandwidth();
        final isMobile = await _isMobileNetwork();

        if (isLowBandwidth || isMobile) {
          if (videoSource.hasFormat(VideoFormat.mp4)) return VideoFormat.mp4;
        } else {
          if (Platform.isIOS && videoSource.hasFormat(VideoFormat.hls)) {
            return VideoFormat.hls;
          }
          if (Platform.isAndroid && videoSource.hasFormat(VideoFormat.dash)) {
            return VideoFormat.dash;
          }
        }
    }

    if (videoSource.hasFormat(VideoFormat.hls)) return VideoFormat.hls;
    if (videoSource.hasFormat(VideoFormat.dash)) return VideoFormat.dash;
    if (videoSource.hasFormat(VideoFormat.mp4)) return VideoFormat.mp4;

    return videoSource.format;
  }

  Future<bool> _isLowBandwidth() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isEmpty;
    } catch (e) {
      return true;
    }
  }

  Future<bool> _isMobileNetwork() async {
    try {
      final connectivityResults = await Connectivity().checkConnectivity();
      return connectivityResults.contains(ConnectivityResult.mobile);
    } catch (e) {
      return false;
    }
  }

  /// Check if streaming format is supported on current platform
  bool isFormatSupported(VideoFormat format) {
    switch (format) {
      case VideoFormat.hls:
        return Platform.isIOS || Platform.isAndroid;
      case VideoFormat.dash:
        return Platform.isAndroid;
      case VideoFormat.mp4:
        return true;
    }
  }

  /// Get recommended formats for current platform
  List<VideoFormat> getRecommendedFormats() {
    if (Platform.isIOS) {
      return [VideoFormat.hls, VideoFormat.mp4];
    } else if (Platform.isAndroid) {
      return [VideoFormat.hls, VideoFormat.dash, VideoFormat.mp4];
    } else {
      return [VideoFormat.mp4];
    }
  }
}
