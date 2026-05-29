import 'dart:io';

import 'package:flutter/foundation.dart';

/// Platform / build-mode helpers.
class PlatformUtils {
  PlatformUtils._();

  /// Alias for [Platform.pathSeparator].
  static String get pathSeparator => Platform.pathSeparator;

  /// `true` when running a debug build.
  static bool get isDebugMode => kDebugMode;

  /// `true` when running a release build.
  static bool get isReleaseMode => kReleaseMode;
}
