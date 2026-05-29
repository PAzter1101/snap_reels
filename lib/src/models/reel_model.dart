import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:snap_reels/src/models/reel_audio.dart';
import 'package:snap_reels/src/models/reel_user.dart';
import 'package:snap_reels/src/models/video_format.dart';
import 'package:snap_reels/src/models/video_source.dart';

export 'reel_audio.dart';
export 'reel_user.dart';
export 'video_format.dart';
export 'video_size.dart';
export 'video_source.dart';

part 'reel_model.freezed.dart';
part 'reel_model.g.dart';

/// A single reel item with all its metadata.
@freezed
abstract class ReelModel with _$ReelModel {
  /// Creates a [ReelModel]. Only [id] and [videoSource] are required.
  const factory ReelModel({
    required String id,
    required VideoSource videoSource,
    String? thumbnailUrl,
    Duration? duration,
    ReelUser? user,
    String? caption,
    @Default(0) int likesCount,
    @Default(0) int commentsCount,
    @Default(0) int sharesCount,
    @Default(false) bool isLiked,
    @Default(false) bool isBookmarked,
    @Default(false) bool isFollowing,
    Map<String, dynamic>? customData,
    ReelAudio? audio,
    String? quality,
    List<String>? tags,
    @Default(true) bool shouldLoop,
    @Default(true) bool shouldAutoplay,
    @Default(0) int views,
    String? location,
  }) = _ReelModel;

  const ReelModel._();

  /// Creates a reel served via HLS (recommended for adaptive streaming).
  factory ReelModel.hls({
    required String id,
    required String hlsUrl,
    Map<VideoFormat, String>? alternativeSources,
    String? thumbnailUrl,
    Duration? duration,
    ReelUser? user,
    String? caption,
    int likesCount = 0,
    int commentsCount = 0,
    int sharesCount = 0,
    bool isLiked = false,
    bool isBookmarked = false,
    bool isFollowing = false,
    Map<String, dynamic>? customData,
    ReelAudio? audio,
    String? quality,
    List<String>? tags,
    bool shouldLoop = true,
    bool shouldAutoplay = true,
    int views = 0,
    String? location,
  }) => ReelModel(
    id: id,
    videoSource: VideoSource(
      url: hlsUrl,
      alternativeSources: alternativeSources,
    ),
    thumbnailUrl: thumbnailUrl,
    duration: duration,
    user: user,
    caption: caption,
    likesCount: likesCount,
    commentsCount: commentsCount,
    sharesCount: sharesCount,
    isLiked: isLiked,
    isBookmarked: isBookmarked,
    isFollowing: isFollowing,
    customData: customData,
    audio: audio,
    quality: quality,
    tags: tags,
    shouldLoop: shouldLoop,
    shouldAutoplay: shouldAutoplay,
    views: views,
    location: location,
  );

  /// Creates a reel served via DASH.
  factory ReelModel.dash({
    required String id,
    required String dashUrl,
    Map<VideoFormat, String>? alternativeSources,
    String? thumbnailUrl,
    Duration? duration,
    ReelUser? user,
    String? caption,
    int likesCount = 0,
    int commentsCount = 0,
    int sharesCount = 0,
    bool isLiked = false,
    bool isBookmarked = false,
    bool isFollowing = false,
    Map<String, dynamic>? customData,
    ReelAudio? audio,
    String? quality,
    List<String>? tags,
    bool shouldLoop = true,
    bool shouldAutoplay = true,
    int views = 0,
    String? location,
  }) => ReelModel(
    id: id,
    videoSource: VideoSource(
      url: dashUrl,
      format: VideoFormat.dash,
      alternativeSources: alternativeSources,
    ),
    thumbnailUrl: thumbnailUrl,
    duration: duration,
    user: user,
    caption: caption,
    likesCount: likesCount,
    commentsCount: commentsCount,
    sharesCount: sharesCount,
    isLiked: isLiked,
    isBookmarked: isBookmarked,
    isFollowing: isFollowing,
    customData: customData,
    audio: audio,
    quality: quality,
    tags: tags,
    shouldLoop: shouldLoop,
    shouldAutoplay: shouldAutoplay,
    views: views,
    location: location,
  );

  /// Creates a reel served via progressive MP4.
  factory ReelModel.mp4({
    required String id,
    required String mp4Url,
    Map<VideoFormat, String>? alternativeSources,
    String? thumbnailUrl,
    Duration? duration,
    ReelUser? user,
    String? caption,
    int likesCount = 0,
    int commentsCount = 0,
    int sharesCount = 0,
    bool isLiked = false,
    bool isBookmarked = false,
    bool isFollowing = false,
    Map<String, dynamic>? customData,
    ReelAudio? audio,
    String? quality,
    List<String>? tags,
    bool shouldLoop = true,
    bool shouldAutoplay = true,
    int views = 0,
    String? location,
  }) => ReelModel(
    id: id,
    videoSource: VideoSource(
      url: mp4Url,
      format: VideoFormat.mp4,
      alternativeSources: alternativeSources,
    ),
    thumbnailUrl: thumbnailUrl,
    duration: duration,
    user: user,
    caption: caption,
    likesCount: likesCount,
    commentsCount: commentsCount,
    sharesCount: sharesCount,
    isLiked: isLiked,
    isBookmarked: isBookmarked,
    isFollowing: isFollowing,
    customData: customData,
    audio: audio,
    quality: quality,
    tags: tags,
    shouldLoop: shouldLoop,
    shouldAutoplay: shouldAutoplay,
    views: views,
    location: location,
  );

  /// Deserializes a [ReelModel] from JSON.
  factory ReelModel.fromJson(Map<String, Object?> json) =>
      _$ReelModelFromJson(json);

  /// Hashtags surfaced for UI — currently a synonym of [tags].
  List<String> get hashtags => tags ?? const [];

  /// Music title pulled from the optional [audio] block.
  String? get musicTitle => audio?.title;

  /// Format of the primary video source.
  VideoFormat get videoFormat => videoSource.format;

  /// Whether this reel can serve the given [format].
  bool hasStreamingFormat(VideoFormat format) => videoSource.hasFormat(format);

  /// Returns the URL for [format] when available, otherwise null.
  String? getUrlForFormat(VideoFormat format) => videoSource.hasFormat(format)
      ? videoSource.getUrlForFormat(format)
      : null;
}
