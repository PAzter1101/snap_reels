import 'package:flutter/widgets.dart';

import 'package:snap_reels/src/models/reel_model.dart';

/// Customization hooks for inline and overlay-level UI rendered by the
/// reel widgets (errors, loading, buffering, thumbnails).
class ReelOverlayBuildersConfig {
  /// Creates a [ReelOverlayBuildersConfig].
  const ReelOverlayBuildersConfig({
    this.errorWidgetBuilder,
    this.loadingWidgetBuilder,
    this.errorDialogBuilder,
    this.bufferingBuilder,
    this.thumbnailFallbackBuilder,
    this.thumbnailProxyUrlBuilder,
    this.thumbnailLoadTimeout = const Duration(seconds: 3),
  });

  /// Inline error shown over the video area when playback fails.
  /// For the full-screen error dialog use [errorDialogBuilder].
  final Widget Function(BuildContext context, String error)? errorWidgetBuilder;

  /// Inline loading indicator shown over the video area while the first
  /// frame is decoded. For the overlay-level buffering indicator use
  /// [bufferingBuilder].
  final Widget Function(BuildContext context)? loadingWidgetBuilder;

  /// Full-screen error dialog shown by the reel overlay on playback
  /// failure. Receives the current reel, error message and callbacks
  /// to retry or dismiss.
  final Widget Function(
    BuildContext context,
    ReelModel reel,
    String error,
    VoidCallback onRetry,
    VoidCallback onCancel,
  )?
  errorDialogBuilder;

  /// Buffering indicator shown by the reel overlay while libmpv is
  /// fetching more data.
  final Widget Function(BuildContext context)? bufferingBuilder;

  /// Thumbnail fallback shown when `ReelModel.thumbnailUrl` is null or
  /// fails to decode.
  final Widget Function(BuildContext context, ReelModel reel)?
  thumbnailFallbackBuilder;

  /// Returns a fallback thumbnail URL to retry with when the primary URL
  /// fails or stalls past [thumbnailLoadTimeout]. `null` keeps the
  /// original URL.
  final String? Function(ReelModel reel)? thumbnailProxyUrlBuilder;

  /// Time to wait for the first frame of the primary thumbnail before
  /// switching to [thumbnailProxyUrlBuilder]. No effect when the builder
  /// is null.
  final Duration thumbnailLoadTimeout;

  /// Returns a copy with the provided fields replaced.
  ReelOverlayBuildersConfig copyWith({
    Widget Function(BuildContext context, String error)? errorWidgetBuilder,
    Widget Function(BuildContext context)? loadingWidgetBuilder,
    Widget Function(
      BuildContext context,
      ReelModel reel,
      String error,
      VoidCallback onRetry,
      VoidCallback onCancel,
    )?
    errorDialogBuilder,
    Widget Function(BuildContext context)? bufferingBuilder,
    Widget Function(BuildContext context, ReelModel reel)?
    thumbnailFallbackBuilder,
    String? Function(ReelModel reel)? thumbnailProxyUrlBuilder,
    Duration? thumbnailLoadTimeout,
  }) {
    return ReelOverlayBuildersConfig(
      errorWidgetBuilder: errorWidgetBuilder ?? this.errorWidgetBuilder,
      loadingWidgetBuilder: loadingWidgetBuilder ?? this.loadingWidgetBuilder,
      errorDialogBuilder: errorDialogBuilder ?? this.errorDialogBuilder,
      bufferingBuilder: bufferingBuilder ?? this.bufferingBuilder,
      thumbnailFallbackBuilder:
          thumbnailFallbackBuilder ?? this.thumbnailFallbackBuilder,
      thumbnailProxyUrlBuilder:
          thumbnailProxyUrlBuilder ?? this.thumbnailProxyUrlBuilder,
      thumbnailLoadTimeout: thumbnailLoadTimeout ?? this.thumbnailLoadTimeout,
    );
  }
}
