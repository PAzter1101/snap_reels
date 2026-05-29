import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:snap_reels/src/models/converters.dart';
import 'package:snap_reels/src/models/video_format.dart';
import 'package:snap_reels/src/models/video_size.dart';

part 'video_source.freezed.dart';
part 'video_source.g.dart';

/// Video source configuration for different streaming formats.
@freezed
abstract class VideoSource with _$VideoSource {
  /// Creates a video source. [url] is the primary one;
  /// [alternativeSources] holds optional fallbacks per [VideoFormat].
  const factory VideoSource({
    required String url,
    @Default(VideoFormat.hls) VideoFormat format,
    @VideoFormatMapConverter() Map<VideoFormat, String>? alternativeSources,
    String? quality,
    int? bitrate,
    Size? dimensions,
  }) = _VideoSource;

  const VideoSource._();

  /// Deserializes a [VideoSource] from JSON.
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
