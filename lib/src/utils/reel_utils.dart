import 'dart:async';

import 'package:flutter/material.dart';

import 'package:snap_reels/src/utils/color_utils.dart';
import 'package:snap_reels/src/utils/format_utils.dart';
import 'package:snap_reels/src/utils/math_utils.dart';
import 'package:snap_reels/src/utils/platform_utils.dart';
import 'package:snap_reels/src/utils/responsive_utils.dart';
import 'package:snap_reels/src/utils/string_utils.dart';
import 'package:snap_reels/src/utils/timing_utils.dart';
import 'package:snap_reels/src/utils/video_url_utils.dart';

/// Backwards-compatible facade aggregating the focused `*Utils` helpers
/// in [package:snap_reels/src/utils]. Prefer the individual classes
/// (e.g. [FormatUtils], [ColorUtils]) in new code.
class ReelUtils {
  ReelUtils._();

  /// See [FormatUtils.formatDuration].
  static String formatDuration(Duration duration) =>
      FormatUtils.formatDuration(duration);

  /// See [FormatUtils.formatDurationFromMilliseconds].
  static String formatDurationFromMilliseconds(int? milliseconds) =>
      FormatUtils.formatDurationFromMilliseconds(milliseconds);

  /// See [FormatUtils.formatCount].
  static String formatCount(int count) => FormatUtils.formatCount(count);

  /// See [FormatUtils.formatFileSize].
  static String formatFileSize(int bytes) => FormatUtils.formatFileSize(bytes);

  /// See [StringUtils.generateId].
  static String generateId() => StringUtils.generateId();

  /// See [VideoUrlUtils.isValidUrl].
  static bool isValidUrl(String url) => VideoUrlUtils.isValidUrl(url);

  /// See [VideoUrlUtils.isVideoUrl].
  static bool isVideoUrl(String url) => VideoUrlUtils.isVideoUrl(url);

  /// See [VideoUrlUtils.extractVideoId].
  static String? extractVideoId(String url) =>
      VideoUrlUtils.extractVideoId(url);

  /// See [VideoUrlUtils.getThumbnailUrl].
  static String? getThumbnailUrl(String videoUrl) =>
      VideoUrlUtils.getThumbnailUrl(videoUrl);

  /// See [MathUtils.calculateAspectRatio].
  static double calculateAspectRatio(double width, double height) =>
      MathUtils.calculateAspectRatio(width, height);

  /// See [ResponsiveUtils.getResponsiveFontSize].
  static double getResponsiveFontSize(
    BuildContext context,
    double baseFontSize,
  ) => ResponsiveUtils.getResponsiveFontSize(context, baseFontSize);

  /// See [ResponsiveUtils.getResponsivePadding].
  static EdgeInsets getResponsivePadding(
    BuildContext context,
    EdgeInsets basePadding,
  ) => ResponsiveUtils.getResponsivePadding(context, basePadding);

  /// See [ResponsiveUtils.isTablet].
  static bool isTablet(BuildContext context) =>
      ResponsiveUtils.isTablet(context);

  /// See [TimingUtils.debounce].
  static Timer debounce(
    void Function() function,
    Duration delay, {
    Timer? previousTimer,
  }) => TimingUtils.debounce(function, delay, previousTimer: previousTimer);

  /// See [TimingUtils.throttle].
  static bool throttle(String key, Duration duration) =>
      TimingUtils.throttle(key, duration);

  /// See [ColorUtils.hexToColor].
  static Color hexToColor(String hexString) => ColorUtils.hexToColor(hexString);

  /// See [ColorUtils.colorToHex].
  static String colorToHex(Color color) => ColorUtils.colorToHex(color);

  /// See [ColorUtils.getLuminance].
  static double getLuminance(Color color) => ColorUtils.getLuminance(color);

  /// See [ColorUtils.getContrastingColor].
  static Color getContrastingColor(Color backgroundColor) =>
      ColorUtils.getContrastingColor(backgroundColor);

  /// See [ColorUtils.generateGradient].
  static List<Color> generateGradient(
    Color startColor,
    Color endColor,
    int steps,
  ) => ColorUtils.generateGradient(startColor, endColor, steps);

  /// See [MathUtils.easeInOut].
  static double easeInOut(double t) => MathUtils.easeInOut(t);

  /// See [MathUtils.lerp].
  static double lerp(double start, double end, double t) =>
      MathUtils.lerp(start, end, t);

  /// See [MathUtils.clamp].
  static T clamp<T extends num>(T value, T min, T max) =>
      MathUtils.clamp(value, min, max);

  /// See [MathUtils.mapRange].
  static double mapRange(
    double value,
    double inMin,
    double inMax,
    double outMin,
    double outMax,
  ) => MathUtils.mapRange(value, inMin, inMax, outMin, outMax);

  /// See [MathUtils.rectsIntersect].
  static bool rectsIntersect(Rect rect1, Rect rect2) =>
      MathUtils.rectsIntersect(rect1, rect2);

  /// See [MathUtils.getDistance].
  static double getDistance(Offset point1, Offset point2) =>
      MathUtils.getDistance(point1, point2);

  /// See [MathUtils.getAngle].
  static double getAngle(Offset point1, Offset point2) =>
      MathUtils.getAngle(point1, point2);

  /// See [MathUtils.radiansToDegrees].
  static double radiansToDegrees(double radians) =>
      MathUtils.radiansToDegrees(radians);

  /// See [MathUtils.degreesToRadians].
  static double degreesToRadians(double degrees) =>
      MathUtils.degreesToRadians(degrees);

  /// See [ColorUtils.randomColor].
  static Color randomColor() => ColorUtils.randomColor();

  /// See [StringUtils.isValidEmail].
  static bool isValidEmail(String email) => StringUtils.isValidEmail(email);

  /// See [StringUtils.isNumeric].
  static bool isNumeric(String str) => StringUtils.isNumeric(str);

  /// See [StringUtils.capitalizeWords].
  static String capitalizeWords(String text) =>
      StringUtils.capitalizeWords(text);

  /// See [StringUtils.truncateText].
  static String truncateText(String text, int maxLength) =>
      StringUtils.truncateText(text, maxLength);

  /// See [PlatformUtils.pathSeparator].
  static String get pathSeparator => PlatformUtils.pathSeparator;

  /// See [PlatformUtils.isDebugMode].
  static bool get isDebugMode => PlatformUtils.isDebugMode;

  /// See [PlatformUtils.isReleaseMode].
  static bool get isReleaseMode => PlatformUtils.isReleaseMode;

  /// See [TimingUtils.timestamp].
  static int get timestamp => TimingUtils.timestamp;

  /// See [TimingUtils.timestampToDateTime].
  static DateTime timestampToDateTime(int timestamp) =>
      TimingUtils.timestampToDateTime(timestamp);

  /// See [TimingUtils.getTimeAgo].
  static String getTimeAgo(DateTime dateTime) =>
      TimingUtils.getTimeAgo(dateTime);
}
