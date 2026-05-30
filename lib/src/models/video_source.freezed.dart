// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoSource {

 String get url; VideoFormat get format;@VideoFormatMapConverter() Map<VideoFormat, String>? get alternativeSources; String? get quality; int? get bitrate; VideoSize? get dimensions;
/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoSourceCopyWith<VideoSource> get copyWith => _$VideoSourceCopyWithImpl<VideoSource>(this as VideoSource, _$identity);

  /// Serializes this VideoSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoSource&&(identical(other.url, url) || other.url == url)&&(identical(other.format, format) || other.format == format)&&const DeepCollectionEquality().equals(other.alternativeSources, alternativeSources)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.bitrate, bitrate) || other.bitrate == bitrate)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,format,const DeepCollectionEquality().hash(alternativeSources),quality,bitrate,dimensions);

@override
String toString() {
  return 'VideoSource(url: $url, format: $format, alternativeSources: $alternativeSources, quality: $quality, bitrate: $bitrate, dimensions: $dimensions)';
}


}

/// @nodoc
abstract mixin class $VideoSourceCopyWith<$Res>  {
  factory $VideoSourceCopyWith(VideoSource value, $Res Function(VideoSource) _then) = _$VideoSourceCopyWithImpl;
@useResult
$Res call({
 String url, VideoFormat format,@VideoFormatMapConverter() Map<VideoFormat, String>? alternativeSources, String? quality, int? bitrate, VideoSize? dimensions
});


$VideoSizeCopyWith<$Res>? get dimensions;

}
/// @nodoc
class _$VideoSourceCopyWithImpl<$Res>
    implements $VideoSourceCopyWith<$Res> {
  _$VideoSourceCopyWithImpl(this._self, this._then);

  final VideoSource _self;
  final $Res Function(VideoSource) _then;

/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? format = null,Object? alternativeSources = freezed,Object? quality = freezed,Object? bitrate = freezed,Object? dimensions = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as VideoFormat,alternativeSources: freezed == alternativeSources ? _self.alternativeSources : alternativeSources // ignore: cast_nullable_to_non_nullable
as Map<VideoFormat, String>?,quality: freezed == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String?,bitrate: freezed == bitrate ? _self.bitrate : bitrate // ignore: cast_nullable_to_non_nullable
as int?,dimensions: freezed == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as VideoSize?,
  ));
}
/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoSizeCopyWith<$Res>? get dimensions {
    if (_self.dimensions == null) {
    return null;
  }

  return $VideoSizeCopyWith<$Res>(_self.dimensions!, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}
}


/// Adds pattern-matching-related methods to [VideoSource].
extension VideoSourcePatterns on VideoSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoSource value)  $default,){
final _that = this;
switch (_that) {
case _VideoSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoSource value)?  $default,){
final _that = this;
switch (_that) {
case _VideoSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  VideoFormat format, @VideoFormatMapConverter()  Map<VideoFormat, String>? alternativeSources,  String? quality,  int? bitrate,  VideoSize? dimensions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoSource() when $default != null:
return $default(_that.url,_that.format,_that.alternativeSources,_that.quality,_that.bitrate,_that.dimensions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  VideoFormat format, @VideoFormatMapConverter()  Map<VideoFormat, String>? alternativeSources,  String? quality,  int? bitrate,  VideoSize? dimensions)  $default,) {final _that = this;
switch (_that) {
case _VideoSource():
return $default(_that.url,_that.format,_that.alternativeSources,_that.quality,_that.bitrate,_that.dimensions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  VideoFormat format, @VideoFormatMapConverter()  Map<VideoFormat, String>? alternativeSources,  String? quality,  int? bitrate,  VideoSize? dimensions)?  $default,) {final _that = this;
switch (_that) {
case _VideoSource() when $default != null:
return $default(_that.url,_that.format,_that.alternativeSources,_that.quality,_that.bitrate,_that.dimensions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoSource extends VideoSource {
  const _VideoSource({required this.url, this.format = VideoFormat.hls, @VideoFormatMapConverter() final  Map<VideoFormat, String>? alternativeSources, this.quality, this.bitrate, this.dimensions}): _alternativeSources = alternativeSources,super._();
  factory _VideoSource.fromJson(Map<String, dynamic> json) => _$VideoSourceFromJson(json);

@override final  String url;
@override@JsonKey() final  VideoFormat format;
 final  Map<VideoFormat, String>? _alternativeSources;
@override@VideoFormatMapConverter() Map<VideoFormat, String>? get alternativeSources {
  final value = _alternativeSources;
  if (value == null) return null;
  if (_alternativeSources is EqualUnmodifiableMapView) return _alternativeSources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? quality;
@override final  int? bitrate;
@override final  VideoSize? dimensions;

/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoSourceCopyWith<_VideoSource> get copyWith => __$VideoSourceCopyWithImpl<_VideoSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoSource&&(identical(other.url, url) || other.url == url)&&(identical(other.format, format) || other.format == format)&&const DeepCollectionEquality().equals(other._alternativeSources, _alternativeSources)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.bitrate, bitrate) || other.bitrate == bitrate)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,format,const DeepCollectionEquality().hash(_alternativeSources),quality,bitrate,dimensions);

@override
String toString() {
  return 'VideoSource(url: $url, format: $format, alternativeSources: $alternativeSources, quality: $quality, bitrate: $bitrate, dimensions: $dimensions)';
}


}

/// @nodoc
abstract mixin class _$VideoSourceCopyWith<$Res> implements $VideoSourceCopyWith<$Res> {
  factory _$VideoSourceCopyWith(_VideoSource value, $Res Function(_VideoSource) _then) = __$VideoSourceCopyWithImpl;
@override @useResult
$Res call({
 String url, VideoFormat format,@VideoFormatMapConverter() Map<VideoFormat, String>? alternativeSources, String? quality, int? bitrate, VideoSize? dimensions
});


@override $VideoSizeCopyWith<$Res>? get dimensions;

}
/// @nodoc
class __$VideoSourceCopyWithImpl<$Res>
    implements _$VideoSourceCopyWith<$Res> {
  __$VideoSourceCopyWithImpl(this._self, this._then);

  final _VideoSource _self;
  final $Res Function(_VideoSource) _then;

/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? format = null,Object? alternativeSources = freezed,Object? quality = freezed,Object? bitrate = freezed,Object? dimensions = freezed,}) {
  return _then(_VideoSource(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as VideoFormat,alternativeSources: freezed == alternativeSources ? _self._alternativeSources : alternativeSources // ignore: cast_nullable_to_non_nullable
as Map<VideoFormat, String>?,quality: freezed == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String?,bitrate: freezed == bitrate ? _self.bitrate : bitrate // ignore: cast_nullable_to_non_nullable
as int?,dimensions: freezed == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as VideoSize?,
  ));
}

/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoSizeCopyWith<$Res>? get dimensions {
    if (_self.dimensions == null) {
    return null;
  }

  return $VideoSizeCopyWith<$Res>(_self.dimensions!, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}
}

// dart format on
