import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:snap_reels/src/models/cache_config.dart';
import 'package:snap_reels/src/models/progress_config.dart';
import 'package:snap_reels/src/models/reel_actions_config.dart';
import 'package:snap_reels/src/models/reel_interaction_callbacks.dart';
import 'package:snap_reels/src/models/reel_overlay_builders_config.dart';
import 'package:snap_reels/src/models/reel_styling_config.dart';
import 'package:snap_reels/src/models/video_player_config.dart';

export 'cache_config.dart';
export 'progress_config.dart';
export 'reel_actions_config.dart';
export 'reel_interaction_callbacks.dart';
export 'reel_overlay_builders_config.dart';
export 'reel_styling_config.dart';
export 'streaming_config.dart';
export 'video_player_config.dart';

/// Main configuration for the `SnapReels` feed.
///
/// Grouped sub-configs (recommended):
///   - [styling] — colors, shimmer, caption layout
///   - [actions] — button visibility, sizes, more-menu labels
///   - [builders] — error/loading/buffering UI overrides
///   - [callbacks] — interaction side-effects
///
/// Top-level fields cover the player pool, pagination and other
/// feed-wide behavior.
class ReelConfig {
  /// Creates an immutable [ReelConfig].
  const ReelConfig({
    this.styling = const ReelStylingConfig(),
    this.actions = const ReelActionsConfig(),
    this.builders = const ReelOverlayBuildersConfig(),
    this.callbacks = const ReelInteractionCallbacks(),
    this.progressIndicatorConfig = const ProgressIndicatorConfig(),
    this.videoPlayerConfig = const VideoPlayerConfig(),
    this.preloadConfig = const PreloadConfig(),
    this.cacheConfig,
    this.httpClient,
    this.showProgressIndicator = true,
    this.showControlsOverlay = true,
    this.controlsAutoHideDuration = const Duration(seconds: 3),
    this.enableCaching = true,
    this.enableAnalytics = false,
    this.physics,
    this.pageController,
    this.enablePullToRefresh = false,
    this.onRefresh,
    this.enableInfiniteScroll = false,
    this.onLoadMore,
    this.loadMoreThreshold = 3,
    this.keepScreenAwake = true,
    this.autoPlay = true,
    this.loop = true,
    this.volume = 1.0,
    this.progressBarPadding = 20.0,
  });

  /// Visual styling: colors, shimmer, caption, content padding.
  final ReelStylingConfig styling;

  /// Action side-rail and more menu: visibility, sizes, labels.
  final ReelActionsConfig actions;

  /// Overrides for error / loading / buffering / thumbnail UI.
  final ReelOverlayBuildersConfig builders;

  /// Side-effect callbacks for taps, plays, seeks.
  final ReelInteractionCallbacks callbacks;

  /// Progress indicator styling.
  final ProgressIndicatorConfig progressIndicatorConfig;

  /// Video player styling and behavior.
  final VideoPlayerConfig videoPlayerConfig;

  /// How many adjacent reels to keep warm in the pool.
  final PreloadConfig preloadConfig;

  /// LRU disk cache config. When null, defaults are used.
  final CacheConfig? cacheConfig;

  /// Optional pre-configured [Dio] used by `CacheManager` for thumbnail
  /// and video prefetch. Pass the host app's HTTP client (e.g. wired
  /// with `NativeAdapter` + `CronetEngine`) to share its connection pool,
  /// TLS session cache and interceptors. When null, `CacheManager`
  /// creates its own plain [Dio].
  final Dio? httpClient;

  /// Whether to show the progress bar at the bottom of each reel.
  final bool showProgressIndicator;

  /// Whether to show the play/pause + bottom controls overlay.
  final bool showControlsOverlay;

  /// Auto-hide controls after this duration; `null` keeps them visible.
  final Duration? controlsAutoHideDuration;

  /// Whether the disk cache is enabled.
  final bool enableCaching;

  /// Whether analytics events are collected.
  final bool enableAnalytics;

  /// Scroll physics override for the PageView.
  final ScrollPhysics? physics;

  /// Externally owned PageController, or `null` to use the controller's
  /// internal one.
  final PageController? pageController;

  /// Whether to wrap the feed in a [RefreshIndicator].
  final bool enablePullToRefresh;

  /// Invoked by the [RefreshIndicator] when the user pulls down.
  final Future<void> Function()? onRefresh;

  /// Whether the feed can load more reels as the user scrolls.
  final bool enableInfiniteScroll;

  /// Returns the next page of reel ids. Called when the user is within
  /// [loadMoreThreshold] from the end.
  final Future<List<String>> Function()? onLoadMore;

  /// Distance from the end of the feed at which [onLoadMore] fires.
  final int loadMoreThreshold;

  /// Whether to keep the screen on while a video is playing.
  final bool keepScreenAwake;

  /// Whether videos should start playing automatically when they
  /// become active.
  final bool autoPlay;

  /// Whether playback should loop when the video finishes.
  final bool loop;

  /// Initial output volume in the range `[0, 1]`.
  final double volume;

  /// Horizontal padding around the progress bar in logical pixels.
  final double progressBarPadding;

  /// Returns a copy with the provided fields replaced.
  ReelConfig copyWith({
    ReelStylingConfig? styling,
    ReelActionsConfig? actions,
    ReelOverlayBuildersConfig? builders,
    ReelInteractionCallbacks? callbacks,
    ProgressIndicatorConfig? progressIndicatorConfig,
    VideoPlayerConfig? videoPlayerConfig,
    PreloadConfig? preloadConfig,
    CacheConfig? cacheConfig,
    Dio? httpClient,
    bool? showProgressIndicator,
    bool? showControlsOverlay,
    Duration? controlsAutoHideDuration,
    bool? enableCaching,
    bool? enableAnalytics,
    ScrollPhysics? physics,
    PageController? pageController,
    bool? enablePullToRefresh,
    Future<void> Function()? onRefresh,
    bool? enableInfiniteScroll,
    Future<List<String>> Function()? onLoadMore,
    int? loadMoreThreshold,
    bool? keepScreenAwake,
    bool? autoPlay,
    bool? loop,
    double? volume,
    double? progressBarPadding,
  }) {
    return ReelConfig(
      styling: styling ?? this.styling,
      actions: actions ?? this.actions,
      builders: builders ?? this.builders,
      callbacks: callbacks ?? this.callbacks,
      progressIndicatorConfig:
          progressIndicatorConfig ?? this.progressIndicatorConfig,
      videoPlayerConfig: videoPlayerConfig ?? this.videoPlayerConfig,
      preloadConfig: preloadConfig ?? this.preloadConfig,
      cacheConfig: cacheConfig ?? this.cacheConfig,
      httpClient: httpClient ?? this.httpClient,
      showProgressIndicator:
          showProgressIndicator ?? this.showProgressIndicator,
      showControlsOverlay: showControlsOverlay ?? this.showControlsOverlay,
      controlsAutoHideDuration:
          controlsAutoHideDuration ?? this.controlsAutoHideDuration,
      enableCaching: enableCaching ?? this.enableCaching,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      physics: physics ?? this.physics,
      pageController: pageController ?? this.pageController,
      enablePullToRefresh: enablePullToRefresh ?? this.enablePullToRefresh,
      onRefresh: onRefresh ?? this.onRefresh,
      enableInfiniteScroll: enableInfiniteScroll ?? this.enableInfiniteScroll,
      onLoadMore: onLoadMore ?? this.onLoadMore,
      loadMoreThreshold: loadMoreThreshold ?? this.loadMoreThreshold,
      keepScreenAwake: keepScreenAwake ?? this.keepScreenAwake,
      autoPlay: autoPlay ?? this.autoPlay,
      loop: loop ?? this.loop,
      volume: volume ?? this.volume,
      progressBarPadding: progressBarPadding ?? this.progressBarPadding,
    );
  }
}
