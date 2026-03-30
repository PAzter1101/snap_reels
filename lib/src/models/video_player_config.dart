import 'package:flutter/material.dart';

import 'streaming_config.dart';

/// Configuration for video player
class VideoPlayerConfig {
  /// Whether to show video controls
  final bool showControls;

  /// Whether to allow fullscreen
  final bool allowFullScreen;

  /// Whether to show video title
  final bool showTitle;

  /// Whether to show subtitle
  final bool showSubtitle;

  /// Aspect ratio for the video player
  final double? aspectRatio;

  /// Video fit mode
  final BoxFit videoFit;

  /// Whether to start video muted
  final bool startMuted;

  /// Default volume (0.0 to 1.0)
  final double defaultVolume;

  /// Video playback speed options
  final List<double> playbackSpeeds;

  /// Default playback speed
  final double defaultPlaybackSpeed;

  /// Whether to show playback speed controls
  final bool showPlaybackSpeedControls;

  /// Buffer configuration
  final VideoBufferConfig bufferConfig;

  /// Streaming configuration
  final StreamingConfig streamingConfig;

  /// Enable hardware acceleration
  final bool enableHardwareAcceleration;

  /// Enable picture-in-picture mode
  final bool enablePictureInPicture;

  const VideoPlayerConfig({
    this.showControls = false,
    this.allowFullScreen = false,
    this.showTitle = false,
    this.showSubtitle = false,
    this.aspectRatio,
    this.videoFit = BoxFit.cover,
    this.startMuted = false,
    this.defaultVolume = 1.0,
    this.playbackSpeeds = const [0.5, 0.75, 1.0, 1.25, 1.5, 2.0],
    this.defaultPlaybackSpeed = 1.0,
    this.showPlaybackSpeedControls = false,
    this.bufferConfig = const VideoBufferConfig(),
    this.streamingConfig = const StreamingConfig(),
    this.enableHardwareAcceleration = true,
    this.enablePictureInPicture = false,
  });

  VideoPlayerConfig copyWith({
    bool? showControls,
    bool? allowFullScreen,
    bool? showTitle,
    bool? showSubtitle,
    double? aspectRatio,
    BoxFit? videoFit,
    bool? startMuted,
    double? defaultVolume,
    List<double>? playbackSpeeds,
    double? defaultPlaybackSpeed,
    bool? showPlaybackSpeedControls,
    VideoBufferConfig? bufferConfig,
    StreamingConfig? streamingConfig,
    bool? enableHardwareAcceleration,
    bool? enablePictureInPicture,
  }) {
    return VideoPlayerConfig(
      showControls: showControls ?? this.showControls,
      allowFullScreen: allowFullScreen ?? this.allowFullScreen,
      showTitle: showTitle ?? this.showTitle,
      showSubtitle: showSubtitle ?? this.showSubtitle,
      aspectRatio: aspectRatio ?? this.aspectRatio,
      videoFit: videoFit ?? this.videoFit,
      startMuted: startMuted ?? this.startMuted,
      defaultVolume: defaultVolume ?? this.defaultVolume,
      playbackSpeeds: playbackSpeeds ?? this.playbackSpeeds,
      defaultPlaybackSpeed: defaultPlaybackSpeed ?? this.defaultPlaybackSpeed,
      showPlaybackSpeedControls:
          showPlaybackSpeedControls ?? this.showPlaybackSpeedControls,
      bufferConfig: bufferConfig ?? this.bufferConfig,
      streamingConfig: streamingConfig ?? this.streamingConfig,
      enableHardwareAcceleration:
          enableHardwareAcceleration ?? this.enableHardwareAcceleration,
      enablePictureInPicture:
          enablePictureInPicture ?? this.enablePictureInPicture,
    );
  }
}

/// Configuration for video buffering
class VideoBufferConfig {
  /// Minimum buffer duration
  final Duration minBufferDuration;

  /// Maximum buffer duration
  final Duration maxBufferDuration;

  /// Buffer duration for rebuffering
  final Duration bufferForPlaybackDuration;

  /// Buffer duration after rebuffering
  final Duration bufferForPlaybackAfterRebufferDuration;

  const VideoBufferConfig({
    this.minBufferDuration = const Duration(seconds: 15),
    this.maxBufferDuration = const Duration(seconds: 50),
    this.bufferForPlaybackDuration = const Duration(milliseconds: 2500),
    this.bufferForPlaybackAfterRebufferDuration = const Duration(seconds: 5),
  });
}
