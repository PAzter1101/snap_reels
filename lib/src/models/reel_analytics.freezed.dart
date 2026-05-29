// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reel_analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReelAnalytics {

 String get sessionId; String get reelId; DeviceInfo get deviceInfo; PerformanceMetrics get performanceMetrics; DateTime get sessionStartTime; String? get userId; List<PlaybackEvent> get playbackEvents; List<InteractionEvent> get interactionEvents; DateTime? get sessionEndTime;
/// Create a copy of ReelAnalytics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReelAnalyticsCopyWith<ReelAnalytics> get copyWith => _$ReelAnalyticsCopyWithImpl<ReelAnalytics>(this as ReelAnalytics, _$identity);

  /// Serializes this ReelAnalytics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReelAnalytics&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.reelId, reelId) || other.reelId == reelId)&&(identical(other.deviceInfo, deviceInfo) || other.deviceInfo == deviceInfo)&&(identical(other.performanceMetrics, performanceMetrics) || other.performanceMetrics == performanceMetrics)&&(identical(other.sessionStartTime, sessionStartTime) || other.sessionStartTime == sessionStartTime)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.playbackEvents, playbackEvents)&&const DeepCollectionEquality().equals(other.interactionEvents, interactionEvents)&&(identical(other.sessionEndTime, sessionEndTime) || other.sessionEndTime == sessionEndTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,reelId,deviceInfo,performanceMetrics,sessionStartTime,userId,const DeepCollectionEquality().hash(playbackEvents),const DeepCollectionEquality().hash(interactionEvents),sessionEndTime);

@override
String toString() {
  return 'ReelAnalytics(sessionId: $sessionId, reelId: $reelId, deviceInfo: $deviceInfo, performanceMetrics: $performanceMetrics, sessionStartTime: $sessionStartTime, userId: $userId, playbackEvents: $playbackEvents, interactionEvents: $interactionEvents, sessionEndTime: $sessionEndTime)';
}


}

/// @nodoc
abstract mixin class $ReelAnalyticsCopyWith<$Res>  {
  factory $ReelAnalyticsCopyWith(ReelAnalytics value, $Res Function(ReelAnalytics) _then) = _$ReelAnalyticsCopyWithImpl;
@useResult
$Res call({
 String sessionId, String reelId, DeviceInfo deviceInfo, PerformanceMetrics performanceMetrics, DateTime sessionStartTime, String? userId, List<PlaybackEvent> playbackEvents, List<InteractionEvent> interactionEvents, DateTime? sessionEndTime
});


$DeviceInfoCopyWith<$Res> get deviceInfo;$PerformanceMetricsCopyWith<$Res> get performanceMetrics;

}
/// @nodoc
class _$ReelAnalyticsCopyWithImpl<$Res>
    implements $ReelAnalyticsCopyWith<$Res> {
  _$ReelAnalyticsCopyWithImpl(this._self, this._then);

  final ReelAnalytics _self;
  final $Res Function(ReelAnalytics) _then;

/// Create a copy of ReelAnalytics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? reelId = null,Object? deviceInfo = null,Object? performanceMetrics = null,Object? sessionStartTime = null,Object? userId = freezed,Object? playbackEvents = null,Object? interactionEvents = null,Object? sessionEndTime = freezed,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,reelId: null == reelId ? _self.reelId : reelId // ignore: cast_nullable_to_non_nullable
as String,deviceInfo: null == deviceInfo ? _self.deviceInfo : deviceInfo // ignore: cast_nullable_to_non_nullable
as DeviceInfo,performanceMetrics: null == performanceMetrics ? _self.performanceMetrics : performanceMetrics // ignore: cast_nullable_to_non_nullable
as PerformanceMetrics,sessionStartTime: null == sessionStartTime ? _self.sessionStartTime : sessionStartTime // ignore: cast_nullable_to_non_nullable
as DateTime,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,playbackEvents: null == playbackEvents ? _self.playbackEvents : playbackEvents // ignore: cast_nullable_to_non_nullable
as List<PlaybackEvent>,interactionEvents: null == interactionEvents ? _self.interactionEvents : interactionEvents // ignore: cast_nullable_to_non_nullable
as List<InteractionEvent>,sessionEndTime: freezed == sessionEndTime ? _self.sessionEndTime : sessionEndTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of ReelAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceInfoCopyWith<$Res> get deviceInfo {
  
  return $DeviceInfoCopyWith<$Res>(_self.deviceInfo, (value) {
    return _then(_self.copyWith(deviceInfo: value));
  });
}/// Create a copy of ReelAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceMetricsCopyWith<$Res> get performanceMetrics {
  
  return $PerformanceMetricsCopyWith<$Res>(_self.performanceMetrics, (value) {
    return _then(_self.copyWith(performanceMetrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReelAnalytics].
extension ReelAnalyticsPatterns on ReelAnalytics {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReelAnalytics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReelAnalytics() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReelAnalytics value)  $default,){
final _that = this;
switch (_that) {
case _ReelAnalytics():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReelAnalytics value)?  $default,){
final _that = this;
switch (_that) {
case _ReelAnalytics() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String reelId,  DeviceInfo deviceInfo,  PerformanceMetrics performanceMetrics,  DateTime sessionStartTime,  String? userId,  List<PlaybackEvent> playbackEvents,  List<InteractionEvent> interactionEvents,  DateTime? sessionEndTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReelAnalytics() when $default != null:
return $default(_that.sessionId,_that.reelId,_that.deviceInfo,_that.performanceMetrics,_that.sessionStartTime,_that.userId,_that.playbackEvents,_that.interactionEvents,_that.sessionEndTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String reelId,  DeviceInfo deviceInfo,  PerformanceMetrics performanceMetrics,  DateTime sessionStartTime,  String? userId,  List<PlaybackEvent> playbackEvents,  List<InteractionEvent> interactionEvents,  DateTime? sessionEndTime)  $default,) {final _that = this;
switch (_that) {
case _ReelAnalytics():
return $default(_that.sessionId,_that.reelId,_that.deviceInfo,_that.performanceMetrics,_that.sessionStartTime,_that.userId,_that.playbackEvents,_that.interactionEvents,_that.sessionEndTime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String reelId,  DeviceInfo deviceInfo,  PerformanceMetrics performanceMetrics,  DateTime sessionStartTime,  String? userId,  List<PlaybackEvent> playbackEvents,  List<InteractionEvent> interactionEvents,  DateTime? sessionEndTime)?  $default,) {final _that = this;
switch (_that) {
case _ReelAnalytics() when $default != null:
return $default(_that.sessionId,_that.reelId,_that.deviceInfo,_that.performanceMetrics,_that.sessionStartTime,_that.userId,_that.playbackEvents,_that.interactionEvents,_that.sessionEndTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReelAnalytics implements ReelAnalytics {
  const _ReelAnalytics({required this.sessionId, required this.reelId, required this.deviceInfo, required this.performanceMetrics, required this.sessionStartTime, this.userId, final  List<PlaybackEvent> playbackEvents = const <PlaybackEvent>[], final  List<InteractionEvent> interactionEvents = const <InteractionEvent>[], this.sessionEndTime}): _playbackEvents = playbackEvents,_interactionEvents = interactionEvents;
  factory _ReelAnalytics.fromJson(Map<String, dynamic> json) => _$ReelAnalyticsFromJson(json);

@override final  String sessionId;
@override final  String reelId;
@override final  DeviceInfo deviceInfo;
@override final  PerformanceMetrics performanceMetrics;
@override final  DateTime sessionStartTime;
@override final  String? userId;
 final  List<PlaybackEvent> _playbackEvents;
@override@JsonKey() List<PlaybackEvent> get playbackEvents {
  if (_playbackEvents is EqualUnmodifiableListView) return _playbackEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playbackEvents);
}

 final  List<InteractionEvent> _interactionEvents;
@override@JsonKey() List<InteractionEvent> get interactionEvents {
  if (_interactionEvents is EqualUnmodifiableListView) return _interactionEvents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interactionEvents);
}

@override final  DateTime? sessionEndTime;

/// Create a copy of ReelAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReelAnalyticsCopyWith<_ReelAnalytics> get copyWith => __$ReelAnalyticsCopyWithImpl<_ReelAnalytics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReelAnalyticsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReelAnalytics&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.reelId, reelId) || other.reelId == reelId)&&(identical(other.deviceInfo, deviceInfo) || other.deviceInfo == deviceInfo)&&(identical(other.performanceMetrics, performanceMetrics) || other.performanceMetrics == performanceMetrics)&&(identical(other.sessionStartTime, sessionStartTime) || other.sessionStartTime == sessionStartTime)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._playbackEvents, _playbackEvents)&&const DeepCollectionEquality().equals(other._interactionEvents, _interactionEvents)&&(identical(other.sessionEndTime, sessionEndTime) || other.sessionEndTime == sessionEndTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,reelId,deviceInfo,performanceMetrics,sessionStartTime,userId,const DeepCollectionEquality().hash(_playbackEvents),const DeepCollectionEquality().hash(_interactionEvents),sessionEndTime);

@override
String toString() {
  return 'ReelAnalytics(sessionId: $sessionId, reelId: $reelId, deviceInfo: $deviceInfo, performanceMetrics: $performanceMetrics, sessionStartTime: $sessionStartTime, userId: $userId, playbackEvents: $playbackEvents, interactionEvents: $interactionEvents, sessionEndTime: $sessionEndTime)';
}


}

/// @nodoc
abstract mixin class _$ReelAnalyticsCopyWith<$Res> implements $ReelAnalyticsCopyWith<$Res> {
  factory _$ReelAnalyticsCopyWith(_ReelAnalytics value, $Res Function(_ReelAnalytics) _then) = __$ReelAnalyticsCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String reelId, DeviceInfo deviceInfo, PerformanceMetrics performanceMetrics, DateTime sessionStartTime, String? userId, List<PlaybackEvent> playbackEvents, List<InteractionEvent> interactionEvents, DateTime? sessionEndTime
});


@override $DeviceInfoCopyWith<$Res> get deviceInfo;@override $PerformanceMetricsCopyWith<$Res> get performanceMetrics;

}
/// @nodoc
class __$ReelAnalyticsCopyWithImpl<$Res>
    implements _$ReelAnalyticsCopyWith<$Res> {
  __$ReelAnalyticsCopyWithImpl(this._self, this._then);

  final _ReelAnalytics _self;
  final $Res Function(_ReelAnalytics) _then;

/// Create a copy of ReelAnalytics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? reelId = null,Object? deviceInfo = null,Object? performanceMetrics = null,Object? sessionStartTime = null,Object? userId = freezed,Object? playbackEvents = null,Object? interactionEvents = null,Object? sessionEndTime = freezed,}) {
  return _then(_ReelAnalytics(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,reelId: null == reelId ? _self.reelId : reelId // ignore: cast_nullable_to_non_nullable
as String,deviceInfo: null == deviceInfo ? _self.deviceInfo : deviceInfo // ignore: cast_nullable_to_non_nullable
as DeviceInfo,performanceMetrics: null == performanceMetrics ? _self.performanceMetrics : performanceMetrics // ignore: cast_nullable_to_non_nullable
as PerformanceMetrics,sessionStartTime: null == sessionStartTime ? _self.sessionStartTime : sessionStartTime // ignore: cast_nullable_to_non_nullable
as DateTime,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,playbackEvents: null == playbackEvents ? _self._playbackEvents : playbackEvents // ignore: cast_nullable_to_non_nullable
as List<PlaybackEvent>,interactionEvents: null == interactionEvents ? _self._interactionEvents : interactionEvents // ignore: cast_nullable_to_non_nullable
as List<InteractionEvent>,sessionEndTime: freezed == sessionEndTime ? _self.sessionEndTime : sessionEndTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of ReelAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceInfoCopyWith<$Res> get deviceInfo {
  
  return $DeviceInfoCopyWith<$Res>(_self.deviceInfo, (value) {
    return _then(_self.copyWith(deviceInfo: value));
  });
}/// Create a copy of ReelAnalytics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PerformanceMetricsCopyWith<$Res> get performanceMetrics {
  
  return $PerformanceMetricsCopyWith<$Res>(_self.performanceMetrics, (value) {
    return _then(_self.copyWith(performanceMetrics: value));
  });
}
}


/// @nodoc
mixin _$DeviceInfo {

 String get platform; String? get deviceModel; String? get osVersion; String? get appVersion; String? get screenResolution; String? get networkType; double? get batteryLevel;
/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceInfoCopyWith<DeviceInfo> get copyWith => _$DeviceInfoCopyWithImpl<DeviceInfo>(this as DeviceInfo, _$identity);

  /// Serializes this DeviceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceInfo&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.osVersion, osVersion) || other.osVersion == osVersion)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.screenResolution, screenResolution) || other.screenResolution == screenResolution)&&(identical(other.networkType, networkType) || other.networkType == networkType)&&(identical(other.batteryLevel, batteryLevel) || other.batteryLevel == batteryLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform,deviceModel,osVersion,appVersion,screenResolution,networkType,batteryLevel);

@override
String toString() {
  return 'DeviceInfo(platform: $platform, deviceModel: $deviceModel, osVersion: $osVersion, appVersion: $appVersion, screenResolution: $screenResolution, networkType: $networkType, batteryLevel: $batteryLevel)';
}


}

/// @nodoc
abstract mixin class $DeviceInfoCopyWith<$Res>  {
  factory $DeviceInfoCopyWith(DeviceInfo value, $Res Function(DeviceInfo) _then) = _$DeviceInfoCopyWithImpl;
@useResult
$Res call({
 String platform, String? deviceModel, String? osVersion, String? appVersion, String? screenResolution, String? networkType, double? batteryLevel
});




}
/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._self, this._then);

  final DeviceInfo _self;
  final $Res Function(DeviceInfo) _then;

/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? platform = null,Object? deviceModel = freezed,Object? osVersion = freezed,Object? appVersion = freezed,Object? screenResolution = freezed,Object? networkType = freezed,Object? batteryLevel = freezed,}) {
  return _then(_self.copyWith(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,deviceModel: freezed == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String?,osVersion: freezed == osVersion ? _self.osVersion : osVersion // ignore: cast_nullable_to_non_nullable
as String?,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,screenResolution: freezed == screenResolution ? _self.screenResolution : screenResolution // ignore: cast_nullable_to_non_nullable
as String?,networkType: freezed == networkType ? _self.networkType : networkType // ignore: cast_nullable_to_non_nullable
as String?,batteryLevel: freezed == batteryLevel ? _self.batteryLevel : batteryLevel // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceInfo].
extension DeviceInfoPatterns on DeviceInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceInfo value)  $default,){
final _that = this;
switch (_that) {
case _DeviceInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceInfo value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String platform,  String? deviceModel,  String? osVersion,  String? appVersion,  String? screenResolution,  String? networkType,  double? batteryLevel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
return $default(_that.platform,_that.deviceModel,_that.osVersion,_that.appVersion,_that.screenResolution,_that.networkType,_that.batteryLevel);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String platform,  String? deviceModel,  String? osVersion,  String? appVersion,  String? screenResolution,  String? networkType,  double? batteryLevel)  $default,) {final _that = this;
switch (_that) {
case _DeviceInfo():
return $default(_that.platform,_that.deviceModel,_that.osVersion,_that.appVersion,_that.screenResolution,_that.networkType,_that.batteryLevel);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String platform,  String? deviceModel,  String? osVersion,  String? appVersion,  String? screenResolution,  String? networkType,  double? batteryLevel)?  $default,) {final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
return $default(_that.platform,_that.deviceModel,_that.osVersion,_that.appVersion,_that.screenResolution,_that.networkType,_that.batteryLevel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceInfo implements DeviceInfo {
  const _DeviceInfo({required this.platform, this.deviceModel, this.osVersion, this.appVersion, this.screenResolution, this.networkType, this.batteryLevel});
  factory _DeviceInfo.fromJson(Map<String, dynamic> json) => _$DeviceInfoFromJson(json);

@override final  String platform;
@override final  String? deviceModel;
@override final  String? osVersion;
@override final  String? appVersion;
@override final  String? screenResolution;
@override final  String? networkType;
@override final  double? batteryLevel;

/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceInfoCopyWith<_DeviceInfo> get copyWith => __$DeviceInfoCopyWithImpl<_DeviceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceInfo&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.osVersion, osVersion) || other.osVersion == osVersion)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.screenResolution, screenResolution) || other.screenResolution == screenResolution)&&(identical(other.networkType, networkType) || other.networkType == networkType)&&(identical(other.batteryLevel, batteryLevel) || other.batteryLevel == batteryLevel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform,deviceModel,osVersion,appVersion,screenResolution,networkType,batteryLevel);

@override
String toString() {
  return 'DeviceInfo(platform: $platform, deviceModel: $deviceModel, osVersion: $osVersion, appVersion: $appVersion, screenResolution: $screenResolution, networkType: $networkType, batteryLevel: $batteryLevel)';
}


}

/// @nodoc
abstract mixin class _$DeviceInfoCopyWith<$Res> implements $DeviceInfoCopyWith<$Res> {
  factory _$DeviceInfoCopyWith(_DeviceInfo value, $Res Function(_DeviceInfo) _then) = __$DeviceInfoCopyWithImpl;
@override @useResult
$Res call({
 String platform, String? deviceModel, String? osVersion, String? appVersion, String? screenResolution, String? networkType, double? batteryLevel
});




}
/// @nodoc
class __$DeviceInfoCopyWithImpl<$Res>
    implements _$DeviceInfoCopyWith<$Res> {
  __$DeviceInfoCopyWithImpl(this._self, this._then);

  final _DeviceInfo _self;
  final $Res Function(_DeviceInfo) _then;

/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? platform = null,Object? deviceModel = freezed,Object? osVersion = freezed,Object? appVersion = freezed,Object? screenResolution = freezed,Object? networkType = freezed,Object? batteryLevel = freezed,}) {
  return _then(_DeviceInfo(
platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,deviceModel: freezed == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String?,osVersion: freezed == osVersion ? _self.osVersion : osVersion // ignore: cast_nullable_to_non_nullable
as String?,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,screenResolution: freezed == screenResolution ? _self.screenResolution : screenResolution // ignore: cast_nullable_to_non_nullable
as String?,networkType: freezed == networkType ? _self.networkType : networkType // ignore: cast_nullable_to_non_nullable
as String?,batteryLevel: freezed == batteryLevel ? _self.batteryLevel : batteryLevel // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$PlaybackEvent {

 PlaybackEventType get type; DateTime get timestamp;@DurationMillisConverter() Duration get position;@NullableDurationMillisConverter() Duration? get duration; Map<String, dynamic>? get metadata;
/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackEventCopyWith<PlaybackEvent> get copyWith => _$PlaybackEventCopyWithImpl<PlaybackEvent>(this as PlaybackEvent, _$identity);

  /// Serializes this PlaybackEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,timestamp,position,duration,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'PlaybackEvent(type: $type, timestamp: $timestamp, position: $position, duration: $duration, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $PlaybackEventCopyWith<$Res>  {
  factory $PlaybackEventCopyWith(PlaybackEvent value, $Res Function(PlaybackEvent) _then) = _$PlaybackEventCopyWithImpl;
@useResult
$Res call({
 PlaybackEventType type, DateTime timestamp,@DurationMillisConverter() Duration position,@NullableDurationMillisConverter() Duration? duration, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$PlaybackEventCopyWithImpl<$Res>
    implements $PlaybackEventCopyWith<$Res> {
  _$PlaybackEventCopyWithImpl(this._self, this._then);

  final PlaybackEvent _self;
  final $Res Function(PlaybackEvent) _then;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? timestamp = null,Object? position = null,Object? duration = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PlaybackEventType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaybackEvent].
extension PlaybackEventPatterns on PlaybackEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaybackEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaybackEvent() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaybackEvent value)  $default,){
final _that = this;
switch (_that) {
case _PlaybackEvent():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaybackEvent value)?  $default,){
final _that = this;
switch (_that) {
case _PlaybackEvent() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlaybackEventType type,  DateTime timestamp, @DurationMillisConverter()  Duration position, @NullableDurationMillisConverter()  Duration? duration,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaybackEvent() when $default != null:
return $default(_that.type,_that.timestamp,_that.position,_that.duration,_that.metadata);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlaybackEventType type,  DateTime timestamp, @DurationMillisConverter()  Duration position, @NullableDurationMillisConverter()  Duration? duration,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _PlaybackEvent():
return $default(_that.type,_that.timestamp,_that.position,_that.duration,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlaybackEventType type,  DateTime timestamp, @DurationMillisConverter()  Duration position, @NullableDurationMillisConverter()  Duration? duration,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _PlaybackEvent() when $default != null:
return $default(_that.type,_that.timestamp,_that.position,_that.duration,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaybackEvent implements PlaybackEvent {
  const _PlaybackEvent({required this.type, required this.timestamp, @DurationMillisConverter() required this.position, @NullableDurationMillisConverter() this.duration, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _PlaybackEvent.fromJson(Map<String, dynamic> json) => _$PlaybackEventFromJson(json);

@override final  PlaybackEventType type;
@override final  DateTime timestamp;
@override@DurationMillisConverter() final  Duration position;
@override@NullableDurationMillisConverter() final  Duration? duration;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaybackEventCopyWith<_PlaybackEvent> get copyWith => __$PlaybackEventCopyWithImpl<_PlaybackEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaybackEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaybackEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.position, position) || other.position == position)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,timestamp,position,duration,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'PlaybackEvent(type: $type, timestamp: $timestamp, position: $position, duration: $duration, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$PlaybackEventCopyWith<$Res> implements $PlaybackEventCopyWith<$Res> {
  factory _$PlaybackEventCopyWith(_PlaybackEvent value, $Res Function(_PlaybackEvent) _then) = __$PlaybackEventCopyWithImpl;
@override @useResult
$Res call({
 PlaybackEventType type, DateTime timestamp,@DurationMillisConverter() Duration position,@NullableDurationMillisConverter() Duration? duration, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$PlaybackEventCopyWithImpl<$Res>
    implements _$PlaybackEventCopyWith<$Res> {
  __$PlaybackEventCopyWithImpl(this._self, this._then);

  final _PlaybackEvent _self;
  final $Res Function(_PlaybackEvent) _then;

/// Create a copy of PlaybackEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? timestamp = null,Object? position = null,Object? duration = freezed,Object? metadata = freezed,}) {
  return _then(_PlaybackEvent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PlaybackEventType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$InteractionEvent {

 InteractionEventType get type; DateTime get timestamp;@DurationMillisConverter() Duration get videoPosition; Map<String, dynamic>? get metadata;
/// Create a copy of InteractionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InteractionEventCopyWith<InteractionEvent> get copyWith => _$InteractionEventCopyWithImpl<InteractionEvent>(this as InteractionEvent, _$identity);

  /// Serializes this InteractionEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InteractionEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.videoPosition, videoPosition) || other.videoPosition == videoPosition)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,timestamp,videoPosition,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'InteractionEvent(type: $type, timestamp: $timestamp, videoPosition: $videoPosition, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $InteractionEventCopyWith<$Res>  {
  factory $InteractionEventCopyWith(InteractionEvent value, $Res Function(InteractionEvent) _then) = _$InteractionEventCopyWithImpl;
@useResult
$Res call({
 InteractionEventType type, DateTime timestamp,@DurationMillisConverter() Duration videoPosition, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$InteractionEventCopyWithImpl<$Res>
    implements $InteractionEventCopyWith<$Res> {
  _$InteractionEventCopyWithImpl(this._self, this._then);

  final InteractionEvent _self;
  final $Res Function(InteractionEvent) _then;

/// Create a copy of InteractionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? timestamp = null,Object? videoPosition = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InteractionEventType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,videoPosition: null == videoPosition ? _self.videoPosition : videoPosition // ignore: cast_nullable_to_non_nullable
as Duration,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [InteractionEvent].
extension InteractionEventPatterns on InteractionEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InteractionEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InteractionEvent() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InteractionEvent value)  $default,){
final _that = this;
switch (_that) {
case _InteractionEvent():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InteractionEvent value)?  $default,){
final _that = this;
switch (_that) {
case _InteractionEvent() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InteractionEventType type,  DateTime timestamp, @DurationMillisConverter()  Duration videoPosition,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InteractionEvent() when $default != null:
return $default(_that.type,_that.timestamp,_that.videoPosition,_that.metadata);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InteractionEventType type,  DateTime timestamp, @DurationMillisConverter()  Duration videoPosition,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _InteractionEvent():
return $default(_that.type,_that.timestamp,_that.videoPosition,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InteractionEventType type,  DateTime timestamp, @DurationMillisConverter()  Duration videoPosition,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _InteractionEvent() when $default != null:
return $default(_that.type,_that.timestamp,_that.videoPosition,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InteractionEvent implements InteractionEvent {
  const _InteractionEvent({required this.type, required this.timestamp, @DurationMillisConverter() required this.videoPosition, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _InteractionEvent.fromJson(Map<String, dynamic> json) => _$InteractionEventFromJson(json);

@override final  InteractionEventType type;
@override final  DateTime timestamp;
@override@DurationMillisConverter() final  Duration videoPosition;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of InteractionEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InteractionEventCopyWith<_InteractionEvent> get copyWith => __$InteractionEventCopyWithImpl<_InteractionEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InteractionEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InteractionEvent&&(identical(other.type, type) || other.type == type)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.videoPosition, videoPosition) || other.videoPosition == videoPosition)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,timestamp,videoPosition,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'InteractionEvent(type: $type, timestamp: $timestamp, videoPosition: $videoPosition, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$InteractionEventCopyWith<$Res> implements $InteractionEventCopyWith<$Res> {
  factory _$InteractionEventCopyWith(_InteractionEvent value, $Res Function(_InteractionEvent) _then) = __$InteractionEventCopyWithImpl;
@override @useResult
$Res call({
 InteractionEventType type, DateTime timestamp,@DurationMillisConverter() Duration videoPosition, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$InteractionEventCopyWithImpl<$Res>
    implements _$InteractionEventCopyWith<$Res> {
  __$InteractionEventCopyWithImpl(this._self, this._then);

  final _InteractionEvent _self;
  final $Res Function(_InteractionEvent) _then;

/// Create a copy of InteractionEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? timestamp = null,Object? videoPosition = null,Object? metadata = freezed,}) {
  return _then(_InteractionEvent(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InteractionEventType,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,videoPosition: null == videoPosition ? _self.videoPosition : videoPosition // ignore: cast_nullable_to_non_nullable
as Duration,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$PerformanceMetrics {

@NullableDurationMillisConverter() Duration? get timeToFirstFrame;@NullableDurationMillisConverter() Duration? get loadTime; int get bufferingCount;@DurationMillisConverter() Duration get totalBufferingTime; double? get averageBitrate; int get droppedFrames; int get totalFrames; int? get memoryUsage; double? get cpuUsage; int get networkUsage; double? get cacheHitRatio;
/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceMetricsCopyWith<PerformanceMetrics> get copyWith => _$PerformanceMetricsCopyWithImpl<PerformanceMetrics>(this as PerformanceMetrics, _$identity);

  /// Serializes this PerformanceMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceMetrics&&(identical(other.timeToFirstFrame, timeToFirstFrame) || other.timeToFirstFrame == timeToFirstFrame)&&(identical(other.loadTime, loadTime) || other.loadTime == loadTime)&&(identical(other.bufferingCount, bufferingCount) || other.bufferingCount == bufferingCount)&&(identical(other.totalBufferingTime, totalBufferingTime) || other.totalBufferingTime == totalBufferingTime)&&(identical(other.averageBitrate, averageBitrate) || other.averageBitrate == averageBitrate)&&(identical(other.droppedFrames, droppedFrames) || other.droppedFrames == droppedFrames)&&(identical(other.totalFrames, totalFrames) || other.totalFrames == totalFrames)&&(identical(other.memoryUsage, memoryUsage) || other.memoryUsage == memoryUsage)&&(identical(other.cpuUsage, cpuUsage) || other.cpuUsage == cpuUsage)&&(identical(other.networkUsage, networkUsage) || other.networkUsage == networkUsage)&&(identical(other.cacheHitRatio, cacheHitRatio) || other.cacheHitRatio == cacheHitRatio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timeToFirstFrame,loadTime,bufferingCount,totalBufferingTime,averageBitrate,droppedFrames,totalFrames,memoryUsage,cpuUsage,networkUsage,cacheHitRatio);

@override
String toString() {
  return 'PerformanceMetrics(timeToFirstFrame: $timeToFirstFrame, loadTime: $loadTime, bufferingCount: $bufferingCount, totalBufferingTime: $totalBufferingTime, averageBitrate: $averageBitrate, droppedFrames: $droppedFrames, totalFrames: $totalFrames, memoryUsage: $memoryUsage, cpuUsage: $cpuUsage, networkUsage: $networkUsage, cacheHitRatio: $cacheHitRatio)';
}


}

/// @nodoc
abstract mixin class $PerformanceMetricsCopyWith<$Res>  {
  factory $PerformanceMetricsCopyWith(PerformanceMetrics value, $Res Function(PerformanceMetrics) _then) = _$PerformanceMetricsCopyWithImpl;
@useResult
$Res call({
@NullableDurationMillisConverter() Duration? timeToFirstFrame,@NullableDurationMillisConverter() Duration? loadTime, int bufferingCount,@DurationMillisConverter() Duration totalBufferingTime, double? averageBitrate, int droppedFrames, int totalFrames, int? memoryUsage, double? cpuUsage, int networkUsage, double? cacheHitRatio
});




}
/// @nodoc
class _$PerformanceMetricsCopyWithImpl<$Res>
    implements $PerformanceMetricsCopyWith<$Res> {
  _$PerformanceMetricsCopyWithImpl(this._self, this._then);

  final PerformanceMetrics _self;
  final $Res Function(PerformanceMetrics) _then;

/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? timeToFirstFrame = freezed,Object? loadTime = freezed,Object? bufferingCount = null,Object? totalBufferingTime = null,Object? averageBitrate = freezed,Object? droppedFrames = null,Object? totalFrames = null,Object? memoryUsage = freezed,Object? cpuUsage = freezed,Object? networkUsage = null,Object? cacheHitRatio = freezed,}) {
  return _then(_self.copyWith(
timeToFirstFrame: freezed == timeToFirstFrame ? _self.timeToFirstFrame : timeToFirstFrame // ignore: cast_nullable_to_non_nullable
as Duration?,loadTime: freezed == loadTime ? _self.loadTime : loadTime // ignore: cast_nullable_to_non_nullable
as Duration?,bufferingCount: null == bufferingCount ? _self.bufferingCount : bufferingCount // ignore: cast_nullable_to_non_nullable
as int,totalBufferingTime: null == totalBufferingTime ? _self.totalBufferingTime : totalBufferingTime // ignore: cast_nullable_to_non_nullable
as Duration,averageBitrate: freezed == averageBitrate ? _self.averageBitrate : averageBitrate // ignore: cast_nullable_to_non_nullable
as double?,droppedFrames: null == droppedFrames ? _self.droppedFrames : droppedFrames // ignore: cast_nullable_to_non_nullable
as int,totalFrames: null == totalFrames ? _self.totalFrames : totalFrames // ignore: cast_nullable_to_non_nullable
as int,memoryUsage: freezed == memoryUsage ? _self.memoryUsage : memoryUsage // ignore: cast_nullable_to_non_nullable
as int?,cpuUsage: freezed == cpuUsage ? _self.cpuUsage : cpuUsage // ignore: cast_nullable_to_non_nullable
as double?,networkUsage: null == networkUsage ? _self.networkUsage : networkUsage // ignore: cast_nullable_to_non_nullable
as int,cacheHitRatio: freezed == cacheHitRatio ? _self.cacheHitRatio : cacheHitRatio // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceMetrics].
extension PerformanceMetricsPatterns on PerformanceMetrics {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceMetrics() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceMetrics value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceMetrics():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceMetrics() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@NullableDurationMillisConverter()  Duration? timeToFirstFrame, @NullableDurationMillisConverter()  Duration? loadTime,  int bufferingCount, @DurationMillisConverter()  Duration totalBufferingTime,  double? averageBitrate,  int droppedFrames,  int totalFrames,  int? memoryUsage,  double? cpuUsage,  int networkUsage,  double? cacheHitRatio)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceMetrics() when $default != null:
return $default(_that.timeToFirstFrame,_that.loadTime,_that.bufferingCount,_that.totalBufferingTime,_that.averageBitrate,_that.droppedFrames,_that.totalFrames,_that.memoryUsage,_that.cpuUsage,_that.networkUsage,_that.cacheHitRatio);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@NullableDurationMillisConverter()  Duration? timeToFirstFrame, @NullableDurationMillisConverter()  Duration? loadTime,  int bufferingCount, @DurationMillisConverter()  Duration totalBufferingTime,  double? averageBitrate,  int droppedFrames,  int totalFrames,  int? memoryUsage,  double? cpuUsage,  int networkUsage,  double? cacheHitRatio)  $default,) {final _that = this;
switch (_that) {
case _PerformanceMetrics():
return $default(_that.timeToFirstFrame,_that.loadTime,_that.bufferingCount,_that.totalBufferingTime,_that.averageBitrate,_that.droppedFrames,_that.totalFrames,_that.memoryUsage,_that.cpuUsage,_that.networkUsage,_that.cacheHitRatio);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@NullableDurationMillisConverter()  Duration? timeToFirstFrame, @NullableDurationMillisConverter()  Duration? loadTime,  int bufferingCount, @DurationMillisConverter()  Duration totalBufferingTime,  double? averageBitrate,  int droppedFrames,  int totalFrames,  int? memoryUsage,  double? cpuUsage,  int networkUsage,  double? cacheHitRatio)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceMetrics() when $default != null:
return $default(_that.timeToFirstFrame,_that.loadTime,_that.bufferingCount,_that.totalBufferingTime,_that.averageBitrate,_that.droppedFrames,_that.totalFrames,_that.memoryUsage,_that.cpuUsage,_that.networkUsage,_that.cacheHitRatio);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PerformanceMetrics extends PerformanceMetrics {
  const _PerformanceMetrics({@NullableDurationMillisConverter() this.timeToFirstFrame, @NullableDurationMillisConverter() this.loadTime, this.bufferingCount = 0, @DurationMillisConverter() this.totalBufferingTime = Duration.zero, this.averageBitrate, this.droppedFrames = 0, this.totalFrames = 0, this.memoryUsage, this.cpuUsage, this.networkUsage = 0, this.cacheHitRatio}): super._();
  factory _PerformanceMetrics.fromJson(Map<String, dynamic> json) => _$PerformanceMetricsFromJson(json);

@override@NullableDurationMillisConverter() final  Duration? timeToFirstFrame;
@override@NullableDurationMillisConverter() final  Duration? loadTime;
@override@JsonKey() final  int bufferingCount;
@override@JsonKey()@DurationMillisConverter() final  Duration totalBufferingTime;
@override final  double? averageBitrate;
@override@JsonKey() final  int droppedFrames;
@override@JsonKey() final  int totalFrames;
@override final  int? memoryUsage;
@override final  double? cpuUsage;
@override@JsonKey() final  int networkUsage;
@override final  double? cacheHitRatio;

/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceMetricsCopyWith<_PerformanceMetrics> get copyWith => __$PerformanceMetricsCopyWithImpl<_PerformanceMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PerformanceMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceMetrics&&(identical(other.timeToFirstFrame, timeToFirstFrame) || other.timeToFirstFrame == timeToFirstFrame)&&(identical(other.loadTime, loadTime) || other.loadTime == loadTime)&&(identical(other.bufferingCount, bufferingCount) || other.bufferingCount == bufferingCount)&&(identical(other.totalBufferingTime, totalBufferingTime) || other.totalBufferingTime == totalBufferingTime)&&(identical(other.averageBitrate, averageBitrate) || other.averageBitrate == averageBitrate)&&(identical(other.droppedFrames, droppedFrames) || other.droppedFrames == droppedFrames)&&(identical(other.totalFrames, totalFrames) || other.totalFrames == totalFrames)&&(identical(other.memoryUsage, memoryUsage) || other.memoryUsage == memoryUsage)&&(identical(other.cpuUsage, cpuUsage) || other.cpuUsage == cpuUsage)&&(identical(other.networkUsage, networkUsage) || other.networkUsage == networkUsage)&&(identical(other.cacheHitRatio, cacheHitRatio) || other.cacheHitRatio == cacheHitRatio));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,timeToFirstFrame,loadTime,bufferingCount,totalBufferingTime,averageBitrate,droppedFrames,totalFrames,memoryUsage,cpuUsage,networkUsage,cacheHitRatio);

@override
String toString() {
  return 'PerformanceMetrics(timeToFirstFrame: $timeToFirstFrame, loadTime: $loadTime, bufferingCount: $bufferingCount, totalBufferingTime: $totalBufferingTime, averageBitrate: $averageBitrate, droppedFrames: $droppedFrames, totalFrames: $totalFrames, memoryUsage: $memoryUsage, cpuUsage: $cpuUsage, networkUsage: $networkUsage, cacheHitRatio: $cacheHitRatio)';
}


}

/// @nodoc
abstract mixin class _$PerformanceMetricsCopyWith<$Res> implements $PerformanceMetricsCopyWith<$Res> {
  factory _$PerformanceMetricsCopyWith(_PerformanceMetrics value, $Res Function(_PerformanceMetrics) _then) = __$PerformanceMetricsCopyWithImpl;
@override @useResult
$Res call({
@NullableDurationMillisConverter() Duration? timeToFirstFrame,@NullableDurationMillisConverter() Duration? loadTime, int bufferingCount,@DurationMillisConverter() Duration totalBufferingTime, double? averageBitrate, int droppedFrames, int totalFrames, int? memoryUsage, double? cpuUsage, int networkUsage, double? cacheHitRatio
});




}
/// @nodoc
class __$PerformanceMetricsCopyWithImpl<$Res>
    implements _$PerformanceMetricsCopyWith<$Res> {
  __$PerformanceMetricsCopyWithImpl(this._self, this._then);

  final _PerformanceMetrics _self;
  final $Res Function(_PerformanceMetrics) _then;

/// Create a copy of PerformanceMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? timeToFirstFrame = freezed,Object? loadTime = freezed,Object? bufferingCount = null,Object? totalBufferingTime = null,Object? averageBitrate = freezed,Object? droppedFrames = null,Object? totalFrames = null,Object? memoryUsage = freezed,Object? cpuUsage = freezed,Object? networkUsage = null,Object? cacheHitRatio = freezed,}) {
  return _then(_PerformanceMetrics(
timeToFirstFrame: freezed == timeToFirstFrame ? _self.timeToFirstFrame : timeToFirstFrame // ignore: cast_nullable_to_non_nullable
as Duration?,loadTime: freezed == loadTime ? _self.loadTime : loadTime // ignore: cast_nullable_to_non_nullable
as Duration?,bufferingCount: null == bufferingCount ? _self.bufferingCount : bufferingCount // ignore: cast_nullable_to_non_nullable
as int,totalBufferingTime: null == totalBufferingTime ? _self.totalBufferingTime : totalBufferingTime // ignore: cast_nullable_to_non_nullable
as Duration,averageBitrate: freezed == averageBitrate ? _self.averageBitrate : averageBitrate // ignore: cast_nullable_to_non_nullable
as double?,droppedFrames: null == droppedFrames ? _self.droppedFrames : droppedFrames // ignore: cast_nullable_to_non_nullable
as int,totalFrames: null == totalFrames ? _self.totalFrames : totalFrames // ignore: cast_nullable_to_non_nullable
as int,memoryUsage: freezed == memoryUsage ? _self.memoryUsage : memoryUsage // ignore: cast_nullable_to_non_nullable
as int?,cpuUsage: freezed == cpuUsage ? _self.cpuUsage : cpuUsage // ignore: cast_nullable_to_non_nullable
as double?,networkUsage: null == networkUsage ? _self.networkUsage : networkUsage // ignore: cast_nullable_to_non_nullable
as int,cacheHitRatio: freezed == cacheHitRatio ? _self.cacheHitRatio : cacheHitRatio // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
