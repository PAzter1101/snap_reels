part of 'reel_controller.dart';

/// Manages preloading of adjacent videos via slot recycling.
///
/// With a fixed pool of 3 players there is no disposal — the farthest
/// slot is recycled with [player.open] for the new video.
mixin _PreloadManagerMixin
    on GetxController, _ReelStateMixin, _VideoLifecycleMixin {
  /// Ensure prev/current/next are loaded in the pool.
  Future<void> _preloadAdjacentVideos(int currentIndex) async {
    final preload = _effectivePreloadConfig ?? _config.preloadConfig;

    // Next video first — users scroll down ~80% of the time.
    if (preload.preloadAhead > 0 && currentIndex < _reels.length - 1) {
      await _preloadVideo(currentIndex + 1);
    }

    // Previous video (lower priority, no await).
    if (preload.preloadBehind > 0 && currentIndex > 0) {
      _preloadVideo(currentIndex - 1);
    }
  }

  Future<void> _preloadVideo(int index) async {
    if (index < 0 || index >= _reels.length) return;
    if (_reelToSlot.containsKey(index)) return; // already in a slot
    if (_players.isEmpty || _isDisposed.value) return;

    try {
      debugPrint('Preloading video at index $index');
      final slot = _getRecyclableSlot(index);
      await _openSlot(slot, _reels[index], play: false);
      debugPrint('Successfully preloaded video at index $index');
    } catch (e) {
      debugPrint('Error preloading video at index $index: $e');
    }
  }

  /// Stop non-active players to free decoder memory (without destroying them).
  void handleMemoryPressure() {
    debugPrint('snap_reels: memory pressure — stopping non-active players');
    for (int i = 0; i < _players.length; i++) {
      if (i == _activeSlot) continue;
      _players[i].stop();
      final reelIndex = _slotToReel.remove(i);
      if (reelIndex != null) {
        _reelToSlot.remove(reelIndex);
        _initializedVideoIndices.remove(reelIndex);
      }
    }
    CacheManager.instance.clearMemoryCache();
  }
}
