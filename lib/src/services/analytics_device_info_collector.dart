import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:device_info_plus/device_info_plus.dart';

import 'package:snap_reels/src/models/reel_analytics.dart';

/// Resolves a [DeviceInfo] snapshot from the host platform.
class AnalyticsDeviceInfoCollector {
  const AnalyticsDeviceInfoCollector._();

  /// Reads platform / model / OS version. Falls back to a minimal record
  /// with only [Platform.operatingSystem] on error.
  static Future<DeviceInfo> collect() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        return DeviceInfo(
          platform: 'Android',
          deviceModel: '${androidInfo.manufacturer} ${androidInfo.model}',
          osVersion: 'Android ${androidInfo.version.release}',
        );
      }

      if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        return DeviceInfo(
          platform: 'iOS',
          deviceModel: iosInfo.model,
          osVersion: iosInfo.systemVersion,
        );
      }

      return DeviceInfo(platform: Platform.operatingSystem);
    } catch (e) {
      debugPrint('Error collecting device info: $e');
      return DeviceInfo(platform: Platform.operatingSystem);
    }
  }
}
