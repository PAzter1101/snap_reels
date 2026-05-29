import 'package:flutter/material.dart';

import 'package:snap_reels/src/utils/reel_utils.dart';

/// Floating preview shown above the progress bar while the user scrubs.
/// Renders a placeholder thumbnail + the absolute timestamp at the drag
/// position.
class ScrubThumbnailPreview extends StatelessWidget {
  /// Creates the preview anchored at [anchorLeft] (in local coordinates
  /// of the progress indicator).
  const ScrubThumbnailPreview({
    required this.anchorLeft,
    required this.time,
    super.key,
    this.width = 150,
    this.height = 90,
  });

  /// Horizontal anchor in the parent's coordinate space. The preview is
  /// centered around this point and clamped to the screen.
  final double anchorLeft;

  /// Absolute video time corresponding to the drag position.
  final Duration time;

  /// Preview width in logical pixels.
  final double width;

  /// Preview height in logical pixels.
  final double height;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final safeLeft = (anchorLeft - width / 2).clamp(
      16.0,
      screenWidth - width - 16.0,
    );

    return Positioned(
      bottom: 40,
      left: safeLeft,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 150),
        tween: Tween(begin: 0, end: 1),
        builder: (context, value, child) => Transform.scale(
          scale: 0.8 + 0.2 * value,
          child: Opacity(opacity: value, child: child),
        ),
        child: _PreviewCard(width: width, height: height, time: time),
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  const _PreviewCard({
    required this.width,
    required this.height,
    required this.time,
  });

  final double width;
  final double height;
  final Duration time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white30, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            spreadRadius: 3,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey.shade800, Colors.grey.shade900],
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        color: Colors.white70,
                        size: 28,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Preview',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                ReelUtils.formatDuration(time),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
