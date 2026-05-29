// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReelUser _$ReelUserFromJson(Map<String, dynamic> json) => _ReelUser(
  id: json['id'] as String,
  username: json['username'] as String,
  displayName: json['displayName'] as String?,
  profilePictureUrl: json['profilePictureUrl'] as String?,
  isVerified: json['isVerified'] as bool? ?? false,
  isFollowing: json['isFollowing'] as bool? ?? false,
  followersCount: (json['followersCount'] as num?)?.toInt() ?? 0,
  followingCount: (json['followingCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ReelUserToJson(_ReelUser instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'displayName': instance.displayName,
  'profilePictureUrl': instance.profilePictureUrl,
  'isVerified': instance.isVerified,
  'isFollowing': instance.isFollowing,
  'followersCount': instance.followersCount,
  'followingCount': instance.followingCount,
};
