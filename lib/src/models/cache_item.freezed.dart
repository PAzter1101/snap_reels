// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cache_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CacheItem {

 String get cacheKey; String get filePath; String get url; DateTime get createdAt; int get fileSize; DateTime get lastAccessTime; DateTime get expiryTime;
/// Create a copy of CacheItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacheItemCopyWith<CacheItem> get copyWith => _$CacheItemCopyWithImpl<CacheItem>(this as CacheItem, _$identity);

  /// Serializes this CacheItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheItem&&(identical(other.cacheKey, cacheKey) || other.cacheKey == cacheKey)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.url, url) || other.url == url)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.lastAccessTime, lastAccessTime) || other.lastAccessTime == lastAccessTime)&&(identical(other.expiryTime, expiryTime) || other.expiryTime == expiryTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cacheKey,filePath,url,createdAt,fileSize,lastAccessTime,expiryTime);

@override
String toString() {
  return 'CacheItem(cacheKey: $cacheKey, filePath: $filePath, url: $url, createdAt: $createdAt, fileSize: $fileSize, lastAccessTime: $lastAccessTime, expiryTime: $expiryTime)';
}


}

/// @nodoc
abstract mixin class $CacheItemCopyWith<$Res>  {
  factory $CacheItemCopyWith(CacheItem value, $Res Function(CacheItem) _then) = _$CacheItemCopyWithImpl;
@useResult
$Res call({
 String cacheKey, String filePath, String url, DateTime createdAt, int fileSize, DateTime lastAccessTime, DateTime expiryTime
});




}
/// @nodoc
class _$CacheItemCopyWithImpl<$Res>
    implements $CacheItemCopyWith<$Res> {
  _$CacheItemCopyWithImpl(this._self, this._then);

  final CacheItem _self;
  final $Res Function(CacheItem) _then;

/// Create a copy of CacheItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cacheKey = null,Object? filePath = null,Object? url = null,Object? createdAt = null,Object? fileSize = null,Object? lastAccessTime = null,Object? expiryTime = null,}) {
  return _then(_self.copyWith(
cacheKey: null == cacheKey ? _self.cacheKey : cacheKey // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,lastAccessTime: null == lastAccessTime ? _self.lastAccessTime : lastAccessTime // ignore: cast_nullable_to_non_nullable
as DateTime,expiryTime: null == expiryTime ? _self.expiryTime : expiryTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [CacheItem].
extension CacheItemPatterns on CacheItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CacheItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CacheItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CacheItem value)  $default,){
final _that = this;
switch (_that) {
case _CacheItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CacheItem value)?  $default,){
final _that = this;
switch (_that) {
case _CacheItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cacheKey,  String filePath,  String url,  DateTime createdAt,  int fileSize,  DateTime lastAccessTime,  DateTime expiryTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CacheItem() when $default != null:
return $default(_that.cacheKey,_that.filePath,_that.url,_that.createdAt,_that.fileSize,_that.lastAccessTime,_that.expiryTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cacheKey,  String filePath,  String url,  DateTime createdAt,  int fileSize,  DateTime lastAccessTime,  DateTime expiryTime)  $default,) {final _that = this;
switch (_that) {
case _CacheItem():
return $default(_that.cacheKey,_that.filePath,_that.url,_that.createdAt,_that.fileSize,_that.lastAccessTime,_that.expiryTime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cacheKey,  String filePath,  String url,  DateTime createdAt,  int fileSize,  DateTime lastAccessTime,  DateTime expiryTime)?  $default,) {final _that = this;
switch (_that) {
case _CacheItem() when $default != null:
return $default(_that.cacheKey,_that.filePath,_that.url,_that.createdAt,_that.fileSize,_that.lastAccessTime,_that.expiryTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CacheItem extends CacheItem {
  const _CacheItem({required this.cacheKey, required this.filePath, required this.url, required this.createdAt, required this.fileSize, required this.lastAccessTime, required this.expiryTime}): super._();
  factory _CacheItem.fromJson(Map<String, dynamic> json) => _$CacheItemFromJson(json);

@override final  String cacheKey;
@override final  String filePath;
@override final  String url;
@override final  DateTime createdAt;
@override final  int fileSize;
@override final  DateTime lastAccessTime;
@override final  DateTime expiryTime;

/// Create a copy of CacheItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CacheItemCopyWith<_CacheItem> get copyWith => __$CacheItemCopyWithImpl<_CacheItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CacheItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CacheItem&&(identical(other.cacheKey, cacheKey) || other.cacheKey == cacheKey)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.url, url) || other.url == url)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.lastAccessTime, lastAccessTime) || other.lastAccessTime == lastAccessTime)&&(identical(other.expiryTime, expiryTime) || other.expiryTime == expiryTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cacheKey,filePath,url,createdAt,fileSize,lastAccessTime,expiryTime);

@override
String toString() {
  return 'CacheItem(cacheKey: $cacheKey, filePath: $filePath, url: $url, createdAt: $createdAt, fileSize: $fileSize, lastAccessTime: $lastAccessTime, expiryTime: $expiryTime)';
}


}

/// @nodoc
abstract mixin class _$CacheItemCopyWith<$Res> implements $CacheItemCopyWith<$Res> {
  factory _$CacheItemCopyWith(_CacheItem value, $Res Function(_CacheItem) _then) = __$CacheItemCopyWithImpl;
@override @useResult
$Res call({
 String cacheKey, String filePath, String url, DateTime createdAt, int fileSize, DateTime lastAccessTime, DateTime expiryTime
});




}
/// @nodoc
class __$CacheItemCopyWithImpl<$Res>
    implements _$CacheItemCopyWith<$Res> {
  __$CacheItemCopyWithImpl(this._self, this._then);

  final _CacheItem _self;
  final $Res Function(_CacheItem) _then;

/// Create a copy of CacheItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cacheKey = null,Object? filePath = null,Object? url = null,Object? createdAt = null,Object? fileSize = null,Object? lastAccessTime = null,Object? expiryTime = null,}) {
  return _then(_CacheItem(
cacheKey: null == cacheKey ? _self.cacheKey : cacheKey // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,lastAccessTime: null == lastAccessTime ? _self.lastAccessTime : lastAccessTime // ignore: cast_nullable_to_non_nullable
as DateTime,expiryTime: null == expiryTime ? _self.expiryTime : expiryTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$CacheStats {

 int get totalFiles; int get totalSize; int get expiredFiles; String get cacheDirectory;
/// Create a copy of CacheStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CacheStatsCopyWith<CacheStats> get copyWith => _$CacheStatsCopyWithImpl<CacheStats>(this as CacheStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheStats&&(identical(other.totalFiles, totalFiles) || other.totalFiles == totalFiles)&&(identical(other.totalSize, totalSize) || other.totalSize == totalSize)&&(identical(other.expiredFiles, expiredFiles) || other.expiredFiles == expiredFiles)&&(identical(other.cacheDirectory, cacheDirectory) || other.cacheDirectory == cacheDirectory));
}


@override
int get hashCode => Object.hash(runtimeType,totalFiles,totalSize,expiredFiles,cacheDirectory);

@override
String toString() {
  return 'CacheStats(totalFiles: $totalFiles, totalSize: $totalSize, expiredFiles: $expiredFiles, cacheDirectory: $cacheDirectory)';
}


}

/// @nodoc
abstract mixin class $CacheStatsCopyWith<$Res>  {
  factory $CacheStatsCopyWith(CacheStats value, $Res Function(CacheStats) _then) = _$CacheStatsCopyWithImpl;
@useResult
$Res call({
 int totalFiles, int totalSize, int expiredFiles, String cacheDirectory
});




}
/// @nodoc
class _$CacheStatsCopyWithImpl<$Res>
    implements $CacheStatsCopyWith<$Res> {
  _$CacheStatsCopyWithImpl(this._self, this._then);

  final CacheStats _self;
  final $Res Function(CacheStats) _then;

/// Create a copy of CacheStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalFiles = null,Object? totalSize = null,Object? expiredFiles = null,Object? cacheDirectory = null,}) {
  return _then(_self.copyWith(
totalFiles: null == totalFiles ? _self.totalFiles : totalFiles // ignore: cast_nullable_to_non_nullable
as int,totalSize: null == totalSize ? _self.totalSize : totalSize // ignore: cast_nullable_to_non_nullable
as int,expiredFiles: null == expiredFiles ? _self.expiredFiles : expiredFiles // ignore: cast_nullable_to_non_nullable
as int,cacheDirectory: null == cacheDirectory ? _self.cacheDirectory : cacheDirectory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CacheStats].
extension CacheStatsPatterns on CacheStats {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CacheStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CacheStats() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CacheStats value)  $default,){
final _that = this;
switch (_that) {
case _CacheStats():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CacheStats value)?  $default,){
final _that = this;
switch (_that) {
case _CacheStats() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalFiles,  int totalSize,  int expiredFiles,  String cacheDirectory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CacheStats() when $default != null:
return $default(_that.totalFiles,_that.totalSize,_that.expiredFiles,_that.cacheDirectory);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalFiles,  int totalSize,  int expiredFiles,  String cacheDirectory)  $default,) {final _that = this;
switch (_that) {
case _CacheStats():
return $default(_that.totalFiles,_that.totalSize,_that.expiredFiles,_that.cacheDirectory);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalFiles,  int totalSize,  int expiredFiles,  String cacheDirectory)?  $default,) {final _that = this;
switch (_that) {
case _CacheStats() when $default != null:
return $default(_that.totalFiles,_that.totalSize,_that.expiredFiles,_that.cacheDirectory);case _:
  return null;

}
}

}

/// @nodoc


class _CacheStats extends CacheStats {
  const _CacheStats({required this.totalFiles, required this.totalSize, required this.expiredFiles, required this.cacheDirectory}): super._();
  

@override final  int totalFiles;
@override final  int totalSize;
@override final  int expiredFiles;
@override final  String cacheDirectory;

/// Create a copy of CacheStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CacheStatsCopyWith<_CacheStats> get copyWith => __$CacheStatsCopyWithImpl<_CacheStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CacheStats&&(identical(other.totalFiles, totalFiles) || other.totalFiles == totalFiles)&&(identical(other.totalSize, totalSize) || other.totalSize == totalSize)&&(identical(other.expiredFiles, expiredFiles) || other.expiredFiles == expiredFiles)&&(identical(other.cacheDirectory, cacheDirectory) || other.cacheDirectory == cacheDirectory));
}


@override
int get hashCode => Object.hash(runtimeType,totalFiles,totalSize,expiredFiles,cacheDirectory);

@override
String toString() {
  return 'CacheStats(totalFiles: $totalFiles, totalSize: $totalSize, expiredFiles: $expiredFiles, cacheDirectory: $cacheDirectory)';
}


}

/// @nodoc
abstract mixin class _$CacheStatsCopyWith<$Res> implements $CacheStatsCopyWith<$Res> {
  factory _$CacheStatsCopyWith(_CacheStats value, $Res Function(_CacheStats) _then) = __$CacheStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalFiles, int totalSize, int expiredFiles, String cacheDirectory
});




}
/// @nodoc
class __$CacheStatsCopyWithImpl<$Res>
    implements _$CacheStatsCopyWith<$Res> {
  __$CacheStatsCopyWithImpl(this._self, this._then);

  final _CacheStats _self;
  final $Res Function(_CacheStats) _then;

/// Create a copy of CacheStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalFiles = null,Object? totalSize = null,Object? expiredFiles = null,Object? cacheDirectory = null,}) {
  return _then(_CacheStats(
totalFiles: null == totalFiles ? _self.totalFiles : totalFiles // ignore: cast_nullable_to_non_nullable
as int,totalSize: null == totalSize ? _self.totalSize : totalSize // ignore: cast_nullable_to_non_nullable
as int,expiredFiles: null == expiredFiles ? _self.expiredFiles : expiredFiles // ignore: cast_nullable_to_non_nullable
as int,cacheDirectory: null == cacheDirectory ? _self.cacheDirectory : cacheDirectory // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
