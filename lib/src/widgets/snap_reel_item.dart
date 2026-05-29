import 'package:flutter/material.dart';

import 'package:snap_reels/src/controllers/reel_controller.dart';
import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';
import 'package:snap_reels/src/widgets/reel_overlay.dart';
import 'package:snap_reels/src/widgets/reel_video_player.dart';

/// One page in the feed: the video player plus either the host's custom
/// overlay or the default [ReelOverlay].
class SnapReelItem extends StatelessWidget {
  /// Creates a feed item bound to [reel].
  const SnapReelItem({
    required this.reel,
    required this.controller,
    required this.config,
    this.overlayBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.onTap,
    this.onLongPress,
    this.onLike,
    this.onShare,
    this.onComment,
    this.onFollow,
    this.onBlock,
    this.onCompleted,
    this.onVideoError,
    super.key,
  });

  /// Reel rendered by this item.
  final ReelModel reel;

  /// Shared controller driving the player pool.
  final ReelController controller;

  /// Styling and behavior configuration.
  final ReelConfig config;

  /// Optional builder replacing the default overlay.
  final Widget Function(
    BuildContext context,
    ReelModel reel,
    ReelController controller,
  )?
  overlayBuilder;

  /// Optional builder replacing the inline error UI of the player.
  final Widget Function(BuildContext context, ReelModel reel, String error)?
  errorBuilder;

  /// Optional builder replacing the inline loading UI of the player.
  final Widget Function(BuildContext context, ReelModel reel)? loadingBuilder;

  /// Forwarded to [ReelOverlay.onTap]. Receives the reel and current position.
  final void Function(ReelModel reel, Duration position)? onTap;

  /// Forwarded to [ReelOverlay.onLongPress].
  final void Function(ReelModel reel, Duration position)? onLongPress;

  /// Notified when the like action fires for [reel].
  final void Function(ReelModel reel)? onLike;

  /// Notified when the share action fires for [reel].
  final void Function(ReelModel reel)? onShare;

  /// Notified when the comment action fires for [reel].
  final void Function(ReelModel reel)? onComment;

  /// Notified when the follow action fires. Receives the author.
  final void Function(ReelUser user)? onFollow;

  /// Notified when the block action fires. Receives the author.
  final void Function(ReelUser user)? onBlock;

  /// Notified once when the video finishes.
  final void Function(ReelModel reel)? onCompleted;

  /// Notified on a playback error. Receives the reel and the error.
  final void Function(ReelModel reel, Object error)? onVideoError;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ReelVideoPlayer(
          key: ValueKey('reel_video_${reel.id}'),
          reel: reel,
          controller: controller,
          config: config,
          errorBuilder: (context, reel, error) {
            onVideoError?.call(reel, error);
            return errorBuilder?.call(context, reel, error) ??
                const SizedBox.shrink();
          },
          loadingBuilder: loadingBuilder,
        ),
        if (overlayBuilder != null)
          overlayBuilder!(context, reel, controller)
        else
          ReelOverlay(
            reel: reel,
            config: config,
            controller: controller,
            onTap: onTap != null
                ? () => onTap!(reel, controller.currentPosition.value)
                : null,
            onLongPress: onLongPress != null
                ? () => onLongPress!(reel, controller.currentPosition.value)
                : null,
            onLike: () => onLike?.call(reel),
            onShare: () => onShare?.call(reel),
            onComment: () => onComment?.call(reel),
            onFollow: () => onFollow?.call(reel.user!),
            onBlock: () => onBlock?.call(reel.user!),
            onCompleted: () => onCompleted?.call(reel),
          ),
      ],
    );
  }
}
