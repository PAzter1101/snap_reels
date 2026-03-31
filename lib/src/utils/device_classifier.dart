import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

import '../models/reel_config.dart';

/// Класс устройства по производительности.
enum DeviceClass { low, medium, high }

/// Определяет класс устройства и корректирует preload-стратегию.
class DeviceClassifier {
  static DeviceClass? _cached;

  /// Классифицирует устройство по доступной RAM.
  ///
  /// Android: `totalMemory` из AndroidDeviceInfo.
  /// iOS: модель (< iPhone 11 → low, иначе medium/high).
  /// Web/Desktop: всегда medium.
  static Future<DeviceClass> classify() async {
    if (_cached != null) return _cached!;

    try {
      final info = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final android = await info.androidInfo;
        // device_info_plus не предоставляет totalMemory,
        // используем sdkInt как прокси: старые SDK = слабые устройства
        final sdk = android.version.sdkInt;
        if (sdk < 28) {
          // Android 9 и ниже — скорее всего слабое устройство
          _cached = DeviceClass.low;
        } else if (sdk < 31) {
          _cached = DeviceClass.medium;
        } else {
          _cached = DeviceClass.high;
        }
      } else if (Platform.isIOS) {
        final ios = await info.iosInfo;
        final model = ios.utsname.machine; // e.g. "iPhone12,1"
        final gen = _parseIphoneGeneration(model);
        if (gen != null && gen < 11) {
          _cached = DeviceClass.low;
        } else {
          _cached = DeviceClass.high;
        }
      } else {
        _cached = DeviceClass.medium;
      }
    } catch (e) {
      debugPrint('DeviceClassifier error: $e');
      _cached = DeviceClass.medium;
    }

    _cached ??= DeviceClass.medium;
    return _cached!;
  }

  /// Корректирует PreloadConfig под класс устройства.
  static PreloadConfig adjustPreload(
    PreloadConfig config,
    DeviceClass deviceClass,
  ) {
    switch (deviceClass) {
      case DeviceClass.low:
        return config.copyWith(
          preloadAhead: 1,
          preloadBehind: 0,
          maxPreloaded: 2,
        );
      case DeviceClass.medium:
        return config;
      case DeviceClass.high:
        return config.copyWith(
          preloadAhead: 3,
          preloadBehind: 1,
        );
    }
  }

  /// Рекомендуемый размер пула Player'ов для класса устройства.
  ///
  /// low: 2 (current + next), medium: 3 (prev/current/next),
  /// high: 5 (prev/current + 3 ahead).
  static int recommendedPoolSize(DeviceClass deviceClass) {
    switch (deviceClass) {
      case DeviceClass.low:
        return 2;
      case DeviceClass.medium:
        return 3;
      case DeviceClass.high:
        return 5;
    }
  }

  /// Парсит поколение iPhone из machine string.
  /// "iPhone12,1" → 12, "iPhone14,5" → 14.
  static int? _parseIphoneGeneration(String machine) {
    final match = RegExp(r'iPhone(\d+)').firstMatch(machine);
    if (match == null) return null;
    return int.tryParse(match.group(1)!);
  }
}
