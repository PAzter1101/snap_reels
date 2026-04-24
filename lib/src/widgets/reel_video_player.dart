import 'dart:async';

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/reel_model.dart';
import '../models/reel_config.dart';
import '../controllers/reel_controller.dart';
import 'cached_thumbnail.dart';
import 'package:get/get.dart';

/// Video player widget for reels.
///
/// Creates its own [VideoController] for the [Player] from the pool.
/// Verifies on every build that the player still belongs to this reel.
class ReelVideoPlayer extends StatefulWidget {
  final ReelModel reel;
  final ReelController controller;
  final ReelConfig config;
  final Widget Function(BuildContext context, ReelModel reel, String error)?
      errorBuilder;
  final Widget Function(BuildContext context, ReelModel reel)? loadingBuilder;

  const ReelVideoPlayer({
    super.key,
    required this.reel,
    required this.controller,
    required this.config,
    this.errorBuilder,
    this.loadingBuilder,
  });

  @override
  State<ReelVideoPlayer> createState() => _ReelVideoPlayerState();
}

class _ReelVideoPlayerState extends State<ReelVideoPlayer> {
  final RxBool _isVisible = false.obs;
  final RxBool _hasFirstFrame = false.obs;
  bool _isInitialized = false;

  Player? _assignedPlayer;
  VideoController? _videoController;
  List<Worker> _workers = [];
  StreamSubscription<int?>? _widthSubscription;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
    _workers = [
      ever<int>(widget.controller.poolVersion, (_) {
        if (mounted) _syncPlayer();
      }),
      ever<int>(widget.controller.currentIndex, (_) {
        if (mounted) _syncPlayer();
      }),
    ];
  }

  @override
  void dispose() {
    for (final w in _workers) {
      w.dispose();
    }
    _workers.clear();
    _widthSubscription?.cancel();
    _widthSubscription = null;
    super.dispose();
  }

  /// Sync local VideoController with the pool's player assignment.
  void _syncPlayer() {
    final player = widget.controller.getPlayerForReel(widget.reel);
    if (player != _assignedPlayer) {
      _attachPlayer(player);
      if (mounted) setState(() {});
    }
  }

  /// Keep thumbnail visible until libmpv reports the first decoded frame
  /// (`player.stream.width` > 0). Without this guard media_kit's `Video`
  /// widget renders a solid black background during load/error, occluding
  /// the thumbnail the whole time.
  void _attachPlayer(Player? player) {
    _widthSubscription?.cancel();
    _widthSubscription = null;
    _hasFirstFrame.value = false;
    _assignedPlayer = player;
    _videoController = player != null ? VideoController(player) : null;
    if (player == null) return;
    final initialWidth = player.state.width ?? 0;
    if (initialWidth > 0) {
      _hasFirstFrame.value = true;
    }
    _widthSubscription = player.stream.width.listen((width) {
      if (!mounted) return;
      final hasFrame = (width ?? 0) > 0;
      if (hasFrame != _hasFirstFrame.value) {
        _hasFirstFrame.value = hasFrame;
      }
    });
  }

  Future<void> _initializeVideo() async {
    if (_isInitialized) return;

    try {
      if (widget.controller.isReelActive(widget.reel) ||
          widget.controller.currentReel.value == widget.reel) {
        await widget.controller.initializeVideoForReel(widget.reel);
        _isInitialized = true;
        _syncPlayer();
      }
    } catch (e) {
      debugPrint('Failed to initialize video for reel: $e');
      _isInitialized = true;
      if (mounted) setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // Synchronous check: verify the player still belongs to THIS reel.
    // If the slot was recycled, getPlayerForReel returns null or a
    // different Player, and we drop the VideoController immediately.
    final currentPlayer = widget.controller.getPlayerForReel(widget.reel);
    if (currentPlayer != _assignedPlayer) {
      _attachPlayer(currentPlayer);
    }

    return VisibilityDetector(
      key: Key('reel_${widget.reel.id}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildThumbnail(),
          Obx(() {
            if (_videoController == null || !_hasFirstFrame.value) {
              return const SizedBox.shrink();
            }
            return SizedBox.expand(
              child: Video(
                key: ValueKey(_assignedPlayer.hashCode),
                controller: _videoController!,
                fit: BoxFit.cover,
                fill: Colors.transparent,
                controls: NoVideoControls,
              ),
            );
          }),
          Obx(() => _buildLoadingOverlay()),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    final url = widget.reel.thumbnailUrl;
    if (url == null || url.isEmpty) {
      debugPrint(
        'ReelVideoPlayer: no thumbnailUrl for reel ${widget.reel.id}',
      );
      return _buildThumbnailFallback();
    }
    return CachedThumbnail(url: url, fallback: _buildThumbnailFallback());
  }

  Widget _buildThumbnailFallback() {
    final builder = widget.config.thumbnailFallbackBuilder;
    if (builder != null) {
      return builder(context, widget.reel);
    }
    return Container(color: Colors.black);
  }

  Widget _buildLoadingOverlay() {
    widget.controller.poolVersion.value;

    if (widget.controller.hasError) {
      return _buildErrorWidget(
          widget.controller.errorMessage ?? 'Unknown error');
    }

    if (widget.controller.isVideoInitializing && _videoController == null) {
      return _buildLoadingWidget();
    }

    return const SizedBox.shrink();
  }

  Widget _buildLoadingWidget() {
    if (widget.loadingBuilder != null) {
      return widget.loadingBuilder!(context, widget.reel);
    }
    return const Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }

  Widget _buildErrorWidget(String error) {
    if (widget.errorBuilder != null) {
      return widget.errorBuilder!(context, widget.reel, error);
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 8),
            const Text('Video Error',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(error,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
                textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isInitialized = false;
                  _videoController = null;
                  _assignedPlayer = null;
                });
                await widget.controller.retry();
                await _initializeVideo();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    final wasVisible = _isVisible.value;
    _isVisible.value = info.visibleFraction > 0.5;

    if (_isVisible.value && !wasVisible) {
      _initializeVideo();
      _syncPlayer();
      if (widget.controller.isReelActive(widget.reel)) {
        widget.controller.play();
      }
    } else if (!_isVisible.value && wasVisible) {
      if (widget.controller.isReelActive(widget.reel)) {
        widget.controller.pause();
      }
    }
  }
}
