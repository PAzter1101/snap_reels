import 'dart:math';

import 'package:flutter/material.dart';

/// Screen-size / device-class aware sizing helpers.
class ResponsiveUtils {
  ResponsiveUtils._();

  /// Scales [baseFontSize] by the ratio of the current screen width to
  /// the iPhone 6/7/8 baseline (375pt), clamped to `[0.8, 1.2]`.
  static double getResponsiveFontSize(
    BuildContext context,
    double baseFontSize,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375;
    return baseFontSize * scaleFactor.clamp(0.8, 1.2);
  }

  /// Scales each side of [basePadding] by the screen-width / 375 ratio.
  static EdgeInsets getResponsivePadding(
    BuildContext context,
    EdgeInsets basePadding,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scaleFactor = screenWidth / 375;
    return EdgeInsets.only(
      left: basePadding.left * scaleFactor,
      top: basePadding.top * scaleFactor,
      right: basePadding.right * scaleFactor,
      bottom: basePadding.bottom * scaleFactor,
    );
  }

  /// `true` when the device's physical diagonal exceeds 7 inches.
  static bool isTablet(BuildContext context) {
    return _calculateDiagonal(context) > 7.0;
  }

  static double _calculateDiagonal(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    final widthInches = size.width * devicePixelRatio / 160;
    final heightInches = size.height * devicePixelRatio / 160;
    return sqrt(widthInches * widthInches + heightInches * heightInches);
  }
}
