import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../models/reel_model.dart';
import '../models/reel_config.dart';
import '../controllers/reel_controller.dart';
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
  bool _isInitialized = false;

  Player? _assignedPlayer;
  VideoController? _videoController;
  List<Worker> _workers = [];

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
    super.dispose();
  }

  /// Sync local VideoController with the pool's player assignment.
  void _syncPlayer() {
    final player = widget.controller.getPlayerForReel(widget.reel);
    if (player != _assignedPlayer) {
      _assignedPlayer = player;
      _videoController = player != null ? VideoController(player) : null;
      if (mounted) setState(() {});
    }
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
      _assignedPlayer = currentPlayer;
      _videoController = currentPlayer != null
          ? VideoController(currentPlayer)
          : null;
    }

    return VisibilityDetector(
      key: Key('reel_${widget.reel.id}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildThumbnail(),
          if (_videoController != null)
            SizedBox.expand(
              child: Video(
                key: ValueKey(_assignedPlayer.hashCode),
                controller: _videoController!,
                fit: BoxFit.cover,
                fill: Colors.transparent,
                controls: NoVideoControls,
              ),
            ),
          Obx(() => _buildLoadingOverlay()),
        ],
      ),
    );
  }

  Widget _buildThumbnail() {
    final url = widget.reel.thumbnailUrl;
    if (url == null || url.isEmpty) {
      return Container(color: Colors.black);
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => Container(color: Colors.black),
    );
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
