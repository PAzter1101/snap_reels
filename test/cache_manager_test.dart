import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:snap_reels/src/services/cache_manager.dart';

class _FakePathProvider extends PathProviderPlatform
    with MockPlatformInterfaceMixin {
  _FakePathProvider(this._tempPath);

  final String _tempPath;

  @override
  Future<String?> getTemporaryPath() async => _tempPath;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    final tempDir =
        Directory.systemTemp.createTempSync('snap_reels_cache_mgr_test_');
    PathProviderPlatform.instance = _FakePathProvider(tempDir.path);
  });

  group('CacheManager', () {
    test('initialize is idempotent', () async {
      await CacheManager.instance.initialize();
      await CacheManager.instance.initialize();
      await CacheManager.instance.initialize(dio: Dio());
    });

    test('public API works after initialize', () async {
      await CacheManager.instance.initialize();

      expect(
        CacheManager.instance.getCachedFilePath('https://example.com/x.mp4'),
        isNull,
      );
      expect(
        await CacheManager.instance.isCached('https://example.com/y.mp4'),
        isFalse,
      );

      final stats = await CacheManager.instance.getCacheStats();
      expect(stats.totalSize, greaterThanOrEqualTo(0));
    });
  });
}
