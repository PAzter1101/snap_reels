import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:snap_reels/src/models/converters.dart';

part 'reel_analytics.freezed.dart';
part 'reel_analytics.g.dart';

/// Analytics data model for tracking reel interactions and performance.
@freezed
abstract class ReelAnalytics with _$ReelAnalytics {
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

  factory ReelAnalytics.fromJson(Map<String, Object?> json) =>
      _$ReelAnalyticsFromJson(json);
}

/// Device information attached to an analytics session.
@freezed
abstract class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    required String platform,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    String? screenResolution,
    String? networkType,
    double? batteryLevel,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, Object?> json) =>
      _$DeviceInfoFromJson(json);
}

/// Discrete playback events recorded during a session.
enum PlaybackEventType {
  started,
  paused,
  resumed,
  completed,
  seeked,
  buffering,
  error,
  qualityChanged,
  volumeChanged,
  speedChanged,
}

/// Playback event with position and optional metadata.
@freezed
abstract class PlaybackEvent with _$PlaybackEvent {
  const factory PlaybackEvent({
    required PlaybackEventType type,
    required DateTime timestamp,
    @DurationMillisConverter() required Duration position,
    @NullableDurationMillisConverter() Duration? duration,
    Map<String, dynamic>? metadata,
  }) = _PlaybackEvent;

  factory PlaybackEvent.fromJson(Map<String, Object?> json) =>
      _$PlaybackEventFromJson(json);
}

/// User interactions recorded during a session.
enum InteractionEventType {
  like,
  unlike,
  comment,
  share,
  follow,
  unfollow,
  tap,
  doubleTap,
  longPress,
  swipeUp,
  swipeDown,
  swipeLeft,
  swipeRight,
  volumeToggle,
  fullscreenEnter,
  fullscreenExit,
}

/// Interaction event captured at a specific video position.
@freezed
abstract class InteractionEvent with _$InteractionEvent {
  const factory InteractionEvent({
    required InteractionEventType type,
    required DateTime timestamp,
    @DurationMillisConverter() required Duration videoPosition,
    Map<String, dynamic>? metadata,
  }) = _InteractionEvent;

  factory InteractionEvent.fromJson(Map<String, Object?> json) =>
      _$InteractionEventFromJson(json);
}

/// Runtime performance metrics aggregated for a reel session.
@freezed
abstract class PerformanceMetrics with _$PerformanceMetrics {
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

  factory PerformanceMetrics.fromJson(Map<String, Object?> json) =>
      _$PerformanceMetricsFromJson(json);

  double get frameDropRate =>
      totalFrames == 0 ? 0 : droppedFrames / totalFrames;

  bool get isPerformanceGood =>
      frameDropRate < 0.05 &&
      bufferingCount < 3 &&
      totalBufferingTime.inSeconds < 5;
}
