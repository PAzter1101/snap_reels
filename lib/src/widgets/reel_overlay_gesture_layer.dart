import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:snap_reels/src/controllers/reel_controller.dart';
import 'package:snap_reels/src/models/reel_config.dart';

/// Wraps [child] with tap / long-press handling and a centered flash
/// of the play/pause icon when the user taps the surface.
///
/// Tap behavior: invokes [onTap] when provided, otherwise toggles
/// playback on [controller] and briefly shows the icon overlay.
///
/// Long-press behavior: invokes [onLongPress] when provided, otherwise
/// pauses on press-down and resumes on release if the video was playing.
class ReelOverlayGestureLayer extends StatefulWidget {
  /// Creates the gesture layer.
  const ReelOverlayGestureLayer({
    required this.controller,
    required this.config,
    required this.child,
    this.onTap,
    this.onLongPress,
    super.key,
  });

  /// Controller used to toggle playback / read the current state.
  final ReelController controller;

  /// Styling configuration (icon color).
  final ReelConfig config;

  /// Overlay content rendered under the gesture detector.
  final Widget child;

  /// Replaces the default tap behavior.
  final VoidCallback? onTap;

  /// Replaces the default long-press behavior.
  final VoidCallback? onLongPress;

  @override
  State<ReelOverlayGestureLayer> createState() =>
      _ReelOverlayGestureLayerState();
}

class _ReelOverlayGestureLayerState extends State<ReelOverlayGestureLayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _flashController;
  late Animation<double> _flashAnimation;
  final RxBool _showFlash = false.obs;
  bool _wasPlayingBeforeLongPress = false;

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _flashAnimation = CurvedAnimation(
      parent: _flashController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _flashController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap!();
      return;
    }
    _togglePlayPause();
  }

  void _handleLongPressStart() {
    _wasPlayingBeforeLongPress = widget.controller.isPlaying.value;
    unawaited(widget.controller.pause());
  }

  void _handleLongPressEnd() {
    if (_wasPlayingBeforeLongPress) {
      unawaited(widget.controller.play());
    }
  }

  void _togglePlayPause() {
    if (widget.controller.isPlaying.value) {
      unawaited(widget.controller.pause());
    } else {
      unawaited(widget.controller.play());
    }
    _showFlash.value = true;
    unawaited(
      _flashController.forward().then((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _showFlash.value = false;
          unawaited(_flashController.reverse());
        });
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onLongPress: widget.onLongPress,
      onLongPressStart: (_) {
        if (widget.onLongPress != null) {
          widget.onLongPress!();
        } else {
          _handleLongPressStart();
        }
      },
      onLongPressEnd: (_) {
        if (widget.onLongPress != null) {
          widget.onLongPress!();
        } else {
          _handleLongPressEnd();
        }
      },
      child: Stack(
        children: [
          widget.child,
          Obx(
            () => _showFlash.value
                ? Center(
                    child: ScaleTransition(
                      scale: _flashAnimation,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Obx(
                          () => Icon(
                            widget.controller.isPlaying.value
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: widget.config.styling.textColor,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
