// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reel_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoSource {

 String get url; VideoFormat get format;@VideoFormatMapConverter() Map<VideoFormat, String>? get alternativeSources; String? get quality; int? get bitrate; Size? get dimensions;
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
 String url, VideoFormat format,@VideoFormatMapConverter() Map<VideoFormat, String>? alternativeSources, String? quality, int? bitrate, Size? dimensions
});


$SizeCopyWith<$Res>? get dimensions;

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
as Size?,
  ));
}
/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SizeCopyWith<$Res>? get dimensions {
    if (_self.dimensions == null) {
    return null;
  }

  return $SizeCopyWith<$Res>(_self.dimensions!, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  VideoFormat format, @VideoFormatMapConverter()  Map<VideoFormat, String>? alternativeSources,  String? quality,  int? bitrate,  Size? dimensions)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  VideoFormat format, @VideoFormatMapConverter()  Map<VideoFormat, String>? alternativeSources,  String? quality,  int? bitrate,  Size? dimensions)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  VideoFormat format, @VideoFormatMapConverter()  Map<VideoFormat, String>? alternativeSources,  String? quality,  int? bitrate,  Size? dimensions)?  $default,) {final _that = this;
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
@override final  Size? dimensions;

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
 String url, VideoFormat format,@VideoFormatMapConverter() Map<VideoFormat, String>? alternativeSources, String? quality, int? bitrate, Size? dimensions
});


@override $SizeCopyWith<$Res>? get dimensions;

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
as Size?,
  ));
}

/// Create a copy of VideoSource
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SizeCopyWith<$Res>? get dimensions {
    if (_self.dimensions == null) {
    return null;
  }

  return $SizeCopyWith<$Res>(_self.dimensions!, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}
}


/// @nodoc
mixin _$ReelModel {

 String get id;@Deprecated('Use videoSource instead for better streaming support') String? get videoUrl; VideoSource? get videoSource; String? get thumbnailUrl; Duration? get duration; ReelUser? get user; String? get caption; int get likesCount; int get commentsCount; int get sharesCount; bool get isLiked; bool get isBookmarked; bool get isFollowing; Map<String, dynamic>? get customData; ReelAudio? get audio; String? get quality; List<String>? get tags; bool get shouldLoop; bool get shouldAutoplay; int get views; String? get location;
/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReelModelCopyWith<ReelModel> get copyWith => _$ReelModelCopyWithImpl<ReelModel>(this as ReelModel, _$identity);

  /// Serializes this ReelModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReelModel&&(identical(other.id, id) || other.id == id)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.videoSource, videoSource) || other.videoSource == videoSource)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.user, user) || other.user == user)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.sharesCount, sharesCount) || other.sharesCount == sharesCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&const DeepCollectionEquality().equals(other.customData, customData)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.quality, quality) || other.quality == quality)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.shouldLoop, shouldLoop) || other.shouldLoop == shouldLoop)&&(identical(other.shouldAutoplay, shouldAutoplay) || other.shouldAutoplay == shouldAutoplay)&&(identical(other.views, views) || other.views == views)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,videoUrl,videoSource,thumbnailUrl,duration,user,caption,likesCount,commentsCount,sharesCount,isLiked,isBookmarked,isFollowing,const DeepCollectionEquality().hash(customData),audio,quality,const DeepCollectionEquality().hash(tags),shouldLoop,shouldAutoplay,views,location]);

@override
String toString() {
  return 'ReelModel(id: $id, videoUrl: $videoUrl, videoSource: $videoSource, thumbnailUrl: $thumbnailUrl, duration: $duration, user: $user, caption: $caption, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, isLiked: $isLiked, isBookmarked: $isBookmarked, isFollowing: $isFollowing, customData: $customData, audio: $audio, quality: $quality, tags: $tags, shouldLoop: $shouldLoop, shouldAutoplay: $shouldAutoplay, views: $views, location: $location)';
}


}

/// @nodoc
abstract mixin class $ReelModelCopyWith<$Res>  {
  factory $ReelModelCopyWith(ReelModel value, $Res Function(ReelModel) _then) = _$ReelModelCopyWithImpl;
@useResult
$Res call({
 String id,@Deprecated('Use videoSource instead for better streaming support') String? videoUrl, VideoSource? videoSource, String? thumbnailUrl, Duration? duration, ReelUser? user, String? caption, int likesCount, int commentsCount, int sharesCount, bool isLiked, bool isBookmarked, bool isFollowing, Map<String, dynamic>? customData, ReelAudio? audio, String? quality, List<String>? tags, bool shouldLoop, bool shouldAutoplay, int views, String? location
});


$VideoSourceCopyWith<$Res>? get videoSource;$ReelUserCopyWith<$Res>? get user;$ReelAudioCopyWith<$Res>? get audio;

}
/// @nodoc
class _$ReelModelCopyWithImpl<$Res>
    implements $ReelModelCopyWith<$Res> {
  _$ReelModelCopyWithImpl(this._self, this._then);

  final ReelModel _self;
  final $Res Function(ReelModel) _then;

/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? videoUrl = freezed,Object? videoSource = freezed,Object? thumbnailUrl = freezed,Object? duration = freezed,Object? user = freezed,Object? caption = freezed,Object? likesCount = null,Object? commentsCount = null,Object? sharesCount = null,Object? isLiked = null,Object? isBookmarked = null,Object? isFollowing = null,Object? customData = freezed,Object? audio = freezed,Object? quality = freezed,Object? tags = freezed,Object? shouldLoop = null,Object? shouldAutoplay = null,Object? views = null,Object? location = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,videoSource: freezed == videoSource ? _self.videoSource : videoSource // ignore: cast_nullable_to_non_nullable
as VideoSource?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ReelUser?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,sharesCount: null == sharesCount ? _self.sharesCount : sharesCount // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,customData: freezed == customData ? _self.customData : customData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,audio: freezed == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as ReelAudio?,quality: freezed == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,shouldLoop: null == shouldLoop ? _self.shouldLoop : shouldLoop // ignore: cast_nullable_to_non_nullable
as bool,shouldAutoplay: null == shouldAutoplay ? _self.shouldAutoplay : shouldAutoplay // ignore: cast_nullable_to_non_nullable
as bool,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoSourceCopyWith<$Res>? get videoSource {
    if (_self.videoSource == null) {
    return null;
  }

  return $VideoSourceCopyWith<$Res>(_self.videoSource!, (value) {
    return _then(_self.copyWith(videoSource: value));
  });
}/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReelUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $ReelUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReelAudioCopyWith<$Res>? get audio {
    if (_self.audio == null) {
    return null;
  }

  return $ReelAudioCopyWith<$Res>(_self.audio!, (value) {
    return _then(_self.copyWith(audio: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReelModel].
extension ReelModelPatterns on ReelModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReelModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReelModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReelModel value)  $default,){
final _that = this;
switch (_that) {
case _ReelModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReelModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReelModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @Deprecated('Use videoSource instead for better streaming support')  String? videoUrl,  VideoSource? videoSource,  String? thumbnailUrl,  Duration? duration,  ReelUser? user,  String? caption,  int likesCount,  int commentsCount,  int sharesCount,  bool isLiked,  bool isBookmarked,  bool isFollowing,  Map<String, dynamic>? customData,  ReelAudio? audio,  String? quality,  List<String>? tags,  bool shouldLoop,  bool shouldAutoplay,  int views,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReelModel() when $default != null:
return $default(_that.id,_that.videoUrl,_that.videoSource,_that.thumbnailUrl,_that.duration,_that.user,_that.caption,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.isLiked,_that.isBookmarked,_that.isFollowing,_that.customData,_that.audio,_that.quality,_that.tags,_that.shouldLoop,_that.shouldAutoplay,_that.views,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @Deprecated('Use videoSource instead for better streaming support')  String? videoUrl,  VideoSource? videoSource,  String? thumbnailUrl,  Duration? duration,  ReelUser? user,  String? caption,  int likesCount,  int commentsCount,  int sharesCount,  bool isLiked,  bool isBookmarked,  bool isFollowing,  Map<String, dynamic>? customData,  ReelAudio? audio,  String? quality,  List<String>? tags,  bool shouldLoop,  bool shouldAutoplay,  int views,  String? location)  $default,) {final _that = this;
switch (_that) {
case _ReelModel():
return $default(_that.id,_that.videoUrl,_that.videoSource,_that.thumbnailUrl,_that.duration,_that.user,_that.caption,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.isLiked,_that.isBookmarked,_that.isFollowing,_that.customData,_that.audio,_that.quality,_that.tags,_that.shouldLoop,_that.shouldAutoplay,_that.views,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @Deprecated('Use videoSource instead for better streaming support')  String? videoUrl,  VideoSource? videoSource,  String? thumbnailUrl,  Duration? duration,  ReelUser? user,  String? caption,  int likesCount,  int commentsCount,  int sharesCount,  bool isLiked,  bool isBookmarked,  bool isFollowing,  Map<String, dynamic>? customData,  ReelAudio? audio,  String? quality,  List<String>? tags,  bool shouldLoop,  bool shouldAutoplay,  int views,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _ReelModel() when $default != null:
return $default(_that.id,_that.videoUrl,_that.videoSource,_that.thumbnailUrl,_that.duration,_that.user,_that.caption,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.isLiked,_that.isBookmarked,_that.isFollowing,_that.customData,_that.audio,_that.quality,_that.tags,_that.shouldLoop,_that.shouldAutoplay,_that.views,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReelModel extends ReelModel {
  const _ReelModel({required this.id, @Deprecated('Use videoSource instead for better streaming support') this.videoUrl, this.videoSource, this.thumbnailUrl, this.duration, this.user, this.caption, this.likesCount = 0, this.commentsCount = 0, this.sharesCount = 0, this.isLiked = false, this.isBookmarked = false, this.isFollowing = false, final  Map<String, dynamic>? customData, this.audio, this.quality, final  List<String>? tags, this.shouldLoop = true, this.shouldAutoplay = true, this.views = 0, this.location}): assert(videoUrl != null || videoSource != null, 'Either videoUrl or videoSource must be provided'),_customData = customData,_tags = tags,super._();
  factory _ReelModel.fromJson(Map<String, dynamic> json) => _$ReelModelFromJson(json);

@override final  String id;
@override@Deprecated('Use videoSource instead for better streaming support') final  String? videoUrl;
@override final  VideoSource? videoSource;
@override final  String? thumbnailUrl;
@override final  Duration? duration;
@override final  ReelUser? user;
@override final  String? caption;
@override@JsonKey() final  int likesCount;
@override@JsonKey() final  int commentsCount;
@override@JsonKey() final  int sharesCount;
@override@JsonKey() final  bool isLiked;
@override@JsonKey() final  bool isBookmarked;
@override@JsonKey() final  bool isFollowing;
 final  Map<String, dynamic>? _customData;
@override Map<String, dynamic>? get customData {
  final value = _customData;
  if (value == null) return null;
  if (_customData is EqualUnmodifiableMapView) return _customData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  ReelAudio? audio;
@override final  String? quality;
 final  List<String>? _tags;
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  bool shouldLoop;
@override@JsonKey() final  bool shouldAutoplay;
@override@JsonKey() final  int views;
@override final  String? location;

/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReelModelCopyWith<_ReelModel> get copyWith => __$ReelModelCopyWithImpl<_ReelModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReelModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReelModel&&(identical(other.id, id) || other.id == id)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.videoSource, videoSource) || other.videoSource == videoSource)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.user, user) || other.user == user)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.sharesCount, sharesCount) || other.sharesCount == sharesCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&const DeepCollectionEquality().equals(other._customData, _customData)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.quality, quality) || other.quality == quality)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.shouldLoop, shouldLoop) || other.shouldLoop == shouldLoop)&&(identical(other.shouldAutoplay, shouldAutoplay) || other.shouldAutoplay == shouldAutoplay)&&(identical(other.views, views) || other.views == views)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,videoUrl,videoSource,thumbnailUrl,duration,user,caption,likesCount,commentsCount,sharesCount,isLiked,isBookmarked,isFollowing,const DeepCollectionEquality().hash(_customData),audio,quality,const DeepCollectionEquality().hash(_tags),shouldLoop,shouldAutoplay,views,location]);

@override
String toString() {
  return 'ReelModel(id: $id, videoUrl: $videoUrl, videoSource: $videoSource, thumbnailUrl: $thumbnailUrl, duration: $duration, user: $user, caption: $caption, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, isLiked: $isLiked, isBookmarked: $isBookmarked, isFollowing: $isFollowing, customData: $customData, audio: $audio, quality: $quality, tags: $tags, shouldLoop: $shouldLoop, shouldAutoplay: $shouldAutoplay, views: $views, location: $location)';
}


}

/// @nodoc
abstract mixin class _$ReelModelCopyWith<$Res> implements $ReelModelCopyWith<$Res> {
  factory _$ReelModelCopyWith(_ReelModel value, $Res Function(_ReelModel) _then) = __$ReelModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@Deprecated('Use videoSource instead for better streaming support') String? videoUrl, VideoSource? videoSource, String? thumbnailUrl, Duration? duration, ReelUser? user, String? caption, int likesCount, int commentsCount, int sharesCount, bool isLiked, bool isBookmarked, bool isFollowing, Map<String, dynamic>? customData, ReelAudio? audio, String? quality, List<String>? tags, bool shouldLoop, bool shouldAutoplay, int views, String? location
});


@override $VideoSourceCopyWith<$Res>? get videoSource;@override $ReelUserCopyWith<$Res>? get user;@override $ReelAudioCopyWith<$Res>? get audio;

}
/// @nodoc
class __$ReelModelCopyWithImpl<$Res>
    implements _$ReelModelCopyWith<$Res> {
  __$ReelModelCopyWithImpl(this._self, this._then);

  final _ReelModel _self;
  final $Res Function(_ReelModel) _then;

/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? videoUrl = freezed,Object? videoSource = freezed,Object? thumbnailUrl = freezed,Object? duration = freezed,Object? user = freezed,Object? caption = freezed,Object? likesCount = null,Object? commentsCount = null,Object? sharesCount = null,Object? isLiked = null,Object? isBookmarked = null,Object? isFollowing = null,Object? customData = freezed,Object? audio = freezed,Object? quality = freezed,Object? tags = freezed,Object? shouldLoop = null,Object? shouldAutoplay = null,Object? views = null,Object? location = freezed,}) {
  return _then(_ReelModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,videoUrl: freezed == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String?,videoSource: freezed == videoSource ? _self.videoSource : videoSource // ignore: cast_nullable_to_non_nullable
as VideoSource?,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration?,user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ReelUser?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,sharesCount: null == sharesCount ? _self.sharesCount : sharesCount // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,isBookmarked: null == isBookmarked ? _self.isBookmarked : isBookmarked // ignore: cast_nullable_to_non_nullable
as bool,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,customData: freezed == customData ? _self._customData : customData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,audio: freezed == audio ? _self.audio : audio // ignore: cast_nullable_to_non_nullable
as ReelAudio?,quality: freezed == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,shouldLoop: null == shouldLoop ? _self.shouldLoop : shouldLoop // ignore: cast_nullable_to_non_nullable
as bool,shouldAutoplay: null == shouldAutoplay ? _self.shouldAutoplay : shouldAutoplay // ignore: cast_nullable_to_non_nullable
as bool,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoSourceCopyWith<$Res>? get videoSource {
    if (_self.videoSource == null) {
    return null;
  }

  return $VideoSourceCopyWith<$Res>(_self.videoSource!, (value) {
    return _then(_self.copyWith(videoSource: value));
  });
}/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReelUserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $ReelUserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReelAudioCopyWith<$Res>? get audio {
    if (_self.audio == null) {
    return null;
  }

  return $ReelAudioCopyWith<$Res>(_self.audio!, (value) {
    return _then(_self.copyWith(audio: value));
  });
}
}


/// @nodoc
mixin _$ReelUser {

 String get id; String get username; String? get displayName; String? get profilePictureUrl; bool get isVerified; bool get isFollowing; int get followersCount; int get followingCount;
/// Create a copy of ReelUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReelUserCopyWith<ReelUser> get copyWith => _$ReelUserCopyWithImpl<ReelUser>(this as ReelUser, _$identity);

  /// Serializes this ReelUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReelUser&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.profilePictureUrl, profilePictureUrl) || other.profilePictureUrl == profilePictureUrl)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,displayName,profilePictureUrl,isVerified,isFollowing,followersCount,followingCount);

@override
String toString() {
  return 'ReelUser(id: $id, username: $username, displayName: $displayName, profilePictureUrl: $profilePictureUrl, isVerified: $isVerified, isFollowing: $isFollowing, followersCount: $followersCount, followingCount: $followingCount)';
}


}

/// @nodoc
abstract mixin class $ReelUserCopyWith<$Res>  {
  factory $ReelUserCopyWith(ReelUser value, $Res Function(ReelUser) _then) = _$ReelUserCopyWithImpl;
@useResult
$Res call({
 String id, String username, String? displayName, String? profilePictureUrl, bool isVerified, bool isFollowing, int followersCount, int followingCount
});




}
/// @nodoc
class _$ReelUserCopyWithImpl<$Res>
    implements $ReelUserCopyWith<$Res> {
  _$ReelUserCopyWithImpl(this._self, this._then);

  final ReelUser _self;
  final $Res Function(ReelUser) _then;

/// Create a copy of ReelUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? displayName = freezed,Object? profilePictureUrl = freezed,Object? isVerified = null,Object? isFollowing = null,Object? followersCount = null,Object? followingCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,profilePictureUrl: freezed == profilePictureUrl ? _self.profilePictureUrl : profilePictureUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,followersCount: null == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReelUser].
extension ReelUserPatterns on ReelUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReelUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReelUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReelUser value)  $default,){
final _that = this;
switch (_that) {
case _ReelUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReelUser value)?  $default,){
final _that = this;
switch (_that) {
case _ReelUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String username,  String? displayName,  String? profilePictureUrl,  bool isVerified,  bool isFollowing,  int followersCount,  int followingCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReelUser() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.profilePictureUrl,_that.isVerified,_that.isFollowing,_that.followersCount,_that.followingCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String username,  String? displayName,  String? profilePictureUrl,  bool isVerified,  bool isFollowing,  int followersCount,  int followingCount)  $default,) {final _that = this;
switch (_that) {
case _ReelUser():
return $default(_that.id,_that.username,_that.displayName,_that.profilePictureUrl,_that.isVerified,_that.isFollowing,_that.followersCount,_that.followingCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String username,  String? displayName,  String? profilePictureUrl,  bool isVerified,  bool isFollowing,  int followersCount,  int followingCount)?  $default,) {final _that = this;
switch (_that) {
case _ReelUser() when $default != null:
return $default(_that.id,_that.username,_that.displayName,_that.profilePictureUrl,_that.isVerified,_that.isFollowing,_that.followersCount,_that.followingCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReelUser implements ReelUser {
  const _ReelUser({required this.id, required this.username, this.displayName, this.profilePictureUrl, this.isVerified = false, this.isFollowing = false, this.followersCount = 0, this.followingCount = 0});
  factory _ReelUser.fromJson(Map<String, dynamic> json) => _$ReelUserFromJson(json);

@override final  String id;
@override final  String username;
@override final  String? displayName;
@override final  String? profilePictureUrl;
@override@JsonKey() final  bool isVerified;
@override@JsonKey() final  bool isFollowing;
@override@JsonKey() final  int followersCount;
@override@JsonKey() final  int followingCount;

/// Create a copy of ReelUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReelUserCopyWith<_ReelUser> get copyWith => __$ReelUserCopyWithImpl<_ReelUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReelUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReelUser&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.profilePictureUrl, profilePictureUrl) || other.profilePictureUrl == profilePictureUrl)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,displayName,profilePictureUrl,isVerified,isFollowing,followersCount,followingCount);

@override
String toString() {
  return 'ReelUser(id: $id, username: $username, displayName: $displayName, profilePictureUrl: $profilePictureUrl, isVerified: $isVerified, isFollowing: $isFollowing, followersCount: $followersCount, followingCount: $followingCount)';
}


}

/// @nodoc
abstract mixin class _$ReelUserCopyWith<$Res> implements $ReelUserCopyWith<$Res> {
  factory _$ReelUserCopyWith(_ReelUser value, $Res Function(_ReelUser) _then) = __$ReelUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String username, String? displayName, String? profilePictureUrl, bool isVerified, bool isFollowing, int followersCount, int followingCount
});




}
/// @nodoc
class __$ReelUserCopyWithImpl<$Res>
    implements _$ReelUserCopyWith<$Res> {
  __$ReelUserCopyWithImpl(this._self, this._then);

  final _ReelUser _self;
  final $Res Function(_ReelUser) _then;

/// Create a copy of ReelUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? displayName = freezed,Object? profilePictureUrl = freezed,Object? isVerified = null,Object? isFollowing = null,Object? followersCount = null,Object? followingCount = null,}) {
  return _then(_ReelUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,profilePictureUrl: freezed == profilePictureUrl ? _self.profilePictureUrl : profilePictureUrl // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,isFollowing: null == isFollowing ? _self.isFollowing : isFollowing // ignore: cast_nullable_to_non_nullable
as bool,followersCount: null == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


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


/// @nodoc
mixin _$Size {

 double get width; double get height;
/// Create a copy of Size
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SizeCopyWith<Size> get copyWith => _$SizeCopyWithImpl<Size>(this as Size, _$identity);

  /// Serializes this Size to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Size&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height);

@override
String toString() {
  return 'Size(width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class $SizeCopyWith<$Res>  {
  factory $SizeCopyWith(Size value, $Res Function(Size) _then) = _$SizeCopyWithImpl;
@useResult
$Res call({
 double width, double height
});




}
/// @nodoc
class _$SizeCopyWithImpl<$Res>
    implements $SizeCopyWith<$Res> {
  _$SizeCopyWithImpl(this._self, this._then);

  final Size _self;
  final $Res Function(Size) _then;

/// Create a copy of Size
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? width = null,Object? height = null,}) {
  return _then(_self.copyWith(
width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Size].
extension SizePatterns on Size {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Size value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Size() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Size value)  $default,){
final _that = this;
switch (_that) {
case _Size():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Size value)?  $default,){
final _that = this;
switch (_that) {
case _Size() when $default != null:
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
case _Size() when $default != null:
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
case _Size():
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
case _Size() when $default != null:
return $default(_that.width,_that.height);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Size implements Size {
  const _Size(this.width, this.height);
  factory _Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);

@override final  double width;
@override final  double height;

/// Create a copy of Size
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SizeCopyWith<_Size> get copyWith => __$SizeCopyWithImpl<_Size>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SizeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Size&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,width,height);

@override
String toString() {
  return 'Size(width: $width, height: $height)';
}


}

/// @nodoc
abstract mixin class _$SizeCopyWith<$Res> implements $SizeCopyWith<$Res> {
  factory _$SizeCopyWith(_Size value, $Res Function(_Size) _then) = __$SizeCopyWithImpl;
@override @useResult
$Res call({
 double width, double height
});




}
/// @nodoc
class __$SizeCopyWithImpl<$Res>
    implements _$SizeCopyWith<$Res> {
  __$SizeCopyWithImpl(this._self, this._then);

  final _Size _self;
  final $Res Function(_Size) _then;

/// Create a copy of Size
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? width = null,Object? height = null,}) {
  return _then(_Size(
null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
