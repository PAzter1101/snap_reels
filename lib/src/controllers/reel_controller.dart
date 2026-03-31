import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../models/reel_model.dart';
import '../models/reel_config.dart';
import '../services/cache_manager.dart';
import '../utils/device_classifier.dart';

part '_reel_state_mixin.dart';
part '_video_lifecycle_mixin.dart';
part '_preload_manager_mixin.dart';
part '_playback_mixin.dart';

/// Main orchestrator: wires together state, video lifecycle, preloading
/// and playback. Handles initialization, page changes and navigation.
class ReelController extends GetxController
    with
        _ReelStateMixin,
        _VideoLifecycleMixin,
        _PreloadManagerMixin,
        _PlaybackMixin {
  ReelController({
    List<ReelModel>? reels,
    ReelConfig? config,
  }) {
    _reels = reels ?? [];
    _config = config ?? ReelConfig();
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('ReelController initialized');
  }

  // --- Initialization ---

  Future<void> initialize({
    List<ReelModel>? reels,
    ReelConfig? config,
    int initialIndex = 0,
  }) async {
    try {
      MediaKit.ensureInitialized();

      _error.value = null;
      _isInitialized.value = false;

      _reels = reels ?? [];
      _config = config ?? ReelConfig();

      if (_reels.isEmpty) {
        throw Exception('No reels provided');
      }

      _reelsList.value = List.from(_reels);
      _currentIndex.value = initialIndex.clamp(0, _reels.length - 1);
      _currentReel.value = _reels[_currentIndex.value];

      _initializedVideoIndices.clear();

      // Determine device class and pool size before creating the pool.
      if (_config.preloadConfig.adaptivePreload) {
        final deviceClass = await DeviceClassifier.classify();
        _poolSize = DeviceClassifier.recommendedPoolSize(deviceClass);
        _effectivePreloadConfig = DeviceClassifier.adjustPreload(
          _config.preloadConfig,
          deviceClass,
        );
        debugPrint(
          'Device class: $deviceClass, '
          'poolSize: $_poolSize, '
          'preloadAhead: ${_effectivePreloadConfig!.preloadAhead}',
        );
      } else {
        _poolSize = _kDefaultPoolSize;
        _effectivePreloadConfig = _config.preloadConfig;
      }

      // Create the pool once; on re-init just reset slot assignments.
      if (_players.isEmpty) {
        _initializePool();
      } else {
        await _resetPool();
      }

      _pageController = PageController(initialPage: _currentIndex.value);

      await _initializeCurrentVideo();
      _preloadAdjacentVideos(_currentIndex.value);

      _isInitialized.value = true;
      WakelockPlus.enable();

      debugPrint('ReelController initialized with ${_reels.length} reels');
    } catch (e) {
      _error.value = e.toString();
      debugPrint('ReelController initialization error: $e');
      rethrow;
    }
  }

  // --- Page changes ---

  Future<void> onPageChanged(int index) async {
    if (index == _currentIndex.value) return;

    // Pause the currently active player.
    if (_activeSlot >= 0) {
      try {
        await _players[_activeSlot].pause();
      } catch (_) {}
    }

    _currentIndex.value = index;
    _currentReel.value = _reels[index];

    final serial = ++_initSerial;
    await _initializeCurrentVideo(serial);

    _preloadDebounce?.cancel();
    _preloadDebounce = Timer(const Duration(milliseconds: 200), () {
      _preloadAdjacentVideos(index);
    });
  }

  Future<void> initializeVideoForReel(ReelModel reel) async {
    final reelIndex = _reels.indexOf(reel);
    if (reelIndex == -1) {
      debugPrint('Reel not found in list');
      return;
    }

    if (_currentIndex.value != reelIndex) {
      _currentIndex.value = reelIndex;
      _currentReel.value = reel;
      await _initializeCurrentVideo();
    }
  }

  // --- Navigation ---

  Future<void> nextPage() async {
    if (_pageController == null || _currentIndex.value >= _reels.length - 1) {
      return;
    }
    await _pageController!.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> previousPage() async {
    if (_pageController == null || _currentIndex.value <= 0) {
      return;
    }
    await _pageController!.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Animate a "peek" at the next reel without fully scrolling to it.
  Future<void> peekNext({
    double peekOffset = 150,
    int repeats = 2,
    Duration dragDuration = const Duration(milliseconds: 400),
    Duration returnDuration = const Duration(milliseconds: 300),
    Duration pauseBetween = const Duration(milliseconds: 500),
  }) async {
    final pc = _pageController;
    if (pc == null || !pc.hasClients) return;
    if (_currentIndex.value >= _reels.length - 1) return;

    for (int i = 0; i < repeats; i++) {
      final baseOffset = pc.offset;
      await pc.animateTo(
        baseOffset + peekOffset,
        duration: dragDuration,
        curve: Curves.easeOut,
      );
      await pc.animateTo(
        baseOffset,
        duration: returnDuration,
        curve: Curves.easeInOut,
      );
      if (i < repeats - 1) {
        await Future.delayed(pauseBetween);
      }
    }
  }

  // --- Reel list management ---

  void appendReels(List<ReelModel> newReels) {
    _reels.addAll(newReels);
    _reelsList.addAll(newReels);
  }

  // --- Error / retry ---

  void clearError() {
    _error.value = null;
  }

  Future<void> retry() async {
    await retryCurrentVideo();
  }

  Future<void> retryCurrentVideo() async {
    final currentReel = _currentReel.value;
    if (currentReel != null) {
      clearError();
      _initializedVideoIndices.remove(_currentIndex.value);
      _reelToSlot.remove(_currentIndex.value);
      await _initializeCurrentVideo();
    }
  }

  // --- No-op stubs (reserved for future use) ---

  void toggleLike([ReelModel? reel]) => debugPrint('Like toggled');
  void incrementShare([ReelModel? reel]) => debugPrint('Share incremented');
  void downloadReel([ReelModel? reel]) => debugPrint('Download requested');
  void blockUser([String? userId]) => debugPrint('User blocked');
  void followUser([String? userId]) => debugPrint('User followed');

  @override
  void refresh() => debugPrint('Refresh called');

  // --- Lifecycle ---

  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  @override
  void dispose() {
    if (_isDisposed.value) return;

    _isDisposed.value = true;
    _preloadDebounce?.cancel();
    _updateAccumulatedPlayTime();

    _disposePool();

    _pageController?.dispose();
    _pageController = null;

    WakelockPlus.disable();

    debugPrint('ReelController disposed');

    super.dispose();
  }
}
