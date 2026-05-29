// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reel_audio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReelAudio {

 String? get title; String? get artist; String? get coverUrl; String? get audioUrl; int? get duration;
/// Create a copy of ReelAudio
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReelAudioCopyWith<ReelAudio> get copyWith => _$ReelAudioCopyWithImpl<ReelAudio>(this as ReelAudio, _$identity);

  /// Serializes this ReelAudio to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReelAudio&&(identical(other.title, title) || other.title == title)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,artist,coverUrl,audioUrl,duration);

@override
String toString() {
  return 'ReelAudio(title: $title, artist: $artist, coverUrl: $coverUrl, audioUrl: $audioUrl, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $ReelAudioCopyWith<$Res>  {
  factory $ReelAudioCopyWith(ReelAudio value, $Res Function(ReelAudio) _then) = _$ReelAudioCopyWithImpl;
@useResult
$Res call({
 String? title, String? artist, String? coverUrl, String? audioUrl, int? duration
});




}
/// @nodoc
class _$ReelAudioCopyWithImpl<$Res>
    implements $ReelAudioCopyWith<$Res> {
  _$ReelAudioCopyWithImpl(this._self, this._then);

  final ReelAudio _self;
  final $Res Function(ReelAudio) _then;

/// Create a copy of ReelAudio
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? artist = freezed,Object? coverUrl = freezed,Object? audioUrl = freezed,Object? duration = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReelAudio].
extension ReelAudioPatterns on ReelAudio {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReelAudio value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReelAudio() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReelAudio value)  $default,){
final _that = this;
switch (_that) {
case _ReelAudio():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReelAudio value)?  $default,){
final _that = this;
switch (_that) {
case _ReelAudio() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  String? artist,  String? coverUrl,  String? audioUrl,  int? duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReelAudio() when $default != null:
return $default(_that.title,_that.artist,_that.coverUrl,_that.audioUrl,_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  String? artist,  String? coverUrl,  String? audioUrl,  int? duration)  $default,) {final _that = this;
switch (_that) {
case _ReelAudio():
return $default(_that.title,_that.artist,_that.coverUrl,_that.audioUrl,_that.duration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  String? artist,  String? coverUrl,  String? audioUrl,  int? duration)?  $default,) {final _that = this;
switch (_that) {
case _ReelAudio() when $default != null:
return $default(_that.title,_that.artist,_that.coverUrl,_that.audioUrl,_that.duration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReelAudio implements ReelAudio {
  const _ReelAudio({this.title, this.artist, this.coverUrl, this.audioUrl, this.duration});
  factory _ReelAudio.fromJson(Map<String, dynamic> json) => _$ReelAudioFromJson(json);

@override final  String? title;
@override final  String? artist;
@override final  String? coverUrl;
@override final  String? audioUrl;
@override final  int? duration;

/// Create a copy of ReelAudio
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReelAudioCopyWith<_ReelAudio> get copyWith => __$ReelAudioCopyWithImpl<_ReelAudio>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReelAudioToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReelAudio&&(identical(other.title, title) || other.title == title)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,artist,coverUrl,audioUrl,duration);

@override
String toString() {
  return 'ReelAudio(title: $title, artist: $artist, coverUrl: $coverUrl, audioUrl: $audioUrl, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$ReelAudioCopyWith<$Res> implements $ReelAudioCopyWith<$Res> {
  factory _$ReelAudioCopyWith(_ReelAudio value, $Res Function(_ReelAudio) _then) = __$ReelAudioCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? artist, String? coverUrl, String? audioUrl, int? duration
});




}
/// @nodoc
class __$ReelAudioCopyWithImpl<$Res>
    implements _$ReelAudioCopyWith<$Res> {
  __$ReelAudioCopyWithImpl(this._self, this._then);

  final _ReelAudio _self;
  final $Res Function(_ReelAudio) _then;

/// Create a copy of ReelAudio
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? artist = freezed,Object? coverUrl = freezed,Object? audioUrl = freezed,Object? duration = freezed,}) {
  return _then(_ReelAudio(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
