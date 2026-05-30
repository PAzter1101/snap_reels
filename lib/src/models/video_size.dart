import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_size.freezed.dart';
part 'video_size.g.dart';

/// Width/height pair for a video frame.
@freezed
abstract class VideoSize with _$VideoSize {
  /// Creates a [VideoSize] from positional dimensions.
  const factory VideoSize(double width, double height) = _VideoSize;

  /// Deserializes a [VideoSize] from JSON.
  factory VideoSize.fromJson(Map<String, Object?> json) =>
      _$VideoSizeFromJson(json);
}
