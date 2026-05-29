// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoSource _$VideoSourceFromJson(Map<String, dynamic> json) => _VideoSource(
  url: json['url'] as String,
  format:
      $enumDecodeNullable(_$VideoFormatEnumMap, json['format']) ??
      VideoFormat.hls,
  alternativeSources: const VideoFormatMapConverter().fromJson(
    json['alternativeSources'] as Map<String, dynamic>?,
  ),
  quality: json['quality'] as String?,
  bitrate: (json['bitrate'] as num?)?.toInt(),
  dimensions: json['dimensions'] == null
      ? null
      : Size.fromJson(json['dimensions'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VideoSourceToJson(_VideoSource instance) =>
    <String, dynamic>{
      'url': instance.url,
      'format': _$VideoFormatEnumMap[instance.format]!,
      'alternativeSources': const VideoFormatMapConverter().toJson(
        instance.alternativeSources,
      ),
      'quality': instance.quality,
      'bitrate': instance.bitrate,
      'dimensions': instance.dimensions,
    };

const _$VideoFormatEnumMap = {
  VideoFormat.mp4: 'mp4',
  VideoFormat.hls: 'hls',
  VideoFormat.dash: 'dash',
};

_ReelModel _$ReelModelFromJson(Map<String, dynamic> json) => _ReelModel(
  id: json['id'] as String,
  videoUrl: json['videoUrl'] as String?,
  videoSource: json['videoSource'] == null
      ? null
      : VideoSource.fromJson(json['videoSource'] as Map<String, dynamic>),
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
      'videoUrl': instance.videoUrl,
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

_ReelAudio _$ReelAudioFromJson(Map<String, dynamic> json) => _ReelAudio(
  title: json['title'] as String?,
  artist: json['artist'] as String?,
  coverUrl: json['coverUrl'] as String?,
  audioUrl: json['audioUrl'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
);

Map<String, dynamic> _$ReelAudioToJson(_ReelAudio instance) =>
    <String, dynamic>{
      'title': instance.title,
      'artist': instance.artist,
      'coverUrl': instance.coverUrl,
      'audioUrl': instance.audioUrl,
      'duration': instance.duration,
    };

_Size _$SizeFromJson(Map<String, dynamic> json) => _Size(
  (json['width'] as num).toDouble(),
  (json['height'] as num).toDouble(),
);

Map<String, dynamic> _$SizeToJson(_Size instance) => <String, dynamic>{
  'width': instance.width,
  'height': instance.height,
};
