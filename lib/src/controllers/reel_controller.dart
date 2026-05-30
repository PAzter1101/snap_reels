import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';
import 'package:snap_reels/src/services/cache_manager.dart';
import 'package:snap_reels/src/utils/device_classifier.dart';

part '_playback_mixin.dart';
part '_preload_manager_mixin.dart';
part '_reel_state_mixin.dart';
part '_video_lifecycle_mixin.dart';

/// Main orchestrator: wires together state, video lifecycle, preloading
/// and playback. Handles initialization, page changes and navigation.
class ReelController extends GetxController
    with
        _ReelStateMixin,
        _VideoLifecycleMixin,
        _PreloadManagerMixin,
        _PlaybackMixin {
  /// Creates a controller. Pass [reels] and [config] here or via [initialize].
  ReelController({
    List<ReelModel>? reels,
    ReelConfig? config,
  }) {
    _reels = reels ?? [];
    _config = config ?? const ReelConfig();
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('ReelController initialized');
  }

  // --- Initialization ---

  /// Initializes media_kit, the player pool, the page controller and
  /// kicks off playback of the first reel. Safe to call repeatedly.
  Future<void> initialize({
    List<ReelModel>? reels,
    ReelConfig? config,
    int initialIndex = 0,
  }) async {
    try {
      _error.value = null;
      _isInitialized.value = false;

      _reels = reels ?? [];
      _config = config ?? const ReelConfig();

      if (_reels.isEmpty) {
        throw Exception('No reels provided');
      }

      MediaKit.ensureInitialized();

      if (_config.enableCaching) {
        try {
          await CacheManager().initialize(
            dio: _config.httpClient,
            config: _config.cacheConfig,
          );
        } catch (e) {
          debugPrint('CacheManager initialization failed: $e');
        }
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
      unawaited(_preloadAdjacentVideos(_currentIndex.value));

      _isInitialized.value = true;
      unawaited(WakelockPlus.enable());

      debugPrint('ReelController initialized with ${_reels.length} reels');
    } catch (e) {
      _error.value = e.toString();
      debugPrint('ReelController initialization error: $e');
      rethrow;
    }
  }

  // --- Page changes ---

  /// Called by the PageView when the visible reel changes. Pauses the
  /// previous video, initializes the new one and schedules adjacent
  /// preload after a short debounce.
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
      unawaited(_preloadAdjacentVideos(index));
    });
  }

  /// Jumps to the given reel and initializes it. No-op if it's already current.
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

  /// Animates the PageView to the next reel.
  Future<void> nextPage() async {
    if (_pageController == null || _currentIndex.value >= _reels.length - 1) {
      return;
    }
    await _pageController!.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Animates the PageView to the previous reel.
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

    for (var i = 0; i < repeats; i++) {
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
        await Future<void>.delayed(pauseBetween);
      }
    }
  }

  // --- Reel list management ---

  /// Appends more reels to the feed without recreating the player pool.
  /// Useful for infinite scroll pagination.
  void appendReels(List<ReelModel> newReels) {
    _reels.addAll(newReels);
    _reelsList.addAll(newReels);
  }

  // --- Error / retry ---

  /// Clears the current error state so the UI can render again.
  void clearError() {
    _error.value = null;
  }

  /// Alias for [retryCurrentVideo].
  Future<void> retry() async {
    await retryCurrentVideo();
  }

  /// Forces re-initialization of the currently visible video. Use after a
  /// transient network or decoder error.
  Future<void> retryCurrentVideo() async {
    final currentReel = _currentReel.value;
    if (currentReel != null) {
      clearError();
      _initializedVideoIndices.remove(_currentIndex.value);
      _reelToSlot.remove(_currentIndex.value);
      await _initializeCurrentVideo();
    }
  }

  // --- Lifecycle ---

  /// Awaitable teardown of native player resources. Use instead of
  /// [dispose] when callers reallocate the controller immediately.
  Future<void> close() async {
    if (_isDisposed.value) return;
    _isDisposed.value = true;
    _preloadDebounce?.cancel();
    _updateAccumulatedPlayTime();

    await _disposePool();

    _pageController?.dispose();
    _pageController = null;

    await WakelockPlus.disable();
  }

  @override
  Future<void> onClose() async {
    await close();
    super.onClose();
  }

  /// Synchronous teardown; fires [close] without awaiting. For ordered
  /// native cleanup call `await close()` before disposal.
  @override
  void dispose() {
    if (!_isDisposed.value) {
      unawaited(close());
    }
    super.dispose();
  }
}
