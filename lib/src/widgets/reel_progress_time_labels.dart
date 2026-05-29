import 'package:flutter/material.dart';

import 'package:snap_reels/src/utils/format_utils.dart';

/// Two timestamp labels (elapsed / total) shown under the progress bar.
class ReelProgressTimeLabels extends StatelessWidget {
  /// Creates the labels row.
  const ReelProgressTimeLabels({
    required this.position,
    required this.duration,
    required this.textColor,
    super.key,
  });

  /// Current playback position.
  final Duration position;

  /// Total video duration.
  final Duration duration;

  /// Text color applied to both labels (the right one gets `alpha=0.7`).
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            FormatUtils.formatDuration(position),
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            FormatUtils.formatDuration(duration),
            style: TextStyle(
              color: textColor.withValues(alpha: 0.7),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
