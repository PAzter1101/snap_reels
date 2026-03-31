part of 'reel_controller.dart';

/// Default pool size; overridden by [DeviceClassifier] for high-end devices.
const int _kDefaultPoolSize = 3;

/// Shared reactive state and public getters for [ReelController].
mixin _ReelStateMixin on GetxController {
  List<ReelModel> _reels = [];
  late ReelConfig _config;
  PageController? _pageController;

  final RxList<ReelModel> _reelsList = <ReelModel>[].obs;
  int _poolSize = _kDefaultPoolSize;
  final List<Player> _players = [];
  final List<List<StreamSubscription>> _slotSubscriptions = [];

  // Slot assignment: reel index ↔ pool slot
  final Map<int, int> _reelToSlot = {};
  final Map<int, int> _slotToReel = {};
  int _activeSlot = -1;

  // Initialization tracking
  final RxBool _isVideoInitializing = false.obs;
  final Map<int, bool> _initializedVideoIndices = {};
  PreloadConfig? _effectivePreloadConfig;
  Timer? _preloadDebounce;
  int _initSerial = 0;

  // Obx trigger — incremented when slot assignments change
  final RxInt _poolVersion = 0.obs;

  final RxInt _currentIndex = 0.obs;
  final RxBool _isInitialized = false.obs;
  final RxBool _isDisposed = false.obs;
  final RxBool _isVisible = true.obs;
  final Rx<ReelModel?> _currentReel = Rx<ReelModel?>(null);

  // Playback state
  final RxBool _isMuted = false.obs;
  final RxDouble _volume = 1.0.obs;
  final RxBool _isPlaying = false.obs;
  final RxBool _isBuffering = false.obs;
  final Rx<Duration> _currentPosition = Duration.zero.obs;
  final Rx<Duration> _totalDuration = Duration.zero.obs;
  final RxnString _error = RxnString();

  // Scroll state
  final RxDouble _pageScrollProgress = 0.0.obs;
  final RxBool _canPlayNext = false.obs;

  // Playtime tracking
  DateTime? _playStartTime;
  Duration _accumulatedPlayTime = Duration.zero;

  // Last frame for smooth transitions
  final Rx<ImageProvider?> _lastVideoFrame = Rx<ImageProvider?>(null);

  // --- Public getters ---

  List<ReelModel> get reels => _reels;
  ReelConfig get config => _config;
  PageController? get pageController => _pageController;

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
  RxInt get poolVersion => _poolVersion;

  bool get hasError => _error.value != null;
  String? get errorMessage => _error.value;
  Stream<Duration> get positionStream => _currentPosition.stream;
  bool get wasPlayingBeforeSeek => _isPlaying.value;

  /// The active Player or null.
  Player? get currentPlayer =>
      _activeSlot >= 0 ? _players[_activeSlot] : null;

  /// media_kit VideoController — created by the Video widget, not the pool.
  /// Kept for API compatibility; returns null (widgets create their own).
  VideoController? get currentVideoController => null;

  bool isVideoAlreadyInitialized(int index) {
    return _initializedVideoIndices.containsKey(index) &&
        _initializedVideoIndices[index] == true;
  }

  /// Get the Player assigned to a specific reel (used by widgets).
  Player? getPlayerForReel(ReelModel reel) {
    // Touch _poolVersion so Obx rebuilds when slots change.
    _poolVersion.value;

    final reelIndex = _reels.indexOf(reel);
    if (reelIndex == -1) return null;

    final slot = _reelToSlot[reelIndex];
    if (slot == null) return null;

    return _players[slot];
  }

  bool isReelActive(ReelModel reel) {
    final reelIndex = _reels.indexOf(reel);
    if (reelIndex == -1) return false;
    final slot = _reelToSlot[reelIndex];
    return slot != null && slot == _activeSlot;
  }
}
