import 'dart:math';

import 'package:flutter/material.dart';

/// Color manipulation helpers.
class ColorUtils {
  ColorUtils._();

  /// Parses a hex color string (`#RRGGBB`, `RRGGBB` or `AARRGGBB`).
  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Returns the `#RRGGBB` form of [color] (alpha dropped).
  static String colorToHex(Color color) {
    final hex = color.toARGB32().toRadixString(16).padLeft(8, '0');
    return '#${hex.substring(2)}';
  }

  /// Convenience alias for [Color.computeLuminance].
  static double getLuminance(Color color) => color.computeLuminance();

  /// Returns black or white depending on which gives better contrast on
  /// [backgroundColor].
  static Color getContrastingColor(Color backgroundColor) {
    return getLuminance(backgroundColor) > 0.5 ? Colors.black : Colors.white;
  }

  /// Builds a linear interpolation between [startColor] and [endColor]
  /// with [steps] discrete stops (inclusive).
  static List<Color> generateGradient(
    Color startColor,
    Color endColor,
    int steps,
  ) {
    final colors = <Color>[];
    for (var i = 0; i < steps; i++) {
      final ratio = i / (steps - 1);
      final red =
          ((startColor.r * 255.0) +
                  ((endColor.r - startColor.r) * 255.0) * ratio)
              .round();
      final green =
          ((startColor.g * 255.0) +
                  ((endColor.g - startColor.g) * 255.0) * ratio)
              .round();
      final blue =
          ((startColor.b * 255.0) +
                  ((endColor.b - startColor.b) * 255.0) * ratio)
              .round();
      final alpha =
          ((startColor.a * 255.0) +
                  ((endColor.a - startColor.a) * 255.0) * ratio)
              .round();
      colors.add(Color.fromARGB(alpha, red, green, blue));
    }
    return colors;
  }

  /// Returns a random opaque color.
  static Color randomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
