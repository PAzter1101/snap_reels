import 'package:flutter/material.dart';

/// Configuration for the progress indicator
class ProgressIndicatorConfig {
  /// Creates a [ProgressIndicatorConfig].
  const ProgressIndicatorConfig({
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white24,
    this.height = 2.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.showTimeLabels = false,
    this.timeLabelStyle,
  });

  /// Color of the played portion of the bar.
  final Color activeColor;

  /// Color of the remaining portion of the bar.
  final Color inactiveColor;

  /// Thickness of the bar in logical pixels.
  final double height;

  /// Outer margin around the bar.
  final EdgeInsets margin;

  /// Whether elapsed/total time labels are rendered next to the bar.
  final bool showTimeLabels;

  /// Optional override for the time label text style.
  final TextStyle? timeLabelStyle;
}

/// Configuration for shimmer effect
class ShimmerConfig {
  /// Creates a [ShimmerConfig].
  const ShimmerConfig({
    this.baseColor = const Color(0xFF1A1A1A),
    this.highlightColor = const Color(0xFF3A3A3A),
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
  });

  /// Background color of the shimmer surface.
  final Color baseColor;

  /// Color of the moving highlight band.
  final Color highlightColor;

  /// Time it takes the highlight to traverse the surface once.
  final Duration period;

  /// Direction the highlight band moves in.
  final ShimmerDirection direction;
}

/// Shimmer animation direction
enum ShimmerDirection {
  /// Left to right.
  ltr,

  /// Right to left.
  rtl,

  /// Top to bottom.
  ttb,

  /// Bottom to top.
  btt,
}
