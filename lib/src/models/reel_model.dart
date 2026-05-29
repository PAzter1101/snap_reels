import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:snap_reels/src/models/converters.dart';

part 'reel_model.freezed.dart';
part 'reel_model.g.dart';

/// Supported video streaming formats.
enum VideoFormat {
  mp4,
  hls,
  dash
  ;

  /// Parses a string representation; falls back to [VideoFormat.hls] for
  /// unknown values to preserve backward compatibility.
  static VideoFormat fromString(String format) {
    switch (format.toLowerCase()) {
      case 'mp4':
        return VideoFormat.mp4;
      case 'hls':
        return VideoFormat.hls;
      case 'dash':
        return VideoFormat.dash;
      default:
        return VideoFormat.hls;
    }
  }
}

/// Video source configuration for different streaming formats.
@freezed
abstract class VideoSource with _$VideoSource {
  const factory VideoSource({
    required String url,
    @Default(VideoFormat.hls) VideoFormat format,
    @VideoFormatMapConverter() Map<VideoFormat, String>? alternativeSources,
    String? quality,
    int? bitrate,
    Size? dimensions,
  }) = _VideoSource;

  const VideoSource._();

  factory VideoSource.fromJson(Map<String, Object?> json) =>
      _$VideoSourceFromJson(json);

  /// Returns the URL for [target]; falls back to the primary [url] when no
  /// dedicated alternative is registered.
  String getUrlForFormat(VideoFormat target) {
    if (format == target) return url;
    return alternativeSources?[target] ?? url;
  }

  /// Whether this source can serve the given [target] format.
  bool hasFormat(VideoFormat target) =>
      format == target || alternativeSources?.containsKey(target) == true;
}

/// A single reel item with all its metadata.
@freezed
abstract class ReelModel with _$ReelModel {
  @Assert(
    'videoUrl != null || videoSource != null',
    'Either videoUrl or videoSource must be provided',
  )
  const factory ReelModel({
    required String id,
    @Deprecated('Use videoSource instead for better streaming support')
    String? videoUrl,
    VideoSource? videoSource,
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

  factory ReelModel.fromJson(Map<String, Object?> json) =>
      _$ReelModelFromJson(json);

  /// Hashtags surfaced for UI — currently a synonym of [tags].
  List<String> get hashtags => tags ?? const [];

  /// Music title pulled from the optional [audio] block.
  String? get musicTitle => audio?.title;

  /// Convenience getter for the playable URL, transparently honouring the
  /// deprecated [videoUrl] when no [videoSource] is set.
  // ignore: deprecated_member_use_from_same_package
  String get effectiveVideoUrl => videoSource?.url ?? (videoUrl ?? '');

  /// Effective format derived from [videoSource], defaulting to MP4 for
  /// legacy [videoUrl]-only reels.
  VideoFormat get videoFormat => videoSource?.format ?? VideoFormat.mp4;

  /// Whether this reel can serve the given [format].
  bool hasStreamingFormat(VideoFormat format) =>
      videoSource?.hasFormat(format) ??
      // ignore: deprecated_member_use_from_same_package
      (format == VideoFormat.mp4 && videoUrl != null);

  /// Returns the URL for [format] when available, otherwise null.
  String? getUrlForFormat(VideoFormat format) {
    if (videoSource != null) return videoSource!.getUrlForFormat(format);
    // ignore: deprecated_member_use_from_same_package
    return format == VideoFormat.mp4 ? videoUrl : null;
  }
}

/// User information attached to a reel.
@freezed
abstract class ReelUser with _$ReelUser {
  const factory ReelUser({
    required String id,
    required String username,
    String? displayName,
    String? profilePictureUrl,
    @Default(false) bool isVerified,
    @Default(false) bool isFollowing,
    @Default(0) int followersCount,
    @Default(0) int followingCount,
  }) = _ReelUser;

  factory ReelUser.fromJson(Map<String, Object?> json) =>
      _$ReelUserFromJson(json);
}

/// Audio information attached to a reel.
@freezed
abstract class ReelAudio with _$ReelAudio {
  const factory ReelAudio({
    String? title,
    String? artist,
    String? coverUrl,
    String? audioUrl,
    int? duration,
  }) = _ReelAudio;

  factory ReelAudio.fromJson(Map<String, Object?> json) =>
      _$ReelAudioFromJson(json);
}

/// Width/height pair for a video frame.
@freezed
abstract class Size with _$Size {
  const factory Size(double width, double height) = _Size;

  factory Size.fromJson(Map<String, Object?> json) => _$SizeFromJson(json);
}
