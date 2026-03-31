import 'package:flutter/material.dart';
import 'reel_model.dart';
import 'cache_config.dart';
import 'progress_config.dart';
import 'video_player_config.dart';

export 'cache_config.dart';
export 'progress_config.dart';
export 'streaming_config.dart';
export 'video_player_config.dart';

/// Custom action for the more menu
class CustomAction {
  final IconData icon;
  final String title;
  final void Function(ReelModel) onTap;

  const CustomAction({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

/// Main configuration class for reels
class ReelConfig {
  /// Background color for the reels container
  final Color backgroundColor;

  /// Whether to show the progress indicator
  final bool showProgressIndicator;

  /// Progress indicator configuration
  final ProgressIndicatorConfig progressIndicatorConfig;

  /// Whether to show video controls overlay
  final bool showControlsOverlay;

  /// Auto-hide controls after this duration (null means never hide)
  final Duration? controlsAutoHideDuration;

  /// Whether to enable caching
  final bool enableCaching;

  /// Cache configuration
  final CacheConfig? cacheConfig;

  /// Whether to enable analytics
  final bool enableAnalytics;

  /// Preload configuration
  final PreloadConfig preloadConfig;

  /// Error widget builder
  final Widget Function(BuildContext context, String error)? errorWidgetBuilder;

  /// Loading widget builder
  final Widget Function(BuildContext context)? loadingWidgetBuilder;

  /// Whether to show shimmer effect while loading
  final bool showShimmerWhileLoading;

  /// Custom shimmer configuration
  final ShimmerConfig? shimmerConfig;

  /// Physics for the PageView
  final ScrollPhysics? physics;

  /// Page controller for the reels
  final PageController? pageController;

  /// Whether to enable pull to refresh
  final bool enablePullToRefresh;

  /// Pull to refresh callback
  final Future<void> Function()? onRefresh;

  /// Whether to enable infinite scroll
  final bool enableInfiniteScroll;

  /// Infinite scroll callback (load more reels)
  final Future<List<String>> Function()? onLoadMore;

  /// Threshold for triggering load more (from the end)
  final int loadMoreThreshold;

  /// Whether to keep screen awake while playing videos
  final bool keepScreenAwake;

  /// Video player configuration
  final VideoPlayerConfig videoPlayerConfig;

  /// UI Colors and styling
  final Color accentColor;
  final Color textColor;
  final Color progressColor;

  /// Action buttons configuration
  final bool showFollowButton;
  final bool showBookmarkButton;
  final bool showDownloadButton;
  final bool showMoreButton;
  final bool showCommentButton;
  final bool showBottomControls;

  /// Button organization - move to more menu
  final bool bookmarkInMoreMenu;
  final bool downloadInMoreMenu;

  /// Follow button styling
  final Color followButtonColor;
  final Color followingButtonColor;

  /// Caption configuration
  final int maxCaptionLines;

  /// Custom actions for more menu
  final List<CustomAction> customActions;

  /// Callback functions
  final void Function(ReelModel)? onCommentTap;
  final void Function(ReelModel)? onShareTap;
  final void Function(ReelModel)? onDownloadTap;
  final void Function(String)? onHashtagTap;
  final void Function(ReelModel)? onReportTap;
  final void Function(ReelModel)? onBlockTap;
  final void Function(ReelModel)? onCopyLinkTap;

  /// Labels for more menu items (override to localize)
  final String reportLabel;
  final String blockLabel;
  final String copyLinkLabel;

  /// New fields
  final int? preloadRange;
  final bool autoPlay;
  final bool loop;
  final double volume;
  final VoidCallback? onPlay;
  final VoidCallback? onPause;
  final Function(Duration)? onSeek;
  final double progressBarPadding;

  /// Отступ снизу для всего контента overlay (user info, actions, progress bar).
  /// Используйте для поднятия контента над tab bar или другими элементами UI.
  final double contentBottomPadding;

  const ReelConfig({
    this.backgroundColor = Colors.black,
    this.showProgressIndicator = true,
    this.progressIndicatorConfig = const ProgressIndicatorConfig(),
    this.showControlsOverlay = true,
    this.controlsAutoHideDuration = const Duration(seconds: 3),
    this.enableCaching = true,
    this.cacheConfig,
    this.enableAnalytics = false,
    this.preloadConfig = const PreloadConfig(),
    this.errorWidgetBuilder,
    this.loadingWidgetBuilder,
    this.showShimmerWhileLoading = true,
    this.shimmerConfig,
    this.physics,
    this.pageController,
    this.enablePullToRefresh = false,
    this.onRefresh,
    this.enableInfiniteScroll = false,
    this.onLoadMore,
    this.loadMoreThreshold = 3,
    this.keepScreenAwake = true,
    this.videoPlayerConfig = const VideoPlayerConfig(),
    this.accentColor = Colors.red,
    this.textColor = Colors.white,
    this.progressColor = Colors.white,
    this.showFollowButton = true,
    this.showBookmarkButton = true,
    this.showDownloadButton = true,
    this.showMoreButton = true,
    this.showCommentButton = true,
    this.showBottomControls = false,
    this.bookmarkInMoreMenu = true,
    this.downloadInMoreMenu = true,
    this.followButtonColor = Colors.white,
    this.followingButtonColor = Colors.white70,
    this.maxCaptionLines = 3,
    this.customActions = const [],
    this.onCommentTap,
    this.onShareTap,
    this.onDownloadTap,
    this.onHashtagTap,
    this.onReportTap,
    this.onBlockTap,
    this.onCopyLinkTap,
    this.reportLabel = 'Report',
    this.blockLabel = 'Block',
    this.copyLinkLabel = 'Copy link',
    this.preloadRange = 1,
    this.autoPlay = true,
    this.loop = true,
    this.volume = 1.0,
    this.onPlay,
    this.onPause,
    this.onSeek,
    this.progressBarPadding = 20.0,
    this.contentBottomPadding = 0.0,
  });

  ReelConfig copyWith({
    Color? backgroundColor,
    bool? showProgressIndicator,
    ProgressIndicatorConfig? progressIndicatorConfig,
    bool? showControlsOverlay,
    Duration? controlsAutoHideDuration,
    bool? enableCaching,
    CacheConfig? cacheConfig,
    bool? enableAnalytics,
    PreloadConfig? preloadConfig,
    Widget Function(BuildContext context, String error)? errorWidgetBuilder,
    Widget Function(BuildContext context)? loadingWidgetBuilder,
    bool? showShimmerWhileLoading,
    ShimmerConfig? shimmerConfig,
    ScrollPhysics? physics,
    PageController? pageController,
    bool? enablePullToRefresh,
    Future<void> Function()? onRefresh,
    bool? enableInfiniteScroll,
    Future<List<String>> Function()? onLoadMore,
    int? loadMoreThreshold,
    bool? keepScreenAwake,
    VideoPlayerConfig? videoPlayerConfig,
    Color? accentColor,
    Color? textColor,
    Color? progressColor,
    bool? showFollowButton,
    bool? showBookmarkButton,
    bool? showDownloadButton,
    bool? showMoreButton,
    bool? showCommentButton,
    bool? showBottomControls,
    bool? bookmarkInMoreMenu,
    bool? downloadInMoreMenu,
    Color? followButtonColor,
    Color? followingButtonColor,
    int? maxCaptionLines,
    List<CustomAction>? customActions,
    void Function(ReelModel)? onCommentTap,
    void Function(ReelModel)? onShareTap,
    void Function(ReelModel)? onDownloadTap,
    void Function(String)? onHashtagTap,
    void Function(ReelModel)? onReportTap,
    void Function(ReelModel)? onBlockTap,
    void Function(ReelModel)? onCopyLinkTap,
    String? reportLabel,
    String? blockLabel,
    String? copyLinkLabel,
    int? preloadRange,
    bool? autoPlay,
    bool? loop,
    double? volume,
    VoidCallback? onPlay,
    VoidCallback? onPause,
    Function(Duration)? onSeek,
    double? progressBarPadding,
    double? contentBottomPadding,
  }) {
    return ReelConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      showProgressIndicator:
          showProgressIndicator ?? this.showProgressIndicator,
      progressIndicatorConfig:
          progressIndicatorConfig ?? this.progressIndicatorConfig,
      showControlsOverlay: showControlsOverlay ?? this.showControlsOverlay,
      controlsAutoHideDuration:
          controlsAutoHideDuration ?? this.controlsAutoHideDuration,
      enableCaching: enableCaching ?? this.enableCaching,
      cacheConfig: cacheConfig ?? this.cacheConfig,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      preloadConfig: preloadConfig ?? this.preloadConfig,
      errorWidgetBuilder: errorWidgetBuilder ?? this.errorWidgetBuilder,
      loadingWidgetBuilder: loadingWidgetBuilder ?? this.loadingWidgetBuilder,
      showShimmerWhileLoading:
          showShimmerWhileLoading ?? this.showShimmerWhileLoading,
      shimmerConfig: shimmerConfig ?? this.shimmerConfig,
      physics: physics ?? this.physics,
      pageController: pageController ?? this.pageController,
      enablePullToRefresh: enablePullToRefresh ?? this.enablePullToRefresh,
      onRefresh: onRefresh ?? this.onRefresh,
      enableInfiniteScroll: enableInfiniteScroll ?? this.enableInfiniteScroll,
      onLoadMore: onLoadMore ?? this.onLoadMore,
      loadMoreThreshold: loadMoreThreshold ?? this.loadMoreThreshold,
      keepScreenAwake: keepScreenAwake ?? this.keepScreenAwake,
      videoPlayerConfig: videoPlayerConfig ?? this.videoPlayerConfig,
      accentColor: accentColor ?? this.accentColor,
      textColor: textColor ?? this.textColor,
      progressColor: progressColor ?? this.progressColor,
      showFollowButton: showFollowButton ?? this.showFollowButton,
      showBookmarkButton: showBookmarkButton ?? this.showBookmarkButton,
      showDownloadButton: showDownloadButton ?? this.showDownloadButton,
      showMoreButton: showMoreButton ?? this.showMoreButton,
      showCommentButton: showCommentButton ?? this.showCommentButton,
      showBottomControls: showBottomControls ?? this.showBottomControls,
      bookmarkInMoreMenu: bookmarkInMoreMenu ?? this.bookmarkInMoreMenu,
      downloadInMoreMenu: downloadInMoreMenu ?? this.downloadInMoreMenu,
      followButtonColor: followButtonColor ?? this.followButtonColor,
      followingButtonColor: followingButtonColor ?? this.followingButtonColor,
      maxCaptionLines: maxCaptionLines ?? this.maxCaptionLines,
      customActions: customActions ?? this.customActions,
      onCommentTap: onCommentTap ?? this.onCommentTap,
      onShareTap: onShareTap ?? this.onShareTap,
      onDownloadTap: onDownloadTap ?? this.onDownloadTap,
      onHashtagTap: onHashtagTap ?? this.onHashtagTap,
      onReportTap: onReportTap ?? this.onReportTap,
      onBlockTap: onBlockTap ?? this.onBlockTap,
      onCopyLinkTap: onCopyLinkTap ?? this.onCopyLinkTap,
      reportLabel: reportLabel ?? this.reportLabel,
      blockLabel: blockLabel ?? this.blockLabel,
      copyLinkLabel: copyLinkLabel ?? this.copyLinkLabel,
      preloadRange: preloadRange ?? this.preloadRange,
      autoPlay: autoPlay ?? this.autoPlay,
      loop: loop ?? this.loop,
      volume: volume ?? this.volume,
      onPlay: onPlay ?? this.onPlay,
      onPause: onPause ?? this.onPause,
      onSeek: onSeek ?? this.onSeek,
      progressBarPadding: progressBarPadding ?? this.progressBarPadding,
      contentBottomPadding: contentBottomPadding ?? this.contentBottomPadding,
    );
  }
}
