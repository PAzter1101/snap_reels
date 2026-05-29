import 'package:json_annotation/json_annotation.dart';

import 'package:snap_reels/src/models/reel_model.dart' show VideoFormat;

/// Serializes [Duration] as integer milliseconds in JSON.
class DurationMillisConverter implements JsonConverter<Duration, int> {
  /// Creates the converter.
  const DurationMillisConverter();

  @override
  Duration fromJson(int json) => Duration(milliseconds: json);

  @override
  int toJson(Duration object) => object.inMilliseconds;
}

/// Nullable variant of [DurationMillisConverter].
class NullableDurationMillisConverter
    implements JsonConverter<Duration?, int?> {
  /// Creates the converter.
  const NullableDurationMillisConverter();

  @override
  Duration? fromJson(int? json) =>
      json == null ? null : Duration(milliseconds: json);

  @override
  int? toJson(Duration? object) => object?.inMilliseconds;
}

/// JSON keys can only be strings, so [VideoFormat]-keyed maps are stored as
/// `Map<String, String>` and converted in/out via this converter.
class VideoFormatMapConverter
    implements JsonConverter<Map<VideoFormat, String>?, Map<String, dynamic>?> {
  /// Creates the converter.
  const VideoFormatMapConverter();

  @override
  Map<VideoFormat, String>? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return json.map(
      (key, value) => MapEntry(VideoFormat.fromString(key), value as String),
    );
  }

  @override
  Map<String, dynamic>? toJson(Map<VideoFormat, String>? object) =>
      object?.map((key, value) => MapEntry(key.name, value));
}
