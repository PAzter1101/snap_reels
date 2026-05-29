import 'package:flutter/material.dart';

/// Visual portion of the progress bar: a grey background track with a
/// foreground fill of width `progress * 100%`. Has no gestures — the
/// parent owns hit-testing.
class ProgressTrackBar extends StatelessWidget {
  /// Creates the bar.
  const ProgressTrackBar({
    required this.progress,
    required this.trackHeight,
    required this.progressColor,
    super.key,
  });

  /// Played fraction in `[0, 1]`. Values outside the range are clamped.
  final double progress;

  /// Track thickness in logical pixels. Border radius is `trackHeight / 2`.
  final double trackHeight;

  /// Color of the played portion.
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(trackHeight / 2);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: trackHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.3),
            borderRadius: radius,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              height: trackHeight,
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: radius,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
