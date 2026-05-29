// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reel_audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
