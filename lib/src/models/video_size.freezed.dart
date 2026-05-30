// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_size.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoSize {

 double get width; double get height;
/// Create a copy of VideoSize
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoSizeCopyWith<VideoSize> get copyWith => _$VideoSizeCopyWithImpl<VideoSize>(this as VideoSize, _$identity);

  /// Serializes this VideoSize to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoSize&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height);

@override
String toString() {
  return 'VideoSize(width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class $VideoSizeCopyWith<$Res>  {
  factory $VideoSizeCopyWith(VideoSize value, $Res Function(VideoSize) _then) = _$VideoSizeCopyWithImpl;
@useResult
$Res call({
 double width, double height
});




}
/// @nodoc
class _$VideoSizeCopyWithImpl<$Res>
    implements $VideoSizeCopyWith<$Res> {
  _$VideoSizeCopyWithImpl(this._self, this._then);

  final VideoSize _self;
  final $Res Function(VideoSize) _then;

/// Create a copy of VideoSize
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? width = null,Object? height = null,}) {
  return _then(_self.copyWith(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoSize].
extension VideoSizePatterns on VideoSize {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoSize value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoSize() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoSize value)  $default,){
final _that = this;
switch (_that) {
case _VideoSize():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoSize value)?  $default,){
final _that = this;
switch (_that) {
case _VideoSize() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double width,  double height)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoSize() when $default != null:
return $default(_that.width,_that.height);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double width,  double height)  $default,) {final _that = this;
switch (_that) {
case _VideoSize():
return $default(_that.width,_that.height);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double width,  double height)?  $default,) {final _that = this;
switch (_that) {
case _VideoSize() when $default != null:
return $default(_that.width,_that.height);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoSize implements VideoSize {
  const _VideoSize(this.width, this.height);
  factory _VideoSize.fromJson(Map<String, dynamic> json) => _$VideoSizeFromJson(json);

@override final  double width;
@override final  double height;

/// Create a copy of VideoSize
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoSizeCopyWith<_VideoSize> get copyWith => __$VideoSizeCopyWithImpl<_VideoSize>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoSizeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoSize&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height);

@override
String toString() {
  return 'VideoSize(width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class _$VideoSizeCopyWith<$Res> implements $VideoSizeCopyWith<$Res> {
  factory _$VideoSizeCopyWith(_VideoSize value, $Res Function(_VideoSize) _then) = __$VideoSizeCopyWithImpl;
@override @useResult
$Res call({
 double width, double height
});




}
/// @nodoc
class __$VideoSizeCopyWithImpl<$Res>
    implements _$VideoSizeCopyWith<$Res> {
  __$VideoSizeCopyWithImpl(this._self, this._then);

  final _VideoSize _self;
  final $Res Function(_VideoSize) _then;

/// Create a copy of VideoSize
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = null,Object? height = null,}) {
  return _then(_VideoSize(
null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
