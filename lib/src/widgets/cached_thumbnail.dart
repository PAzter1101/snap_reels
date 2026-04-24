import 'dart:io';

import 'package:flutter/material.dart';

import '../services/cache_manager.dart';

/// Thumbnail image that goes through [CacheManager] instead of
/// [Image.network]. This reuses the host app's [Dio] (typically backed by
/// Cronet/URLSession with QUIC + shared TLS session cache), stores bytes on
/// disk under the LRU policy, and produces uniform error reporting.
///
/// Falls back to [fallback] during load, on network failure and on decode
/// failure. Errors are surfaced via `debugPrint` for diagnostics.
class CachedThumbnail extends StatefulWidget {
  const CachedThumbnail({
    super.key,
    required this.url,
    required this.fallback,
    this.fit = BoxFit.cover,
  });

  final String url;
  final Widget fallback;
  final BoxFit fit;

  @override
  State<CachedThumbnail> createState() => _CachedThumbnailState();
}

class _CachedThumbnailState extends State<CachedThumbnail> {
  late Future<String?> _pathFuture;

  @override
  void initState() {
    super.initState();
    _pathFuture = _resolvePath(widget.url);
  }

  @override
  void didUpdateWidget(covariant CachedThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _pathFuture = _resolvePath(widget.url);
    }
  }

  Future<String?> _resolvePath(String url) async {
    final cached = CacheManager.instance.getCachedFilePath(url);
    if (cached != null) return cached;
    final downloaded = await CacheManager.instance.downloadAndCache(url);
    if (downloaded == null) {
      debugPrint('CachedThumbnail: download failed for $url');
    }
    return downloaded;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _pathFuture,
      builder: (context, snapshot) {
        final path = snapshot.data;
        if (path == null) return widget.fallback;
        return Image.file(
          File(path),
          fit: widget.fit,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (_, error, _) {
            debugPrint(
              'CachedThumbnail: decode failed for ${widget.url}: $error',
            );
            return widget.fallback;
          },
        );
      },
    );
  }
}
