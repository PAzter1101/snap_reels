import 'package:flutter/material.dart';

/// Configuration for the progress indicator
class ProgressIndicatorConfig {
  const ProgressIndicatorConfig({
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white24,
    this.height = 2.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.showTimeLabels = false,
    this.timeLabelStyle,
  });
  final Color activeColor;
  final Color inactiveColor;
  final double height;
  final EdgeInsets margin;
  final bool showTimeLabels;
  final TextStyle? timeLabelStyle;
}

/// Configuration for shimmer effect
class ShimmerConfig {
  const ShimmerConfig({
    this.baseColor = const Color(0xFF1A1A1A),
    this.highlightColor = const Color(0xFF3A3A3A),
    this.period = const Duration(milliseconds: 1500),
    this.direction = ShimmerDirection.ltr,
  });
  final Color baseColor;
  final Color highlightColor;
  final Duration period;
  final ShimmerDirection direction;
}

/// Shimmer animation direction
enum ShimmerDirection {
  ltr,
  rtl,
  ttb,
  btt,
}
