// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReelModel _$ReelModelFromJson(Map<String, dynamic> json) => _ReelModel(
  id: json['id'] as String,
  videoSource: VideoSource.fromJson(
    json['videoSource'] as Map<String, dynamic>,
  ),
  thumbnailUrl: json['thumbnailUrl'] as String?,
  duration: json['duration'] == null
      ? null
      : Duration(microseconds: (json['duration'] as num).toInt()),
  user: json['user'] == null
      ? null
      : ReelUser.fromJson(json['user'] as Map<String, dynamic>),
  caption: json['caption'] as String?,
  likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
  commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
  sharesCount: (json['sharesCount'] as num?)?.toInt() ?? 0,
  isLiked: json['isLiked'] as bool? ?? false,
  isBookmarked: json['isBookmarked'] as bool? ?? false,
  isFollowing: json['isFollowing'] as bool? ?? false,
  customData: json['customData'] as Map<String, dynamic>?,
  audio: json['audio'] == null
      ? null
      : ReelAudio.fromJson(json['audio'] as Map<String, dynamic>),
  quality: json['quality'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  shouldLoop: json['shouldLoop'] as bool? ?? true,
  shouldAutoplay: json['shouldAutoplay'] as bool? ?? true,
  views: (json['views'] as num?)?.toInt() ?? 0,
  location: json['location'] as String?,
);

Map<String, dynamic> _$ReelModelToJson(_ReelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'videoSource': instance.videoSource,
      'thumbnailUrl': instance.thumbnailUrl,
      'duration': instance.duration?.inMicroseconds,
      'user': instance.user,
      'caption': instance.caption,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'sharesCount': instance.sharesCount,
      'isLiked': instance.isLiked,
      'isBookmarked': instance.isBookmarked,
      'isFollowing': instance.isFollowing,
      'customData': instance.customData,
      'audio': instance.audio,
      'quality': instance.quality,
      'tags': instance.tags,
      'shouldLoop': instance.shouldLoop,
      'shouldAutoplay': instance.shouldAutoplay,
      'views': instance.views,
      'location': instance.location,
    };
