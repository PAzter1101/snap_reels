import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:snap_reels/src/controllers/reel_controller.dart';
import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';
import 'package:snap_reels/src/widgets/reel_actions.dart';
import 'package:snap_reels/src/widgets/reel_bottom_controls.dart';
import 'package:snap_reels/src/widgets/reel_buffering_indicator.dart';
import 'package:snap_reels/src/widgets/reel_error_overlay.dart';
import 'package:snap_reels/src/widgets/reel_overlay_gesture_layer.dart';
import 'package:snap_reels/src/widgets/reel_progress_indicator.dart';
import 'package:snap_reels/src/widgets/reel_user_info_overlay.dart';

const _kDarkGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.transparent,
    Colors.transparent,
    Color(0x64000000),
    Color(0x96000000),
  ],
  stops: [0.0, 0.4, 0.7, 1.0],
);

/// Overlay shown over the video with user info, actions, and controls.
class ReelOverlay extends StatelessWidget {
  /// Creates a [ReelOverlay] bound to [reel] and [controller].
  const ReelOverlay({
    required this.reel,
    required this.config,
    required this.controller,
    super.key,
    this.onTap,
    this.onLongPress,
    this.onLike,
    this.onShare,
    this.onComment,
    this.onFollow,
    this.onBlock,
    this.onCompleted,
  });

  /// Reel that this overlay decorates.
  final ReelModel reel;

  /// Styling and behavior configuration.
  final ReelConfig config;

  /// Controller driving the player behind this overlay.
  final ReelController controller;

  /// Invoked when the user taps anywhere on the overlay surface.
  final VoidCallback? onTap;

  /// Invoked when the user long-presses the overlay surface.
  final VoidCallback? onLongPress;

  /// Invoked when the user taps the like button.
  final VoidCallback? onLike;

  /// Invoked when the user taps the share button.
  final VoidCallback? onShare;

  /// Invoked when the user taps the comment button.
  final VoidCallback? onComment;

  /// Invoked when the user taps the follow button.
  final VoidCallback? onFollow;

  /// Invoked when the user blocks the reel's author via the more menu.
  final VoidCallback? onBlock;

  /// Invoked once when the video finishes playing.
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        (config.showProgressIndicator ? 80 : 16) +
        config.styling.contentBottomPadding;

    return ReelOverlayGestureLayer(
      controller: controller,
      config: config,
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: const BoxDecoration(gradient: _kDarkGradient),
        child: Stack(
          children: [
            Positioned(
              bottom: bottomInset,
              left: 16,
              right: 80,
              child: ReelUserInfoOverlay(
                reel: reel,
                config: config,
                onFollowTap: () => _handleFollow(context),
                onHashtagTap: (tag) => config.callbacks.onHashtagTap?.call(tag),
              ),
            ),
            Positioned(
              bottom: bottomInset,
              right: 12,
              child: ReelActions(
                reel: reel,
                config: config,
                onLike: onLike,
                onShare: onShare,
                onComment: onComment,
                onFollow: onFollow,
                onBlock: onBlock,
              ),
            ),
            if (config.actions.showBottomControls)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ReelBottomControls(
                  reel: reel,
                  config: config,
                  controller: controller,
                ),
              ),
            Obx(
              () => controller.hasError
                  ? ReelErrorOverlay(
                      reel: reel,
                      config: config,
                      errorMessage:
                          controller.errorMessage ?? 'Unknown error occurred',
                      onRetry: controller.retry,
                      onCancel: controller.clearError,
                    )
                  : controller.isBuffering.value
                  ? ReelBufferingIndicator(config: config)
                  : const SizedBox.shrink(),
            ),
            if (config.showProgressIndicator)
              Positioned(
                bottom: 30 + config.styling.contentBottomPadding,
                left: config.progressBarPadding,
                right: config.progressBarPadding,
                child: ReelProgressIndicator(
                  reel: reel,
                  config: config,
                  onSeek: (position) => config.callbacks.onSeek?.call(position),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleFollow(BuildContext context) {
    if (reel.user?.id == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Following ${reel.user!.username}'),
        duration: const Duration(seconds: 2),
        backgroundColor: config.styling.accentColor,
      ),
    );
  }
}
