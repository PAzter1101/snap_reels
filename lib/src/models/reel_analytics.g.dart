// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel_analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReelAnalytics _$ReelAnalyticsFromJson(Map<String, dynamic> json) =>
    _ReelAnalytics(
      sessionId: json['sessionId'] as String,
      reelId: json['reelId'] as String,
      deviceInfo: DeviceInfo.fromJson(
        json['deviceInfo'] as Map<String, dynamic>,
      ),
      performanceMetrics: PerformanceMetrics.fromJson(
        json['performanceMetrics'] as Map<String, dynamic>,
      ),
      sessionStartTime: DateTime.parse(json['sessionStartTime'] as String),
      userId: json['userId'] as String?,
      playbackEvents:
          (json['playbackEvents'] as List<dynamic>?)
              ?.map((e) => PlaybackEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PlaybackEvent>[],
      interactionEvents:
          (json['interactionEvents'] as List<dynamic>?)
              ?.map((e) => InteractionEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <InteractionEvent>[],
      sessionEndTime: json['sessionEndTime'] == null
          ? null
          : DateTime.parse(json['sessionEndTime'] as String),
    );

Map<String, dynamic> _$ReelAnalyticsToJson(_ReelAnalytics instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'reelId': instance.reelId,
      'deviceInfo': instance.deviceInfo,
      'performanceMetrics': instance.performanceMetrics,
      'sessionStartTime': instance.sessionStartTime.toIso8601String(),
      'userId': instance.userId,
      'playbackEvents': instance.playbackEvents,
      'interactionEvents': instance.interactionEvents,
      'sessionEndTime': instance.sessionEndTime?.toIso8601String(),
    };

_DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => _DeviceInfo(
  platform: json['platform'] as String,
  deviceModel: json['deviceModel'] as String?,
  osVersion: json['osVersion'] as String?,
  appVersion: json['appVersion'] as String?,
  screenResolution: json['screenResolution'] as String?,
  networkType: json['networkType'] as String?,
  batteryLevel: (json['batteryLevel'] as num?)?.toDouble(),
);

Map<String, dynamic> _$DeviceInfoToJson(_DeviceInfo instance) =>
    <String, dynamic>{
      'platform': instance.platform,
      'deviceModel': instance.deviceModel,
      'osVersion': instance.osVersion,
      'appVersion': instance.appVersion,
      'screenResolution': instance.screenResolution,
      'networkType': instance.networkType,
      'batteryLevel': instance.batteryLevel,
    };

_PlaybackEvent _$PlaybackEventFromJson(Map<String, dynamic> json) =>
    _PlaybackEvent(
      type: $enumDecode(_$PlaybackEventTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      position: const DurationMillisConverter().fromJson(
        (json['position'] as num).toInt(),
      ),
      duration: const NullableDurationMillisConverter().fromJson(
        (json['duration'] as num?)?.toInt(),
      ),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PlaybackEventToJson(
  _PlaybackEvent instance,
) => <String, dynamic>{
  'type': _$PlaybackEventTypeEnumMap[instance.type]!,
  'timestamp': instance.timestamp.toIso8601String(),
  'position': const DurationMillisConverter().toJson(instance.position),
  'duration': const NullableDurationMillisConverter().toJson(instance.duration),
  'metadata': instance.metadata,
};

const _$PlaybackEventTypeEnumMap = {
  PlaybackEventType.started: 'started',
  PlaybackEventType.paused: 'paused',
  PlaybackEventType.resumed: 'resumed',
  PlaybackEventType.completed: 'completed',
  PlaybackEventType.seeked: 'seeked',
  PlaybackEventType.buffering: 'buffering',
  PlaybackEventType.error: 'error',
  PlaybackEventType.qualityChanged: 'qualityChanged',
  PlaybackEventType.volumeChanged: 'volumeChanged',
  PlaybackEventType.speedChanged: 'speedChanged',
};

_InteractionEvent _$InteractionEventFromJson(Map<String, dynamic> json) =>
    _InteractionEvent(
      type: $enumDecode(_$InteractionEventTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      videoPosition: const DurationMillisConverter().fromJson(
        (json['videoPosition'] as num).toInt(),
      ),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$InteractionEventToJson(_InteractionEvent instance) =>
    <String, dynamic>{
      'type': _$InteractionEventTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'videoPosition': const DurationMillisConverter().toJson(
        instance.videoPosition,
      ),
      'metadata': instance.metadata,
    };

const _$InteractionEventTypeEnumMap = {
  InteractionEventType.like: 'like',
  InteractionEventType.unlike: 'unlike',
  InteractionEventType.comment: 'comment',
  InteractionEventType.share: 'share',
  InteractionEventType.follow: 'follow',
  InteractionEventType.unfollow: 'unfollow',
  InteractionEventType.tap: 'tap',
  InteractionEventType.doubleTap: 'doubleTap',
  InteractionEventType.longPress: 'longPress',
  InteractionEventType.swipeUp: 'swipeUp',
  InteractionEventType.swipeDown: 'swipeDown',
  InteractionEventType.swipeLeft: 'swipeLeft',
  InteractionEventType.swipeRight: 'swipeRight',
  InteractionEventType.volumeToggle: 'volumeToggle',
  InteractionEventType.fullscreenEnter: 'fullscreenEnter',
  InteractionEventType.fullscreenExit: 'fullscreenExit',
};

_PerformanceMetrics _$PerformanceMetricsFromJson(Map<String, dynamic> json) =>
    _PerformanceMetrics(
      timeToFirstFrame: const NullableDurationMillisConverter().fromJson(
        (json['timeToFirstFrame'] as num?)?.toInt(),
      ),
      loadTime: const NullableDurationMillisConverter().fromJson(
        (json['loadTime'] as num?)?.toInt(),
      ),
      bufferingCount: (json['bufferingCount'] as num?)?.toInt() ?? 0,
      totalBufferingTime: json['totalBufferingTime'] == null
          ? Duration.zero
          : const DurationMillisConverter().fromJson(
              (json['totalBufferingTime'] as num).toInt(),
            ),
      averageBitrate: (json['averageBitrate'] as num?)?.toDouble(),
      droppedFrames: (json['droppedFrames'] as num?)?.toInt() ?? 0,
      totalFrames: (json['totalFrames'] as num?)?.toInt() ?? 0,
      memoryUsage: (json['memoryUsage'] as num?)?.toInt(),
      cpuUsage: (json['cpuUsage'] as num?)?.toDouble(),
      networkUsage: (json['networkUsage'] as num?)?.toInt() ?? 0,
      cacheHitRatio: (json['cacheHitRatio'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PerformanceMetricsToJson(
  _PerformanceMetrics instance,
) => <String, dynamic>{
  'timeToFirstFrame': const NullableDurationMillisConverter().toJson(
    instance.timeToFirstFrame,
  ),
  'loadTime': const NullableDurationMillisConverter().toJson(instance.loadTime),
  'bufferingCount': instance.bufferingCount,
  'totalBufferingTime': const DurationMillisConverter().toJson(
    instance.totalBufferingTime,
  ),
  'averageBitrate': instance.averageBitrate,
  'droppedFrames': instance.droppedFrames,
  'totalFrames': instance.totalFrames,
  'memoryUsage': instance.memoryUsage,
  'cpuUsage': instance.cpuUsage,
  'networkUsage': instance.networkUsage,
  'cacheHitRatio': instance.cacheHitRatio,
};
