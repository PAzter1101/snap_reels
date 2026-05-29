import 'package:freezed_annotation/freezed_annotation.dart';

part 'reel_audio.freezed.dart';
part 'reel_audio.g.dart';

/// Audio information attached to a reel.
@freezed
abstract class ReelAudio with _$ReelAudio {
  /// Creates a [ReelAudio].
  const factory ReelAudio({
    String? title,
    String? artist,
    String? coverUrl,
    String? audioUrl,
    int? duration,
  }) = _ReelAudio;

  /// Deserializes a [ReelAudio] from JSON.
  factory ReelAudio.fromJson(Map<String, Object?> json) =>
      _$ReelAudioFromJson(json);
}
