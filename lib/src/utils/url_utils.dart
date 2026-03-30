import 'dart:convert';

import 'package:crypto/crypto.dart';

/// Параметры, которые являются CDN-токенами и не должны влиять на cache key.
const _tokenParams = {
  'token', 'sig', 'signature', 'expires', 'exp',
  'auth', 'key', 'st', 'e', 'Policy', 'Key-Pair-Id',
  'Signature', 'Expires',
};

/// Нормализует URL, убирая CDN-токены из query-параметров.
///
/// Одно и то же видео может запрашиваться с разными токенами —
/// нормализация гарантирует единый cache key.
String normalizeUrl(String url) {
  final uri = Uri.tryParse(url);
  if (uri == null || !uri.hasQuery) return url;

  final cleanParams = Map<String, String>.from(uri.queryParameters)
    ..removeWhere((key, _) => _tokenParams.contains(key));

  return uri
      .replace(queryParameters: cleanParams.isEmpty ? null : cleanParams)
      .toString();
}

/// Генерирует детерминированный cache key из URL через SHA-256.
///
/// В отличие от `String.hashCode`, SHA-256:
/// - детерминирован между запусками и платформами
/// - практически исключает коллизии
String generateCacheKey(String url) {
  final normalized = normalizeUrl(url);
  final bytes = utf8.encode(normalized);
  return sha256.convert(bytes).toString();
}
