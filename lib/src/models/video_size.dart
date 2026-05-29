import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_size.freezed.dart';
part 'video_size.g.dart';

/// Width/height pair for a video frame.
@freezed
abstract class Size with _$Size {
  /// Creates a [Size] from positional dimensions.
  const factory Size(double width, double height) = _Size;

  /// Deserializes a [Size] from JSON.
  factory Size.fromJson(Map<String, Object?> json) => _$SizeFromJson(json);
}
