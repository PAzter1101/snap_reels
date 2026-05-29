import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:snap_reels/src/controllers/reel_controller.dart';
import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';
import 'package:snap_reels/src/widgets/reel_overlay.dart';
import 'package:snap_reels/src/widgets/reel_video_player.dart';

/// The main SnapReels widget for displaying vertical video reels
class SnapReels extends StatefulWidget {
  /// Creates a [SnapReels] feed. Only [reels] is required.
  const SnapReels({
    required this.reels,
    super.key,
    this.config = const ReelConfig(),
    this.initialIndex = 0,
    this.controller,
    this.onReelChanged,
    this.onReelLiked,
    this.onReelShared,
    this.onReelCommented,
    this.onUserFollowed,
    this.onUserBlocked,
    this.onVideoCompleted,
    this.onVideoError,
    this.onPageChanged,
    this.onTap,
    this.onLongPress,
    this.onLikeTapped,
    this.onCommentTapped,
    this.onShareTapped,
    this.onFollowTapped,
    this.onUserProfileTapped,
    this.overlayBuilder,
    this.errorBuilder,
    this.loadingBuilder,
  });

  /// List of reel models to display
  final List<ReelModel> reels;

  /// Configuration for the reels widget
  final ReelConfig config;

  /// Initial page index
  final int initialIndex;

  /// Callback when page changes
  final void Function(int index, ReelModel reel)? onPageChanged;

  /// Callback when video tapped
  final void Function(ReelModel reel, Duration position)? onTap;

  /// Callback when video long pressed
  final void Function(ReelModel reel, Duration position)? onLongPress;

  /// Callback when like button tapped
  final void Function(ReelModel reel, {required bool isLiked})? onLikeTapped;

  /// Callback when comment button tapped
  final void Function(ReelModel reel)? onCommentTapped;

  /// Callback when share button tapped
  final void Function(ReelModel reel)? onShareTapped;

  /// Callback when follow button tapped
  final void Function(ReelModel reel, {required bool isFollowing})?
  onFollowTapped;

  /// Callback when user profile tapped
  final void Function(ReelModel reel)? onUserProfileTapped;

  /// Custom overlay builder
  final Widget Function(
    BuildContext context,
    ReelModel reel,
    ReelController controller,
  )?
  overlayBuilder;

  /// Custom error widget builder
  final Widget Function(BuildContext context, ReelModel reel, String error)?
  errorBuilder;

  /// Custom loading widget builder
  final Widget Function(BuildContext context, ReelModel reel)? loadingBuilder;

  /// Optional externally owned controller. When `null`, [SnapReels]
  /// creates and owns its own.
  final ReelController? controller;

  /// Notified each time the visible reel changes. Receives the new index.
  final void Function(int index)? onReelChanged;

  /// Notified when the user likes the active reel.
  final void Function(ReelModel reel)? onReelLiked;

  /// Notified when the user shares the active reel.
  final void Function(ReelModel reel)? onReelShared;

  /// Notified when the user opens comments on the active reel.
  final void Function(ReelModel reel)? onReelCommented;

  /// Notified when the user follows a reel's author.
  final void Function(ReelUser user)? onUserFollowed;

  /// Notified when the user blocks a reel's author.
  final void Function(ReelUser user)? onUserBlocked;

  /// Notified once when a video reaches its end.
  final void Function(ReelModel reel)? onVideoCompleted;

  /// Notified on a playback error. Receives the failing reel and the error.
  final void Function(ReelModel reel, Object error)? onVideoError;

  @override
  State<SnapReels> createState() => _SnapReelsState();
}

class _SnapReelsState extends State<SnapReels>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late ReelController _controller;
  bool _isExternalController = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isExternalController = widget.controller != null;
    if (widget.controller != null) {
      _controller = widget.controller!;
      Get.put(_controller, permanent: true);
    } else {
      _controller = Get.put(ReelController(), permanent: true);
    }
    if (!_controller.isInitialized.value) {
      unawaited(_initializeController());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _controller.setAppVisibility(visible: true);
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        _controller.setAppVisibility(visible: false);
      case AppLifecycleState.hidden:
        _controller.setAppVisibility(visible: false);
    }
  }

  @override
  void didHaveMemoryPressure() {
    super.didHaveMemoryPressure();
    _controller.handleMemoryPressure();
  }

  @override
  void didUpdateWidget(SnapReels oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reinitialize if reels or config changed
    if (widget.reels != oldWidget.reels || widget.config != oldWidget.config) {
      unawaited(_initializeController());
    }
  }

  Future<void> _initializeController() async {
    try {
      await _controller.initialize(
        reels: widget.reels,
        config: widget.config,
        initialIndex: widget.initialIndex,
      );
    } catch (e) {
      debugPrint('Error initializing SnapReels: $e');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (!_isExternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ColoredBox(
      color: widget.config.backgroundColor,
      child: widget.config.enablePullToRefresh
          ? RefreshIndicator(
              onRefresh: widget.config.onRefresh ?? () async {},
              child: _buildPageView(),
            )
          : _buildPageView(),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _controller.pageController,
      scrollDirection: Axis.vertical,
      physics: widget.config.physics,
      itemCount: widget.reels.length,
      onPageChanged: (index) {
        unawaited(_controller.onPageChanged(index));
        widget.onReelChanged?.call(index);
      },
      itemBuilder: (context, index) {
        if (index >= widget.reels.length) return const SizedBox.shrink();
        final reel = widget.reels[index];
        return _buildReelItem(reel, index);
      },
    );
  }

  Widget _buildReelItem(ReelModel reel, int index) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ReelVideoPlayer(
          key: ValueKey('reel_video_${reel.id}'),
          reel: reel,
          controller: _controller,
          config: widget.config,
          errorBuilder: (context, reel, error) {
            widget.onVideoError?.call(reel, error);
            return widget.errorBuilder?.call(context, reel, error) ??
                const SizedBox.shrink();
          },
          loadingBuilder: widget.loadingBuilder,
        ),
        if (widget.overlayBuilder != null)
          widget.overlayBuilder!(context, reel, _controller)
        else
          ReelOverlay(
            reel: reel,
            config: widget.config,
            controller: _controller,
            onTap: widget.onTap != null
                ? () => widget.onTap!(reel, _controller.currentPosition.value)
                : null,
            onLongPress: widget.onLongPress != null
                ? () => widget.onLongPress!(
                    reel,
                    _controller.currentPosition.value,
                  )
                : null,
            onLike: () => widget.onReelLiked?.call(reel),
            onShare: () => widget.onReelShared?.call(reel),
            onComment: () => widget.onReelCommented?.call(reel),
            onFollow: () => widget.onUserFollowed?.call(reel.user!),
            onBlock: () => widget.onUserBlocked?.call(reel.user!),
            onCompleted: () => widget.onVideoCompleted?.call(reel),
          ),
      ],
    );
  }
}

/// Extension methods for SnapReels
extension SnapReelsExtension on SnapReels {
  /// Create SnapReels from video URLs
  static SnapReels fromUrls(
    List<String> videoUrls, {
    ReelConfig config = const ReelConfig(),
    int initialIndex = 0,
    void Function(int index, ReelModel reel)? onPageChanged,
    void Function(ReelModel reel, Duration position)? onVideoTapped,
  }) {
    final reels = videoUrls.asMap().entries.map((entry) {
      return ReelModel(
        id: 'reel_${entry.key}_${DateTime.now().millisecondsSinceEpoch}',
        videoSource: VideoSource(url: entry.value),
      );
    }).toList();

    return SnapReels(
      reels: reels,
      config: config,
      initialIndex: initialIndex,
      onPageChanged: onPageChanged,
      onTap: onVideoTapped,
    );
  }
}
