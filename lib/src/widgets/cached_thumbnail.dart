import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/reel_model.dart';
import '../services/cache_manager.dart';

/// Thumbnail image that goes through [CacheManager] instead of
/// [Image.network]. Reuses the host app's [Dio] (typically backed by
/// `NativeAdapter` + `CronetEngine`/`URLSession` with shared connection
/// pool and TLS session cache), persists bytes on disk under the LRU
/// policy, and reports errors uniformly via `debugPrint`.
///
/// When [proxyUrlBuilder] is provided, the widget switches to the
/// alternative URL it returns if either:
/// 1. the primary URL hasn't produced a frame within [loadTimeout], or
/// 2. the primary URL fails on download or decode.
///
/// Falls back to [fallback] until the first frame is decoded and on
/// terminal failure of both URLs.
class CachedThumbnail extends StatefulWidget {
  const CachedThumbnail({
    required this.reel,
    required this.fallback,
    super.key,
    this.fit = BoxFit.cover,
    this.proxyUrlBuilder,
    this.loadTimeout = const Duration(seconds: 3),
  });

  final ReelModel reel;
  final Widget fallback;
  final BoxFit fit;
  final String? Function(ReelModel reel)? proxyUrlBuilder;
  final Duration loadTimeout;

  @override
  State<CachedThumbnail> createState() => _CachedThumbnailState();
}

class _CachedThumbnailState extends State<CachedThumbnail> {
  late Future<String?> _pathFuture;
  Timer? _timeoutTimer;
  bool _useProxy = false;
  bool _firstFrameReceived = false;

  String get _primaryUrl => widget.reel.thumbnailUrl ?? '';

  @override
  void initState() {
    super.initState();
    _pathFuture = _resolvePath(_primaryUrl);
    _scheduleProxyTimeout();
  }

  @override
  void didUpdateWidget(covariant CachedThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.reel.thumbnailUrl != widget.reel.thumbnailUrl) {
      _timeoutTimer?.cancel();
      _useProxy = false;
      _firstFrameReceived = false;
      _pathFuture = _resolvePath(_primaryUrl);
      _scheduleProxyTimeout();
    }
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  void _scheduleProxyTimeout() {
    if (widget.proxyUrlBuilder == null) return;
    _timeoutTimer = Timer(widget.loadTimeout, () {
      if (!mounted || _firstFrameReceived || _useProxy) return;
      _switchToProxy();
    });
  }

  void _switchToProxy() {
    if (widget.proxyUrlBuilder == null || _useProxy) return;
    final proxyUrl = widget.proxyUrlBuilder!(widget.reel);
    if (proxyUrl == null || proxyUrl == _primaryUrl) return;
    _timeoutTimer?.cancel();
    setState(() {
      _useProxy = true;
      _pathFuture = _resolveProxy(proxyUrl);
    });
  }

  Future<String?> _resolvePath(String url) async {
    if (url.isEmpty) return null;
    final cached = CacheManager.instance.getCachedFilePath(url);
    if (cached != null) return cached;
    final downloaded = await CacheManager.instance.downloadAndCache(url);
    if (downloaded == null) {
      debugPrint('CachedThumbnail: download failed for $url');
    }
    return downloaded;
  }

  /// Like [_resolvePath] but, on success, also links the cache entry under
  /// the primary URL — so the next mount of this widget hits cache via
  /// [_primaryUrl] and skips the loadTimeout wait entirely.
  Future<String?> _resolveProxy(String proxyUrl) async {
    final path = await _resolvePath(proxyUrl);
    if (path != null && _primaryUrl.isNotEmpty) {
      await CacheManager.instance.linkCachedUrl(_primaryUrl, proxyUrl);
    }
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _pathFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final path = snapshot.data;
          if (path == null) {
            if (!_useProxy && widget.proxyUrlBuilder != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _switchToProxy();
              });
            }
            return widget.fallback;
          }
          return Image.file(
            File(path),
            fit: widget.fit,
            width: double.infinity,
            height: double.infinity,
            frameBuilder: (_, child, frame, _) {
              if (frame != null && !_firstFrameReceived) {
                _firstFrameReceived = true;
                _timeoutTimer?.cancel();
              }
              return child;
            },
            errorBuilder: (_, error, _) {
              debugPrint(
                'CachedThumbnail: decode failed for $_primaryUrl: $error',
              );
              if (!_useProxy && widget.proxyUrlBuilder != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) _switchToProxy();
                });
              }
              return widget.fallback;
            },
          );
        }
        return widget.fallback;
      },
    );
  }
}
