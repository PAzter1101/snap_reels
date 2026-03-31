part of 'reel_controller.dart';

/// Play/pause, volume, seek, visibility, and playtime tracking.
///
/// Note: media_kit volume is 0–100, public API stays 0.0–1.0.
mixin _PlaybackMixin on GetxController, _ReelStateMixin {
  Future<void> play() async {
    if (_isDisposed.value) return;
    final player = currentPlayer;
    if (player == null) return;

    try {
      await player.play();
      _playStartTime = DateTime.now();
    } catch (e) {
      debugPrint('Error playing video: $e');
    }
  }

  Future<void> pause() async {
    if (_isDisposed.value) return;
    final player = currentPlayer;
    if (player == null) return;

    try {
      await player.pause();
      _updateAccumulatedPlayTime();
    } catch (e) {
      debugPrint('Error pausing video: $e');
    }
  }

  Future<void> togglePlayPause() async {
    if (_isPlaying.value) {
      await pause();
    } else {
      await play();
    }
  }

  Future<void> seekTo(Duration position) async {
    final player = currentPlayer;
    if (player == null) return;

    try {
      await player.seek(position);
    } catch (e) {
      debugPrint('Error seeking video: $e');
    }
  }

  Future<void> setVolume(double volume) async {
    _volume.value = volume.clamp(0.0, 1.0);
    final mkVolume = _isMuted.value ? 0.0 : _volume.value * 100.0;

    final player = currentPlayer;
    if (player != null) {
      await player.setVolume(mkVolume);
    }
  }

  Future<void> toggleMute() async {
    _isMuted.value = !_isMuted.value;
    final mkVolume = _isMuted.value ? 0.0 : _volume.value * 100.0;

    final player = currentPlayer;
    if (player != null) {
      await player.setVolume(mkVolume);
    }
  }

  void setVisibility(bool visible) {
    _isVisible.value = visible;

    if (!visible) {
      pause();
    } else if (_config.autoPlay) {
      play();
    }
  }

  void setAppVisibility(bool visible) {
    setVisibility(visible);
  }

  void _updateAccumulatedPlayTime() {
    if (_playStartTime != null) {
      _accumulatedPlayTime += DateTime.now().difference(_playStartTime!);
      _playStartTime = null;
    }
  }

  Duration getAccumulatedPlayTime() {
    Duration total = _accumulatedPlayTime;
    if (_playStartTime != null && _isPlaying.value) {
      total += DateTime.now().difference(_playStartTime!);
    }
    return total;
  }
}
