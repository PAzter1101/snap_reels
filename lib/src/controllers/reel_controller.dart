import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart' hide VideoFormat;
import 'package:wakelock_plus/wakelock_plus.dart';
import '../models/reel_model.dart';
import '../models/reel_config.dart';
import '../services/cache_manager.dart';
import '../utils/device_classifier.dart';

/// Simplified controller to prevent codec overload crashes
class ReelController extends GetxController {
  List<ReelModel> _reels = [];
  late ReelConfig _config;
  PageController? _pageController;

  final RxList<ReelModel> _reelsList = <ReelModel>[].obs;

  // Keep track of active and preloaded controllers
  VideoPlayerController? _currentVideoController;
  final Map<int, VideoPlayerController?> _preloadedControllers = {};
  int _currentVideoIndex = -1;

  // Track initialization state
  final RxBool _isVideoInitializing = false.obs;
  final Map<int, bool> _initializedVideoIndices = {};
  PreloadConfig? _effectivePreloadConfig;
  Timer? _preloadDebounce;
  int _initSerial = 0;

  final RxInt _currentIndex = 0.obs;
  final RxBool _isInitialized = false.obs;
  final RxBool _isDisposed = false.obs;
  final RxBool _isVisible = true.obs;
  final Rx<ReelModel?> _currentReel = Rx<ReelModel?>(null);

  // State properties
  final RxBool _isMuted = false.obs;
  final RxDouble _volume = 1.0.obs;
  final RxBool _isPlaying = false.obs;
  final RxBool _isBuffering = false.obs;
  final Rx<Duration> _currentPosition = Duration.zero.obs;
  final Rx<Duration> _totalDuration = Duration.zero.obs;
  final RxnString _error = RxnString();

  // Scroll-based playing
  final RxDouble _pageScrollProgress = 0.0.obs;
  final RxBool _canPlayNext = false.obs;

  // Playtime tracking
  DateTime? _playStartTime;
  Duration _accumulatedPlayTime = Duration.zero;

  // Last frame of the current video (used for smooth transitions)
  final Rx<ImageProvider?> _lastVideoFrame = Rx<ImageProvider?>(null);

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

  // Getters
  List<ReelModel> get reels => _reels;
  ReelConfig get config => _config;
  PageController? get pageController => _pageController;

  // Observable getters
  RxList<ReelModel> get reelsList => _reelsList;
  RxInt get currentIndex => _currentIndex;
  RxBool get isInitialized => _isInitialized;
  RxBool get isDisposed => _isDisposed;
  RxBool get isVisible => _isVisible;
  Rx<ReelModel?> get currentReel => _currentReel;
  RxBool get isMuted => _isMuted;
  RxDouble get volume => _volume;
  RxBool get isPlaying => _isPlaying;
  RxBool get isBuffering => _isBuffering;
  Rx<Duration> get currentPosition => _currentPosition;
  Rx<Duration> get totalDuration => _totalDuration;
  RxnString get error => _error;
  RxDouble get pageScrollProgress => _pageScrollProgress;
  RxBool get canPlayNext => _canPlayNext;
  bool get isVideoInitializing => _isVideoInitializing.value;
  Rx<ImageProvider?> get lastVideoFrame => _lastVideoFrame;

  /// Check if a video at a specific index is already initialized
  bool isVideoAlreadyInitialized(int index) {
    return _initializedVideoIndices.containsKey(index) &&
        _initializedVideoIndices[index] == true;
  }

  /// Get current video controller (only one at a time)
  VideoPlayerController? get currentVideoController {
    final currentIndex = _currentIndex.value;
    if (_currentVideoIndex != currentIndex) return null;
    return _currentVideoController;
  }

  /// Get video controller for specific reel
  VideoPlayerController? getVideoControllerForReel(ReelModel reel) {
    final reelIndex = _reels.indexOf(reel);
    if (reelIndex == -1) return null;

    // Return the active controller if this is the current reel
    if (_currentVideoIndex == reelIndex && _currentVideoController != null) {
      return _currentVideoController;
    }

    // Return a preloaded controller if available
    return _preloadedControllers[reelIndex];
  }

  /// Initialize the controller
  Future<void> initialize({
    List<ReelModel>? reels,
    ReelConfig? config,
    int initialIndex = 0,
  }) async {
    try {
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

      // Reset initialization tracking
      _initializedVideoIndices.clear();

      // Clear any preloaded controllers
      await _disposeAllControllers();

      // Initialize page controller
      _pageController = PageController(initialPage: _currentIndex.value);

      // Adjust preload strategy for weak devices
      if (_config.preloadConfig.adaptivePreload) {
        final deviceClass = await DeviceClassifier.classify();
        _effectivePreloadConfig = DeviceClassifier.adjustPreload(
          _config.preloadConfig,
          deviceClass,
        );
        debugPrint('Device class: $deviceClass, preloadAhead: ${_effectivePreloadConfig!.preloadAhead}');
      } else {
        _effectivePreloadConfig = _config.preloadConfig;
      }

      // Initialize current video
      await _initializeCurrentVideo();

      // Preload adjacent videos for smoother transitions
      _preloadAdjacentVideos(_currentIndex.value);

      _isInitialized.value = true;
      // Enable wakelock if needed
      WakelockPlus.enable();

      debugPrint('ReelController initialized with ${_reels.length} reels');
    } catch (e) {
      _error.value = e.toString();
      debugPrint('ReelController initialization error: $e');
      rethrow;
    }
  }

  /// Initialize current video.
  ///
  /// [serial] — номер вызова из onPageChanged. Если за время await
  /// пришёл новый вызов (_initSerial != serial), инициализация отменяется.
  Future<void> _initializeCurrentVideo([int? serial]) async {
    final expectedSerial = serial ?? _initSerial;
    final currentReel = _currentReel.value;
    if (currentReel == null) return;

    final currentIndex = _currentIndex.value;

    // Check if this video is already preloaded
    if (_preloadedControllers.containsKey(currentIndex) &&
        _preloadedControllers[currentIndex] != null &&
        _preloadedControllers[currentIndex]!.value.isInitialized) {
      debugPrint('Using preloaded controller for index $currentIndex');

      if (_currentVideoController != null &&
          _currentVideoIndex != currentIndex) {
        try {
          await _currentVideoController!.pause();
        } catch (_) {}
        if (_initSerial != expectedSerial) return; // отменён новым вызовом
        _currentVideoController!.removeListener(_onVideoControllerUpdate);
        if (_currentVideoIndex >= 0 && _currentVideoIndex < _reels.length) {
          _preloadedControllers[_currentVideoIndex] = _currentVideoController;
        } else {
          await _currentVideoController!.dispose();
        }
      }

      if (_initSerial != expectedSerial) return;

      _currentVideoController = _preloadedControllers[currentIndex];
      _currentVideoIndex = currentIndex;
      _initializedVideoIndices[currentIndex] = true;
      _preloadedControllers.remove(currentIndex);

      await _startPlayback(currentReel);
      return;
    }

    try {
      _isVideoInitializing.value = true;
      _error.value = null;

      // Pause and save current controller before replacing
      if (_currentVideoController != null &&
          _currentVideoIndex != currentIndex) {
        try {
          await _currentVideoController!.pause();
        } catch (_) {}
        if (_initSerial != expectedSerial) return; // отменён новым вызовом
        _currentVideoController!.removeListener(_onVideoControllerUpdate);
        if (_currentVideoIndex >= 0 && _currentVideoIndex < _reels.length) {
          _preloadedControllers[_currentVideoIndex] = _currentVideoController;
          _currentVideoController = null;
        } else {
          await _disposeCurrentController();
        }
      }

      final controller = await _createVideoController(currentReel);
      if (_initSerial != expectedSerial) {
        // Пришёл новый onPageChanged пока грузились — dispose и выход
        controller?.dispose();
        return;
      }

      if (controller != null) {
        _currentVideoController = controller;
        _currentVideoIndex = currentIndex;
        _initializedVideoIndices[currentIndex] = true;

        await _startPlayback(currentReel);
      }
    } catch (e) {
      _error.value = e.toString();
      debugPrint('Error initializing current video: $e');
    } finally {
      _isVideoInitializing.value = false;
    }
  }

  /// Preload adjacent videos for smoother transitions
  Future<void> _preloadAdjacentVideos(int currentIndex) async {
    final preload = _effectivePreloadConfig ?? _config.preloadConfig;

    // Dispose controllers that are far from current position
    // to free hardware video decoder slots (most devices have 3-4)
    final keysToRemove = <int>[];
    for (final key in _preloadedControllers.keys) {
      if ((key - currentIndex).abs() > 1) {
        keysToRemove.add(key);
      }
    }
    for (final key in keysToRemove) {
      final controller = _preloadedControllers.remove(key);
      _initializedVideoIndices.remove(key);
      if (controller != null) {
        try {
          await controller.pause();
          await controller.dispose();
        } catch (_) {}
      }
    }

    // Preload next video first (users scroll down ~80% of the time)
    if (preload.preloadAhead > 0 && currentIndex < _reels.length - 1) {
      await _preloadVideo(currentIndex + 1);
    }

    // Preload previous video in background (lower priority)
    if (preload.preloadBehind > 0 && currentIndex > 0) {
      _preloadVideo(currentIndex - 1);
    }
  }

  /// Handle system memory pressure — dispose preloaded controllers,
  /// keep only the currently playing video alive.
  void handleMemoryPressure() {
    debugPrint('snap_reels: memory pressure — disposing preloaded controllers');
    for (final entry in _preloadedControllers.entries.toList()) {
      final controller = entry.value;
      _preloadedControllers.remove(entry.key);
      _initializedVideoIndices.remove(entry.key);
      if (controller != null) {
        try {
          controller.pause();
          controller.dispose();
        } catch (_) {}
      }
    }
    CacheManager.instance.clearMemoryCache();
  }

  /// Dispose all controllers (active and preloaded)
  Future<void> _disposeAllControllers() async {
    // Dispose active controller
    await _disposeCurrentController();

    // Dispose all preloaded controllers
    for (final controller in _preloadedControllers.values) {
      if (controller != null) {
        try {
          await controller.pause();
          await controller.dispose();
        } catch (e) {
          debugPrint('Error disposing preloaded controller: $e');
        }
      }
    }

    _preloadedControllers.clear();
  }

  /// Dispose current video controller
  Future<void> _disposeCurrentController() async {
    if (_currentVideoController != null) {
      try {
        await _currentVideoController!.pause();
        _currentVideoController!.removeListener(_onVideoControllerUpdate);
        await _currentVideoController!.dispose();
      } catch (e) {
        debugPrint('Error disposing video controller: $e');
      } finally {
        _currentVideoController = null;
        _currentVideoIndex = -1;
      }
    }
  }

  /// Create video controller
  Future<VideoPlayerController?> _createVideoController(ReelModel reel) async {
    try {
      final videoSource = reel.videoSource;
      final videoUrl = reel.videoUrl;

      VideoPlayerController controller;

      if (videoSource != null) {
        final url = videoSource.getUrlForFormat(VideoFormat.mp4);
        controller = VideoPlayerController.networkUrl(Uri.parse(url));
      } else if (videoUrl != null) {
        controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      } else {
        throw Exception('No video source available');
      }

      await controller.initialize();
      await controller.setLooping(reel.shouldLoop);
      await controller.setVolume(_isMuted.value ? 0.0 : _volume.value);
      // Ensure preloaded controllers stay paused until activated
      try {
        await controller.pause();
      } catch (_) {}

      return controller;
    } catch (e) {
      debugPrint('Error creating video controller: $e');
      return null;
    }
  }

  /// Start playback for current reel
  Future<void> _startPlayback(ReelModel reel) async {
    if (_currentVideoController == null) return;

    try {
      if (_config.autoPlay && _isVisible.value) {
        await _currentVideoController!.play();
        _isPlaying.value = true;
        _playStartTime = DateTime.now();
      }

      // Setup listeners
      _currentVideoController!.addListener(_onVideoControllerUpdate);
    } catch (e) {
      debugPrint('Error starting playback: $e');
    }
  }

  /// Video controller update listener
  void _onVideoControllerUpdate() {
    if (_currentVideoController == null) return;

    final controller = _currentVideoController!;
    _currentPosition.value = controller.value.position;
    _totalDuration.value = controller.value.duration;
    _isBuffering.value = controller.value.isBuffering;

    if (controller.value.hasError) {
      _error.value = controller.value.errorDescription;
    }

    // Prevent black video: if initialized but no texture shown yet and playing,
    // force a rebuild by briefly toggling play/pause when first frame not ready.
    if (controller.value.isInitialized &&
        controller.value.isPlaying &&
        controller.value.size.width > 0 &&
        controller.value.size.height > 0) {
      // All good; nothing to do
    }
  }

  /// Navigate to next reel
  Future<void> nextPage() async {
    if (_pageController == null || _currentIndex.value >= _reels.length - 1) {
      return;
    }
    await _pageController!.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Animate a "peek" at the next reel without fully scrolling to it.
  ///
  /// Shows a preview of the next reel by partially dragging the current one,
  /// then snapping back. Useful for onboarding hints.
  ///
  /// [peekOffset] — how far to drag in pixels (default 150).
  /// [repeats] — how many times to repeat the peek (default 2).
  /// [dragDuration] — duration of each drag animation (default 400ms).
  /// [returnDuration] — duration of each return animation (default 300ms).
  /// [pauseBetween] — pause between repeats (default 500ms).
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

  /// Navigate to previous reel
  Future<void> previousPage() async {
    if (_pageController == null || _currentIndex.value <= 0) {
      return;
    }
    await _pageController!.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// Handle page change
  Future<void> onPageChanged(int index) async {
    if (index == _currentIndex.value) return;

    // Pause previous active controller before switching
    if (_currentVideoController != null && _currentVideoIndex != index) {
      try {
        await _currentVideoController!.pause();
        _isPlaying.value = false;
      } catch (_) {}
    }

    _currentIndex.value = index;
    _currentReel.value = _reels[index];

    // Increment serial so any in-flight init for a previous index self-cancels
    final serial = ++_initSerial;

    // Switch to the new video immediately - either preloaded or initialize new
    await _initializeCurrentVideo(serial);

    // Debounce preload: during fast scroll, skip intermediate preloads
    _preloadDebounce?.cancel();
    _preloadDebounce = Timer(const Duration(milliseconds: 200), () {
      _preloadAdjacentVideos(index);
    });
  }

  /// Preload a video at a specific index without making it active
  Future<void> _preloadVideo(int index) async {
    if (index < 0 ||
        index >= _reels.length ||
        isVideoAlreadyInitialized(index) ||
        _preloadedControllers.containsKey(index)) {
      return;
    }

    try {
      debugPrint('Preloading video at index $index');
      final reel = _reels[index];
      final controller = await _createVideoController(reel);

      if (controller != null) {
        _preloadedControllers[index] = controller;
        _initializedVideoIndices[index] = true;
        debugPrint('Successfully preloaded video at index $index');
      }
    } catch (e) {
      debugPrint('Error preloading video at index $index: $e');
    }
  }

  /// Play current video
  Future<void> play() async {
    if (_currentVideoController == null) return;

    try {
      await _currentVideoController!.play();
      _isPlaying.value = true;
      _playStartTime = DateTime.now();
    } catch (e) {
      debugPrint('Error playing video: $e');
    }
  }

  /// Pause current video
  Future<void> pause() async {
    if (_currentVideoController == null) return;

    try {
      await _currentVideoController!.pause();
      _isPlaying.value = false;
      _updateAccumulatedPlayTime();
    } catch (e) {
      debugPrint('Error pausing video: $e');
    }
  }

  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    if (_isPlaying.value) {
      await pause();
    } else {
      await play();
    }
  }

  /// Seek to position
  Future<void> seekTo(Duration position) async {
    if (_currentVideoController == null) return;

    try {
      await _currentVideoController!.seekTo(position);
    } catch (e) {
      debugPrint('Error seeking video: $e');
    }
  }

  /// Set volume
  Future<void> setVolume(double volume) async {
    _volume.value = volume.clamp(0.0, 1.0);

    if (_currentVideoController != null) {
      await _currentVideoController!
          .setVolume(_isMuted.value ? 0.0 : _volume.value);
    }
  }

  /// Toggle mute
  Future<void> toggleMute() async {
    _isMuted.value = !_isMuted.value;

    if (_currentVideoController != null) {
      await _currentVideoController!
          .setVolume(_isMuted.value ? 0.0 : _volume.value);
    }
  }

  /// Set visibility
  void setVisibility(bool visible) {
    _isVisible.value = visible;

    if (!visible) {
      pause();
    } else if (_config.autoPlay) {
      play();
    }
  }

  /// Set app visibility (simplified)
  void setAppVisibility(bool visible) {
    setVisibility(visible);
  }

  /// Check if a specific reel is currently active
  bool isReelActive(ReelModel reel) {
    final reelIndex = _reels.indexOf(reel);
    return reelIndex != -1 && _currentVideoIndex == reelIndex;
  }

  /// Initialize video for specific reel (index-based)
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

  /// Toggle like (no-op implementation)
  void toggleLike([ReelModel? reel]) {
    // Simplified - no like functionality
    debugPrint('Like toggled');
  }

  /// Increment share (no-op implementation)
  void incrementShare([ReelModel? reel]) {
    // Simplified - no share functionality
    debugPrint('Share incremented');
  }

  /// Download reel (no-op implementation)
  void downloadReel([ReelModel? reel]) {
    // Simplified - no download functionality
    debugPrint('Download requested');
  }

  /// Block user (no-op implementation)
  void blockUser([String? userId]) {
    // Simplified - no block functionality
    debugPrint('User blocked');
  }

  /// Follow user (no-op implementation)
  void followUser([String? userId]) {
    // Simplified - no follow functionality
    debugPrint('User followed');
  }

  /// Append new reels without reinitializing the controller
  void appendReels(List<ReelModel> newReels) {
    _reels.addAll(newReels);
    _reelsList.addAll(newReels);
  }

  /// Clear error
  void clearError() {
    _error.value = null;
  }

  /// Retry
  Future<void> retry() async {
    await retryCurrentVideo();
  }

  /// Retry current video initialization
  Future<void> retryCurrentVideo() async {
    final currentReel = _currentReel.value;
    if (currentReel != null) {
      clearError();
      // Remove from initialized tracking to force a fresh init
      _initializedVideoIndices.remove(_currentIndex.value);
      await _initializeCurrentVideo();
    }
  }

  /// Check if has error
  bool get hasError => _error.value != null;

  /// Get error message
  String? get errorMessage => _error.value;

  /// Get position stream (simplified)
  Stream<Duration> get positionStream => _currentPosition.stream;

  /// Was playing before seek
  bool get wasPlayingBeforeSeek => _isPlaying.value;

  /// Refresh (no-op)
  @override
  void refresh() {
    debugPrint('Refresh called');
  }

  /// Update accumulated play time
  void _updateAccumulatedPlayTime() {
    if (_playStartTime != null) {
      _accumulatedPlayTime += DateTime.now().difference(_playStartTime!);
      _playStartTime = null;
    }
  }

  /// Get accumulated play time for current reel
  Duration getAccumulatedPlayTime() {
    Duration total = _accumulatedPlayTime;
    if (_playStartTime != null && _isPlaying.value) {
      total += DateTime.now().difference(_playStartTime!);
    }
    return total;
  }

  @override
  void onClose() {
    dispose();
    super.onClose();
  }

  /// Dispose controller
  @override
  void dispose() {
    if (_isDisposed.value) return;

    _isDisposed.value = true;
    _preloadDebounce?.cancel();
    _updateAccumulatedPlayTime();

    // Dispose all controllers
    _disposeAllControllers();

    // Dispose page controller
    _pageController?.dispose();
    _pageController = null;

    // Disable wakelock
    WakelockPlus.disable();

    debugPrint('ReelController disposed');

    super.dispose();
  }
}
