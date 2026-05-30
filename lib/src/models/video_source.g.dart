// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_source.dart';

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
      : VideoSize.fromJson(json['dimensions'] as Map<String, dynamic>),
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
