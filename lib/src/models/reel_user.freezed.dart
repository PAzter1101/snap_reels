// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reel_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

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

// dart format on
