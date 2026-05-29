import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:snap_reels/src/controllers/reel_controller.dart';
import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';
import 'package:snap_reels/src/utils/reel_utils.dart';

/// Bottom row rendered by the overlay when
/// [ReelActionsConfig.showBottomControls] is enabled: play/pause toggle,
/// elapsed duration label and mute toggle.
class ReelBottomControls extends StatelessWidget {
  /// Creates the bottom controls row bound to [controller].
  const ReelBottomControls({
    required this.reel,
    required this.config,
    required this.controller,
    super.key,
  });

  /// Reel whose duration label is rendered.
  final ReelModel reel;

  /// Styling configuration.
  final ReelConfig config;

  /// Controller that drives the player.
  final ReelController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 8,
        left: 16,
        right: 16,
        top: 8,
      ),
      child: Row(
        children: [
          Obx(
            () => IconButton(
              onPressed: controller.togglePlayPause,
              icon: Icon(
                controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                color: config.styling.textColor,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            ReelUtils.formatDurationFromMilliseconds(
              reel.duration?.inMilliseconds,
            ),
            style: TextStyle(
              color: config.styling.textColor.withAlpha(192),
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 8),
          Obx(
            () => IconButton(
              onPressed: controller.toggleMute,
              icon: Icon(
                controller.isMuted.value ? Icons.volume_off : Icons.volume_up,
                color: config.styling.textColor,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
