part of 'reel_controller.dart';

/// Player pool creation, slot assignment, stream subscriptions, disposal.
///
/// Uses a serial-based cancellation mechanism: each [_initializeCurrentVideo]
/// call receives a serial. If a newer call arrives while an older one is still
/// in-flight, the older one self-cancels at every `await` checkpoint.
mixin _VideoLifecycleMixin on GetxController, _ReelStateMixin {
  /// Create the fixed pool of 3 Player + VideoController pairs.
  void _initializePool() {
    for (int i = 0; i < _poolSize; i++) {
      final player = Player();
      _players.add(player);
      _slotSubscriptions.add(_subscribeSlot(i));
    }
  }

  /// Set up stream listeners for a pool slot. Listeners live until dispose.
  List<StreamSubscription> _subscribeSlot(int slot) {
    final player = _players[slot];
    return [
      player.stream.position.listen((pos) {
        if (_activeSlot == slot) _currentPosition.value = pos;
      }),
      player.stream.duration.listen((dur) {
        if (_activeSlot == slot) _totalDuration.value = dur;
      }),
      player.stream.buffering.listen((buf) {
        if (_activeSlot == slot) _isBuffering.value = buf;
      }),
      player.stream.error.listen((err) {
        if (_activeSlot == slot) _error.value = err;
      }),
      player.stream.playing.listen((playing) {
        if (_activeSlot == slot) _isPlaying.value = playing;
      }),
      // Signal when first frame is decoded (video dimensions available).
      player.stream.width.listen((w) {
        if (w != null && w > 0) {
          _poolVersion.value++;
          if (_activeSlot == slot) {
            _isVideoInitializing.value = false;
          }
        }
      }),
    ];
  }

  /// Initialize the video for the current index.
  Future<void> _initializeCurrentVideo([int? serial]) async {
    final expectedSerial = serial ?? _initSerial;
    final currentReel = _currentReel.value;
    if (currentReel == null) return;
    if (_players.isEmpty || _isDisposed.value) return;

    final currentIndex = _currentIndex.value;

    // Fast path: reel is already loaded in a slot.
    final existingSlot = _reelToSlot[currentIndex];
    if (existingSlot != null) {
      _switchToSlot(existingSlot);
      await _startPlayback();
      _poolVersion.value++;
      return;
    }

    // Slow path: need to open on a recycled slot.
    try {
      _isVideoInitializing.value = true;
      _error.value = null;

      final slot = _getRecyclableSlot(currentIndex);

      // Pause previous active slot.
      if (_activeSlot >= 0 && _activeSlot != slot) {
        await _players[_activeSlot].pause();
      }
      if (_initSerial != expectedSerial) return;

      await _openSlot(slot, currentReel, play: false);
      if (_initSerial != expectedSerial) return;

      _switchToSlot(slot);
      _initializedVideoIndices[currentIndex] = true;

      await _startPlayback();
      _poolVersion.value++;
    } catch (e) {
      _error.value = e.toString();
      debugPrint('Error initializing current video: $e');
    } finally {
      if (_initSerial == expectedSerial) {
        _isVideoInitializing.value = false;
      }
    }
  }

  /// Open a Media on the given slot.
  Future<void> _openSlot(int slot, ReelModel reel, {bool play = false}) async {
    final url = _resolveVideoUrl(reel);
    final player = _players[slot];

    // Streaming tunables (см. media-kit/media-kit#959).
    // setProperty доступен только на native backend (mpv); на web — no-op.
    final platform = player.platform;
    if (platform is NativePlayer) {
      // FFmpeg auto-reconnect: при transient HTTP error / keep-alive close
      // libavformat выходит в EOF и playback стопорится. Включаем повторное
      // подключение с экспоненциальным backoff на уровне libavformat.
      await platform.setProperty(
        'demuxer-lavf-o',
        'reconnect=1,'
            'reconnect_streamed=1,'
            'reconnect_on_network_error=1,'
            'reconnect_delay_max=2',
      );
      await platform.setProperty('network-timeout', '30');
      // HW decoding если поддерживается, иначе SW — рекомендованный preset
      // media_kit для mobile. Снимает зависания на specific форматах,
      // которые ловит фиксированный hwdec=mediacodec.
      await platform.setProperty('hwdec', 'auto-safe');
      // Прогрессивный MP4 без явного `Accept-Ranges` иногда трактуется как
      // unseekable — ставим явно, чтобы libmpv мог делать range-requests
      // на восстановлении после reconnect.
      await platform.setProperty('force-seekable', 'yes');
      // Readahead-буфер демуксера: 20 сек вперёд снижает шанс попасть
      // в underrun на первых секундах playback.
      await platform.setProperty('cache', 'yes');
      await platform.setProperty('cache-secs', '10');
      await platform.setProperty('demuxer-readahead-secs', '20');
    }

    // Unmap previous assignment for this slot.
    final prevIndex = _slotToReel[slot];
    if (prevIndex != null) {
      _reelToSlot.remove(prevIndex);
      _initializedVideoIndices.remove(prevIndex);
    }

    final reelIndex = _reels.indexOf(reel);
    _reelToSlot[reelIndex] = slot;
    _slotToReel[slot] = reelIndex;
    await player.open(Media(url), play: play);
    await player.setPlaylistMode(
      reel.shouldLoop ? PlaylistMode.single : PlaylistMode.none,
    );
    await player.setVolume(_isMuted.value ? 0.0 : _volume.value * 100.0);

    _initializedVideoIndices[reelIndex] = true;
  }

  void _switchToSlot(int slot) {
    _activeSlot = slot;
  }

  Future<void> _startPlayback() async {
    if (_activeSlot < 0 || _activeSlot >= _players.length) return;
    if (_isDisposed.value) return;
    final player = _players[_activeSlot];

    try {
      if (_config.autoPlay && _isVisible.value) {
        await player.play();
        _playStartTime = DateTime.now();
      }
    } catch (e) {
      debugPrint('Error starting playback: $e');
    }
  }

  /// Find the pool slot farthest from [targetIndex], or an empty one.
  int _getRecyclableSlot(int targetIndex) {
    // Prefer an unassigned slot.
    for (int i = 0; i < _poolSize; i++) {
      if (!_slotToReel.containsKey(i)) return i;
    }

    // All slots assigned — recycle the farthest from target.
    int farthestSlot = 0;
    int maxDistance = -1;
    for (int i = 0; i < _poolSize; i++) {
      final dist = (_slotToReel[i]! - targetIndex).abs();
      if (dist > maxDistance) {
        maxDistance = dist;
        farthestSlot = i;
      }
    }
    return farthestSlot;
  }

  String _resolveVideoUrl(ReelModel reel) {
    final videoSource = reel.videoSource;
    if (videoSource != null) return videoSource.getUrlForFormat(VideoFormat.mp4);
    final videoUrl = reel.videoUrl;
    if (videoUrl != null) return videoUrl;
    throw Exception('No video source available');
  }

  /// Stop all players and clear slot assignments without destroying the pool.
  /// Used on re-initialization to avoid dispose/recreate races.
  Future<void> _resetPool() async {
    _activeSlot = -1;
    _reelToSlot.clear();
    _slotToReel.clear();
    _initializedVideoIndices.clear();
    for (final player in _players) {
      await player.stop();
    }
  }

  /// Permanently dispose the pool. Only called from [dispose].
  Future<void> _disposePool() async {
    // Invalidate active slot FIRST so play()/pause() bail out immediately
    // while disposal is in progress.
    _activeSlot = -1;
    _reelToSlot.clear();
    _slotToReel.clear();

    for (final subs in _slotSubscriptions) {
      for (final s in subs) {
        await s.cancel();
      }
    }
    _slotSubscriptions.clear();

    for (final player in _players) {
      await player.dispose();
    }
    _players.clear();
  }
}
