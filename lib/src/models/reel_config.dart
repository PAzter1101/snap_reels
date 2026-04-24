import 'package:dio/dio.dart';
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

  /// Optional pre-configured [Dio] used by [CacheManager] for thumbnail and
  /// video prefetch. Pass the host app's HTTP client (e.g. wired with
  /// `NativeAdapter` + `CronetEngine`) to share its connection pool, TLS
  /// session cache and interceptors. When null, [CacheManager] creates its
  /// own plain [Dio].
  final Dio? httpClient;

  /// Whether to enable analytics
  final bool enableAnalytics;

  /// Preload configuration
  final PreloadConfig preloadConfig;

  /// Error widget builder — inline error shown over the video area by
  /// [ReelVideoPlayer]. For the full-screen error dialog in the reel overlay
  /// use [errorDialogBuilder].
  final Widget Function(BuildContext context, String error)? errorWidgetBuilder;

  /// Loading widget builder — inline loading indicator shown over the video
  /// area by [ReelVideoPlayer]. For the overlay-level buffering indicator
  /// use [bufferingBuilder].
  final Widget Function(BuildContext context)? loadingWidgetBuilder;

  /// Custom builder for the full-screen error dialog shown by the reel
  /// overlay when video playback fails. Receives the [ReelModel] currently
  /// on screen, the raw error message and callbacks to retry playback or
  /// dismiss the error. When null, a default Material-style dialog is shown.
  final Widget Function(
    BuildContext context,
    ReelModel reel,
    String error,
    VoidCallback onRetry,
    VoidCallback onCancel,
  )? errorDialogBuilder;

  /// Custom builder for the buffering indicator shown by the reel overlay
  /// while the video is loading more data. When null, a default
  /// [CircularProgressIndicator] with "Buffering..." label is shown.
  final Widget Function(BuildContext context)? bufferingBuilder;

  /// Custom builder for the thumbnail fallback shown by [ReelVideoPlayer]
  /// when [ReelModel.thumbnailUrl] is null/empty or [Image.network] fails.
  /// Receives the reel so the host can render a content-specific placeholder
  /// (logo, gradient, initials, icon). When null, a solid black background
  /// is used.
  final Widget Function(BuildContext context, ReelModel reel)?
      thumbnailFallbackBuilder;

  /// Minimum size of the clickable area around each action button
  /// (comment, share, bookmark, download, more). The visual icon stays the
  /// size of [actionIconSize]; only the hit area is expanded via a transparent
  /// centered container. Default 44pt matches the pre-2.3.0 behaviour of
  /// `EdgeInsets.all(8)` around a 28pt icon; raise to 48+ for Apple HIG /
  /// Material accessibility compliance or larger-finger UX.
  final double actionMinTapTargetSize;

  /// Size of the icon inside non-like action buttons (visual only).
  final double actionIconSize;

  /// Size of the like button (`LikeButton.size`) and the heart icon inside.
  /// Since `LikeButton` does not support a separate hit-area, this value
  /// controls both visual and tap target for the like button.
  final double likeButtonSize;

  /// Vertical gap between adjacent action buttons in the column.
  final double actionSpacing;

  /// Minimum height of the clickable area around each hashtag chip in the
  /// caption. The visual text stays unchanged; only the hit area is expanded.
  /// Default `0` disables the expansion (hit area equals text size — matches
  /// pre-2.3.0 behaviour). Set to 40-48 for comfortable finger targets.
  final double hashtagMinTapTargetSize;

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

  /// Whether to show hashtags below the caption
  final bool showHashtags;

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
    this.httpClient,
    this.enableAnalytics = false,
    this.preloadConfig = const PreloadConfig(),
    this.errorWidgetBuilder,
    this.loadingWidgetBuilder,
    this.errorDialogBuilder,
    this.bufferingBuilder,
    this.thumbnailFallbackBuilder,
    this.actionMinTapTargetSize = 44,
    this.actionIconSize = 28,
    this.likeButtonSize = 32,
    this.actionSpacing = 16,
    this.hashtagMinTapTargetSize = 0,
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
    this.showHashtags = true,
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
    Dio? httpClient,
    bool? enableAnalytics,
    PreloadConfig? preloadConfig,
    Widget Function(BuildContext context, String error)? errorWidgetBuilder,
    Widget Function(BuildContext context)? loadingWidgetBuilder,
    Widget Function(
      BuildContext context,
      ReelModel reel,
      String error,
      VoidCallback onRetry,
      VoidCallback onCancel,
    )? errorDialogBuilder,
    Widget Function(BuildContext context)? bufferingBuilder,
    Widget Function(BuildContext context, ReelModel reel)?
        thumbnailFallbackBuilder,
    double? actionMinTapTargetSize,
    double? actionIconSize,
    double? likeButtonSize,
    double? actionSpacing,
    double? hashtagMinTapTargetSize,
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
    bool? showHashtags,
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
      httpClient: httpClient ?? this.httpClient,
      enableAnalytics: enableAnalytics ?? this.enableAnalytics,
      preloadConfig: preloadConfig ?? this.preloadConfig,
      errorWidgetBuilder: errorWidgetBuilder ?? this.errorWidgetBuilder,
      loadingWidgetBuilder: loadingWidgetBuilder ?? this.loadingWidgetBuilder,
      errorDialogBuilder: errorDialogBuilder ?? this.errorDialogBuilder,
      bufferingBuilder: bufferingBuilder ?? this.bufferingBuilder,
      thumbnailFallbackBuilder:
          thumbnailFallbackBuilder ?? this.thumbnailFallbackBuilder,
      actionMinTapTargetSize:
          actionMinTapTargetSize ?? this.actionMinTapTargetSize,
      actionIconSize: actionIconSize ?? this.actionIconSize,
      likeButtonSize: likeButtonSize ?? this.likeButtonSize,
      actionSpacing: actionSpacing ?? this.actionSpacing,
      hashtagMinTapTargetSize:
          hashtagMinTapTargetSize ?? this.hashtagMinTapTargetSize,
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
      showHashtags: showHashtags ?? this.showHashtags,
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
