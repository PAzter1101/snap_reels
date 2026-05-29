import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:snap_reels/src/models/converters.dart';

part 'reel_analytics.freezed.dart';
part 'reel_analytics.g.dart';

/// Analytics data model for tracking reel interactions and performance.
@freezed
abstract class ReelAnalytics with _$ReelAnalytics {
  /// Creates an analytics record for a single reel session.
  const factory ReelAnalytics({
    required String sessionId,
    required String reelId,
    required DeviceInfo deviceInfo,
    required PerformanceMetrics performanceMetrics,
    required DateTime sessionStartTime,
    String? userId,
    @Default(<PlaybackEvent>[]) List<PlaybackEvent> playbackEvents,
    @Default(<InteractionEvent>[]) List<InteractionEvent> interactionEvents,
    DateTime? sessionEndTime,
  }) = _ReelAnalytics;

  /// Deserializes a [ReelAnalytics] from JSON.
  factory ReelAnalytics.fromJson(Map<String, Object?> json) =>
      _$ReelAnalyticsFromJson(json);
}

/// Device information attached to an analytics session.
@freezed
abstract class DeviceInfo with _$DeviceInfo {
  /// Creates a [DeviceInfo] snapshot.
  const factory DeviceInfo({
    required String platform,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    String? screenResolution,
    String? networkType,
    double? batteryLevel,
  }) = _DeviceInfo;

  /// Deserializes a [DeviceInfo] from JSON.
  factory DeviceInfo.fromJson(Map<String, Object?> json) =>
      _$DeviceInfoFromJson(json);
}

/// Discrete playback events recorded during a session.
enum PlaybackEventType {
  /// Playback started for the first time in this session.
  started,

  /// Playback was paused.
  paused,

  /// Playback resumed after a pause.
  resumed,

  /// Playback reached the end of the video.
  completed,

  /// Playback position changed via a seek.
  seeked,

  /// Player entered a buffering state.
  buffering,

  /// Playback failed with an error.
  error,

  /// Stream quality (bitrate/resolution) changed.
  qualityChanged,

  /// Output volume changed.
  volumeChanged,

  /// Playback speed changed.
  speedChanged,
}

/// Playback event with position and optional metadata.
@freezed
abstract class PlaybackEvent with _$PlaybackEvent {
  /// Creates a playback event.
  const factory PlaybackEvent({
    required PlaybackEventType type,
    required DateTime timestamp,
    @DurationMillisConverter() required Duration position,
    @NullableDurationMillisConverter() Duration? duration,
    Map<String, dynamic>? metadata,
  }) = _PlaybackEvent;

  /// Deserializes a [PlaybackEvent] from JSON.
  factory PlaybackEvent.fromJson(Map<String, Object?> json) =>
      _$PlaybackEventFromJson(json);
}

/// User interactions recorded during a session.
enum InteractionEventType {
  /// User liked the reel.
  like,

  /// User removed a previously set like.
  unlike,

  /// User opened the comments UI.
  comment,

  /// User tapped the share action.
  share,

  /// User followed the reel author.
  follow,

  /// User unfollowed the reel author.
  unfollow,

  /// Single tap on the reel surface.
  tap,

  /// Double tap on the reel surface (typically maps to like).
  doubleTap,

  /// Long press on the reel surface.
  longPress,

  /// Swipe gesture going up.
  swipeUp,

  /// Swipe gesture going down.
  swipeDown,

  /// Swipe gesture going left.
  swipeLeft,

  /// Swipe gesture going right.
  swipeRight,

  /// User toggled mute/unmute.
  volumeToggle,

  /// User entered fullscreen mode.
  fullscreenEnter,

  /// User exited fullscreen mode.
  fullscreenExit,
}

/// Interaction event captured at a specific video position.
@freezed
abstract class InteractionEvent with _$InteractionEvent {
  /// Creates an interaction event.
  const factory InteractionEvent({
    required InteractionEventType type,
    required DateTime timestamp,
    @DurationMillisConverter() required Duration videoPosition,
    Map<String, dynamic>? metadata,
  }) = _InteractionEvent;

  /// Deserializes an [InteractionEvent] from JSON.
  factory InteractionEvent.fromJson(Map<String, Object?> json) =>
      _$InteractionEventFromJson(json);
}

/// Runtime performance metrics aggregated for a reel session.
@freezed
abstract class PerformanceMetrics with _$PerformanceMetrics {
  /// Creates a [PerformanceMetrics] aggregate.
  const factory PerformanceMetrics({
    @NullableDurationMillisConverter() Duration? timeToFirstFrame,
    @NullableDurationMillisConverter() Duration? loadTime,
    @Default(0) int bufferingCount,
    @DurationMillisConverter()
    @Default(Duration.zero)
    Duration totalBufferingTime,
    double? averageBitrate,
    @Default(0) int droppedFrames,
    @Default(0) int totalFrames,
    int? memoryUsage,
    double? cpuUsage,
    @Default(0) int networkUsage,
    double? cacheHitRatio,
  }) = _PerformanceMetrics;

  const PerformanceMetrics._();

  /// Deserializes a [PerformanceMetrics] from JSON.
  factory PerformanceMetrics.fromJson(Map<String, Object?> json) =>
      _$PerformanceMetricsFromJson(json);

  /// Fraction of [droppedFrames] over [totalFrames]; `0` when no frames yet.
  double get frameDropRate =>
      totalFrames == 0 ? 0 : droppedFrames / totalFrames;

  /// Heuristic: < 5% frame drops, < 3 stalls, < 5s total buffering.
  bool get isPerformanceGood =>
      frameDropRate < 0.05 &&
      bufferingCount < 3 &&
      totalBufferingTime.inSeconds < 5;
}
