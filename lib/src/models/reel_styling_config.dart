import 'package:flutter/material.dart';

import 'package:snap_reels/src/models/progress_config.dart';

/// Visual styling for the reel feed: colors, shimmer, caption and overlay
/// padding. Behavior settings live in `ReelActionsConfig` and other
/// sub-configs.
class ReelStylingConfig {
  /// Creates a [ReelStylingConfig].
  const ReelStylingConfig({
    this.backgroundColor = Colors.black,
    this.accentColor = Colors.red,
    this.textColor = Colors.white,
    this.progressColor = Colors.white,
    this.followButtonColor = Colors.white,
    this.followingButtonColor = Colors.white70,
    this.showShimmerWhileLoading = true,
    this.shimmerConfig,
    this.maxCaptionLines = 3,
    this.showHashtags = true,
    this.contentBottomPadding = 0.0,
  });

  /// Background color for the reels container.
  final Color backgroundColor;

  /// Primary accent color used for active states and emphasis.
  final Color accentColor;

  /// Default color for caption / username text.
  final Color textColor;

  /// Color of the played portion of the progress bar.
  final Color progressColor;

  /// Background color of the follow button in its idle state.
  final Color followButtonColor;

  /// Background color of the follow button once the user is following.
  final Color followingButtonColor;

  /// Whether to render a shimmer placeholder while the first frame loads.
  final bool showShimmerWhileLoading;

  /// Optional override for the shimmer animation.
  final ShimmerConfig? shimmerConfig;

  /// Maximum number of lines shown in the caption before truncation.
  final int maxCaptionLines;

  /// Whether hashtags are rendered as chips under the caption.
  final bool showHashtags;

  /// Bottom inset for the overlay content (user info, actions, progress
  /// bar). Use it to lift the content above a tab bar or similar UI.
  final double contentBottomPadding;

  /// Returns a copy with the provided fields replaced.
  ReelStylingConfig copyWith({
    Color? backgroundColor,
    Color? accentColor,
    Color? textColor,
    Color? progressColor,
    Color? followButtonColor,
    Color? followingButtonColor,
    bool? showShimmerWhileLoading,
    ShimmerConfig? shimmerConfig,
    int? maxCaptionLines,
    bool? showHashtags,
    double? contentBottomPadding,
  }) {
    return ReelStylingConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      accentColor: accentColor ?? this.accentColor,
      textColor: textColor ?? this.textColor,
      progressColor: progressColor ?? this.progressColor,
      followButtonColor: followButtonColor ?? this.followButtonColor,
      followingButtonColor: followingButtonColor ?? this.followingButtonColor,
      showShimmerWhileLoading:
          showShimmerWhileLoading ?? this.showShimmerWhileLoading,
      shimmerConfig: shimmerConfig ?? this.shimmerConfig,
      maxCaptionLines: maxCaptionLines ?? this.maxCaptionLines,
      showHashtags: showHashtags ?? this.showHashtags,
      contentBottomPadding: contentBottomPadding ?? this.contentBottomPadding,
    );
  }
}
