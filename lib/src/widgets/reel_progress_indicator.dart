import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:snap_reels/src/controllers/reel_controller.dart';
import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';
import 'package:snap_reels/src/widgets/progress_track_bar.dart';
import 'package:snap_reels/src/widgets/reel_progress_time_labels.dart';
import 'package:snap_reels/src/widgets/scrub_thumbnail_preview.dart';

/// Video progress indicator with seeking, thumbnails, and animations.
class ReelProgressIndicator extends StatefulWidget {
  /// Creates the progress indicator for [reel].
  const ReelProgressIndicator({
    required this.reel,
    required this.config,
    super.key,
    this.showThumb = true,
    this.showTime = false,
    this.height = 4.0,
    this.onSeek,
    this.showThumbnail = true,
  });

  /// Reel whose playback position is rendered.
  final ReelModel reel;

  /// Styling and behavior configuration.
  final ReelConfig config;

  /// Whether to render the draggable thumb.
  final bool showThumb;

  /// Whether to render elapsed/total time labels next to the bar.
  final bool showTime;

  /// Thickness of the bar in logical pixels.
  final double height;

  /// Invoked when the user finishes a seek. Receives the new position.
  final void Function(Duration)? onSeek;

  /// Whether the preview thumbnail floats above the thumb during a drag.
  final bool showThumbnail;

  @override
  State<ReelProgressIndicator> createState() => _ReelProgressIndicatorState();
}

class _ReelProgressIndicatorState extends State<ReelProgressIndicator>
    with TickerProviderStateMixin {
  final RxBool _isDragging = false.obs;
  final RxnDouble _dragValue = RxnDouble();
  final RxBool _showThumbnail = false.obs;
  final RxnDouble _thumbnailPosition = RxnDouble();
  final Rx<Duration> _thumbnailTime = Rx<Duration>(Duration.zero);

  late AnimationController _scaleAnimationController;
  late AnimationController _thumbAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _thumbSizeAnimation;
  late Animation<double> _trackHeightAnimation;

  bool _wasPlayingBeforeDrag = false;

  @override
  void initState() {
    super.initState();
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(
      CurvedAnimation(parent: _scaleAnimationController, curve: Curves.easeOut),
    );

    _thumbAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _thumbSizeAnimation = Tween<double>(begin: 12, end: 20).animate(
      CurvedAnimation(
        parent: _thumbAnimationController,
        curve: Curves.elasticOut,
      ),
    );
    _trackHeightAnimation =
        Tween<double>(begin: widget.height, end: widget.height * 1.5).animate(
          CurvedAnimation(
            parent: _thumbAnimationController,
            curve: Curves.easeOut,
          ),
        );
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    _thumbAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReelController>();
    return Obx(() {
      final position = controller.currentPosition.value;
      final duration = controller.totalDuration.value;

      if (duration.inMilliseconds <= 0) return const SizedBox.shrink();

      final actualProgress = position.inMilliseconds / duration.inMilliseconds;
      final displayProgress = _isDragging.value
          ? (_dragValue.value ?? actualProgress)
          : actualProgress;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          if (widget.showThumbnail && _showThumbnail.value)
            _buildThumbnailPreview(),
          _buildProgressTrack(controller, displayProgress, duration, position),
          if (widget.showTime) ...[
            const SizedBox(height: 8),
            ReelProgressTimeLabels(
              position: position,
              duration: duration,
              textColor: widget.config.styling.textColor,
            ),
          ],
        ],
      );
    });
  }

  Widget _buildThumbnailPreview() {
    return Obx(() {
      final anchor = _thumbnailPosition.value;
      if (!_showThumbnail.value || anchor == null) {
        return const SizedBox.shrink();
      }
      return ScrubThumbnailPreview(
        anchorLeft: anchor,
        time: _thumbnailTime.value,
      );
    });
  }

  Widget _buildProgressTrack(
    ReelController controller,
    double progress,
    Duration duration,
    Duration position,
  ) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _scaleAnimation,
        _trackHeightAnimation,
        _thumbSizeAnimation,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: _handleTapDown,
              onPanStart: _handlePanStart,
              onPanUpdate: _handlePanUpdate,
              onPanEnd: _handlePanEnd,
              child: SizedBox(
                height: 20,
                child: ProgressTrackBar(
                  progress: progress,
                  trackHeight: _trackHeightAnimation.value,
                  progressColor: widget.config.styling.progressColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleTapDown(TapDownDetails details) {
    final controller = Get.find<ReelController>();
    final duration = controller.totalDuration.value;
    if (duration.inMilliseconds <= 0) return;

    final box = context.findRenderObject()! as RenderBox;
    final width = box.size.width;
    final tapPosition = (details.localPosition.dx / width).clamp(0.0, 1.0);

    final newPosition = Duration(
      milliseconds: (tapPosition * duration.inMilliseconds).round(),
    );
    unawaited(controller.seekTo(newPosition));
    widget.onSeek?.call(newPosition);

    unawaited(
      _scaleAnimationController.forward().then((_) {
        unawaited(_scaleAnimationController.reverse());
      }),
    );
  }

  void _handlePanStart(DragStartDetails details) {
    final controller = Get.find<ReelController>();
    final duration = controller.totalDuration.value;
    if (duration.inMilliseconds <= 0) return;

    _wasPlayingBeforeDrag = controller.isPlaying.value;
    if (_wasPlayingBeforeDrag) unawaited(controller.pause());

    _isDragging.value = true;
    unawaited(_thumbAnimationController.forward());
    unawaited(_scaleAnimationController.forward());

    final box = context.findRenderObject()! as RenderBox;
    final width = box.size.width;
    final dragPosition = (details.localPosition.dx / width).clamp(0.0, 1.0);
    _dragValue.value = dragPosition;

    if (widget.showThumbnail) {
      _showThumbnail.value = true;
      _thumbnailPosition.value = details.localPosition.dx;
      _thumbnailTime.value = Duration(
        milliseconds: (dragPosition * duration.inMilliseconds).round(),
      );
    }
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    final controller = Get.find<ReelController>();
    final duration = controller.totalDuration.value;
    if (duration.inMilliseconds <= 0) return;

    final box = context.findRenderObject()! as RenderBox;
    final width = box.size.width;
    final dragPosition = (details.localPosition.dx / width).clamp(0.0, 1.0);
    _dragValue.value = dragPosition;

    if (widget.showThumbnail && _showThumbnail.value) {
      _thumbnailPosition.value = details.localPosition.dx;
      _thumbnailTime.value = Duration(
        milliseconds: (dragPosition * duration.inMilliseconds).round(),
      );
    }
  }

  void _handlePanEnd(DragEndDetails details) {
    final controller = Get.find<ReelController>();
    final duration = controller.totalDuration.value;

    if (duration.inMilliseconds > 0 && _dragValue.value != null) {
      final newPosition = Duration(
        milliseconds: (_dragValue.value! * duration.inMilliseconds).round(),
      );
      unawaited(controller.seekTo(newPosition));
      widget.onSeek?.call(newPosition);

      if (_wasPlayingBeforeDrag) {
        Future.delayed(const Duration(milliseconds: 150), controller.play);
      }
    }

    _isDragging.value = false;
    _dragValue.value = null;
    _showThumbnail.value = false;
    _thumbnailPosition.value = null;
    unawaited(_thumbAnimationController.reverse());
    unawaited(_scaleAnimationController.reverse());
  }
}
