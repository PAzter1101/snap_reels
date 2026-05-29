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
mixin _$ReelModel {

 String get id; VideoSource get videoSource; String? get thumbnailUrl; Duration? get duration; ReelUser? get user; String? get caption; int get likesCount; int get commentsCount; int get sharesCount; bool get isLiked; bool get isBookmarked; bool get isFollowing; Map<String, dynamic>? get customData; ReelAudio? get audio; String? get quality; List<String>? get tags; bool get shouldLoop; bool get shouldAutoplay; int get views; String? get location;
/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReelModelCopyWith<ReelModel> get copyWith => _$ReelModelCopyWithImpl<ReelModel>(this as ReelModel, _$identity);

  /// Serializes this ReelModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReelModel&&(identical(other.id, id) || other.id == id)&&(identical(other.videoSource, videoSource) || other.videoSource == videoSource)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.user, user) || other.user == user)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.sharesCount, sharesCount) || other.sharesCount == sharesCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&const DeepCollectionEquality().equals(other.customData, customData)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.quality, quality) || other.quality == quality)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.shouldLoop, shouldLoop) || other.shouldLoop == shouldLoop)&&(identical(other.shouldAutoplay, shouldAutoplay) || other.shouldAutoplay == shouldAutoplay)&&(identical(other.views, views) || other.views == views)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,videoSource,thumbnailUrl,duration,user,caption,likesCount,commentsCount,sharesCount,isLiked,isBookmarked,isFollowing,const DeepCollectionEquality().hash(customData),audio,quality,const DeepCollectionEquality().hash(tags),shouldLoop,shouldAutoplay,views,location]);

@override
String toString() {
  return 'ReelModel(id: $id, videoSource: $videoSource, thumbnailUrl: $thumbnailUrl, duration: $duration, user: $user, caption: $caption, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, isLiked: $isLiked, isBookmarked: $isBookmarked, isFollowing: $isFollowing, customData: $customData, audio: $audio, quality: $quality, tags: $tags, shouldLoop: $shouldLoop, shouldAutoplay: $shouldAutoplay, views: $views, location: $location)';
}


}

/// @nodoc
abstract mixin class $ReelModelCopyWith<$Res>  {
  factory $ReelModelCopyWith(ReelModel value, $Res Function(ReelModel) _then) = _$ReelModelCopyWithImpl;
@useResult
$Res call({
 String id, VideoSource videoSource, String? thumbnailUrl, Duration? duration, ReelUser? user, String? caption, int likesCount, int commentsCount, int sharesCount, bool isLiked, bool isBookmarked, bool isFollowing, Map<String, dynamic>? customData, ReelAudio? audio, String? quality, List<String>? tags, bool shouldLoop, bool shouldAutoplay, int views, String? location
});


$VideoSourceCopyWith<$Res> get videoSource;$ReelUserCopyWith<$Res>? get user;$ReelAudioCopyWith<$Res>? get audio;

}
/// @nodoc
class _$ReelModelCopyWithImpl<$Res>
    implements $ReelModelCopyWith<$Res> {
  _$ReelModelCopyWithImpl(this._self, this._then);

  final ReelModel _self;
  final $Res Function(ReelModel) _then;

/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? videoSource = null,Object? thumbnailUrl = freezed,Object? duration = freezed,Object? user = freezed,Object? caption = freezed,Object? likesCount = null,Object? commentsCount = null,Object? sharesCount = null,Object? isLiked = null,Object? isBookmarked = null,Object? isFollowing = null,Object? customData = freezed,Object? audio = freezed,Object? quality = freezed,Object? tags = freezed,Object? shouldLoop = null,Object? shouldAutoplay = null,Object? views = null,Object? location = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,videoSource: null == videoSource ? _self.videoSource : videoSource // ignore: cast_nullable_to_non_nullable
as VideoSource,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
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
$VideoSourceCopyWith<$Res> get videoSource {
  
  return $VideoSourceCopyWith<$Res>(_self.videoSource, (value) {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  VideoSource videoSource,  String? thumbnailUrl,  Duration? duration,  ReelUser? user,  String? caption,  int likesCount,  int commentsCount,  int sharesCount,  bool isLiked,  bool isBookmarked,  bool isFollowing,  Map<String, dynamic>? customData,  ReelAudio? audio,  String? quality,  List<String>? tags,  bool shouldLoop,  bool shouldAutoplay,  int views,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReelModel() when $default != null:
return $default(_that.id,_that.videoSource,_that.thumbnailUrl,_that.duration,_that.user,_that.caption,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.isLiked,_that.isBookmarked,_that.isFollowing,_that.customData,_that.audio,_that.quality,_that.tags,_that.shouldLoop,_that.shouldAutoplay,_that.views,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  VideoSource videoSource,  String? thumbnailUrl,  Duration? duration,  ReelUser? user,  String? caption,  int likesCount,  int commentsCount,  int sharesCount,  bool isLiked,  bool isBookmarked,  bool isFollowing,  Map<String, dynamic>? customData,  ReelAudio? audio,  String? quality,  List<String>? tags,  bool shouldLoop,  bool shouldAutoplay,  int views,  String? location)  $default,) {final _that = this;
switch (_that) {
case _ReelModel():
return $default(_that.id,_that.videoSource,_that.thumbnailUrl,_that.duration,_that.user,_that.caption,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.isLiked,_that.isBookmarked,_that.isFollowing,_that.customData,_that.audio,_that.quality,_that.tags,_that.shouldLoop,_that.shouldAutoplay,_that.views,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  VideoSource videoSource,  String? thumbnailUrl,  Duration? duration,  ReelUser? user,  String? caption,  int likesCount,  int commentsCount,  int sharesCount,  bool isLiked,  bool isBookmarked,  bool isFollowing,  Map<String, dynamic>? customData,  ReelAudio? audio,  String? quality,  List<String>? tags,  bool shouldLoop,  bool shouldAutoplay,  int views,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _ReelModel() when $default != null:
return $default(_that.id,_that.videoSource,_that.thumbnailUrl,_that.duration,_that.user,_that.caption,_that.likesCount,_that.commentsCount,_that.sharesCount,_that.isLiked,_that.isBookmarked,_that.isFollowing,_that.customData,_that.audio,_that.quality,_that.tags,_that.shouldLoop,_that.shouldAutoplay,_that.views,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReelModel extends ReelModel {
  const _ReelModel({required this.id, required this.videoSource, this.thumbnailUrl, this.duration, this.user, this.caption, this.likesCount = 0, this.commentsCount = 0, this.sharesCount = 0, this.isLiked = false, this.isBookmarked = false, this.isFollowing = false, final  Map<String, dynamic>? customData, this.audio, this.quality, final  List<String>? tags, this.shouldLoop = true, this.shouldAutoplay = true, this.views = 0, this.location}): _customData = customData,_tags = tags,super._();
  factory _ReelModel.fromJson(Map<String, dynamic> json) => _$ReelModelFromJson(json);

@override final  String id;
@override final  VideoSource videoSource;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReelModel&&(identical(other.id, id) || other.id == id)&&(identical(other.videoSource, videoSource) || other.videoSource == videoSource)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.user, user) || other.user == user)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount)&&(identical(other.sharesCount, sharesCount) || other.sharesCount == sharesCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.isBookmarked, isBookmarked) || other.isBookmarked == isBookmarked)&&(identical(other.isFollowing, isFollowing) || other.isFollowing == isFollowing)&&const DeepCollectionEquality().equals(other._customData, _customData)&&(identical(other.audio, audio) || other.audio == audio)&&(identical(other.quality, quality) || other.quality == quality)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.shouldLoop, shouldLoop) || other.shouldLoop == shouldLoop)&&(identical(other.shouldAutoplay, shouldAutoplay) || other.shouldAutoplay == shouldAutoplay)&&(identical(other.views, views) || other.views == views)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,videoSource,thumbnailUrl,duration,user,caption,likesCount,commentsCount,sharesCount,isLiked,isBookmarked,isFollowing,const DeepCollectionEquality().hash(_customData),audio,quality,const DeepCollectionEquality().hash(_tags),shouldLoop,shouldAutoplay,views,location]);

@override
String toString() {
  return 'ReelModel(id: $id, videoSource: $videoSource, thumbnailUrl: $thumbnailUrl, duration: $duration, user: $user, caption: $caption, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, isLiked: $isLiked, isBookmarked: $isBookmarked, isFollowing: $isFollowing, customData: $customData, audio: $audio, quality: $quality, tags: $tags, shouldLoop: $shouldLoop, shouldAutoplay: $shouldAutoplay, views: $views, location: $location)';
}


}

/// @nodoc
abstract mixin class _$ReelModelCopyWith<$Res> implements $ReelModelCopyWith<$Res> {
  factory _$ReelModelCopyWith(_ReelModel value, $Res Function(_ReelModel) _then) = __$ReelModelCopyWithImpl;
@override @useResult
$Res call({
 String id, VideoSource videoSource, String? thumbnailUrl, Duration? duration, ReelUser? user, String? caption, int likesCount, int commentsCount, int sharesCount, bool isLiked, bool isBookmarked, bool isFollowing, Map<String, dynamic>? customData, ReelAudio? audio, String? quality, List<String>? tags, bool shouldLoop, bool shouldAutoplay, int views, String? location
});


@override $VideoSourceCopyWith<$Res> get videoSource;@override $ReelUserCopyWith<$Res>? get user;@override $ReelAudioCopyWith<$Res>? get audio;

}
/// @nodoc
class __$ReelModelCopyWithImpl<$Res>
    implements _$ReelModelCopyWith<$Res> {
  __$ReelModelCopyWithImpl(this._self, this._then);

  final _ReelModel _self;
  final $Res Function(_ReelModel) _then;

/// Create a copy of ReelModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? videoSource = null,Object? thumbnailUrl = freezed,Object? duration = freezed,Object? user = freezed,Object? caption = freezed,Object? likesCount = null,Object? commentsCount = null,Object? sharesCount = null,Object? isLiked = null,Object? isBookmarked = null,Object? isFollowing = null,Object? customData = freezed,Object? audio = freezed,Object? quality = freezed,Object? tags = freezed,Object? shouldLoop = null,Object? shouldAutoplay = null,Object? views = null,Object? location = freezed,}) {
  return _then(_ReelModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,videoSource: null == videoSource ? _self.videoSource : videoSource // ignore: cast_nullable_to_non_nullable
as VideoSource,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
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
$VideoSourceCopyWith<$Res> get videoSource {
  
  return $VideoSourceCopyWith<$Res>(_self.videoSource, (value) {
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

// dart format on
