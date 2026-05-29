// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CacheItem _$CacheItemFromJson(Map<String, dynamic> json) => _CacheItem(
  cacheKey: json['cacheKey'] as String,
  filePath: json['filePath'] as String,
  url: json['url'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  fileSize: (json['fileSize'] as num).toInt(),
  lastAccessTime: DateTime.parse(json['lastAccessTime'] as String),
  expiryTime: DateTime.parse(json['expiryTime'] as String),
);

Map<String, dynamic> _$CacheItemToJson(_CacheItem instance) =>
    <String, dynamic>{
      'cacheKey': instance.cacheKey,
      'filePath': instance.filePath,
      'url': instance.url,
      'createdAt': instance.createdAt.toIso8601String(),
      'fileSize': instance.fileSize,
      'lastAccessTime': instance.lastAccessTime.toIso8601String(),
      'expiryTime': instance.expiryTime.toIso8601String(),
    };
