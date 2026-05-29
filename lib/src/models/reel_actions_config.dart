import 'package:flutter/widgets.dart';

import 'package:snap_reels/src/models/reel_model.dart';

/// Custom action for the more menu.
class CustomAction {
  /// Creates a custom action item rendered in the "more" menu.
  const CustomAction({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  /// Icon displayed next to [title].
  final IconData icon;

  /// Label shown in the menu row.
  final String title;

  /// Invoked when the user taps the action. Receives the active reel.
  final void Function(ReelModel) onTap;
}

/// Visibility, styling and labels for the action side-rail and more menu.
class ReelActionsConfig {
  /// Creates a [ReelActionsConfig].
  const ReelActionsConfig({
    this.showFollowButton = true,
    this.showBookmarkButton = true,
    this.showDownloadButton = true,
    this.showMoreButton = true,
    this.showCommentButton = true,
    this.showBottomControls = false,
    this.bookmarkInMoreMenu = true,
    this.downloadInMoreMenu = true,
    this.actionMinTapTargetSize = 44,
    this.actionIconSize = 28,
    this.likeButtonSize = 32,
    this.actionSpacing = 16,
    this.hashtagMinTapTargetSize = 0,
    this.customActions = const [],
    this.reportLabel = 'Report',
    this.blockLabel = 'Block',
    this.copyLinkLabel = 'Copy link',
  });

  /// Whether to render the "follow" button in the overlay.
  final bool showFollowButton;

  /// Whether to render the bookmark action.
  final bool showBookmarkButton;

  /// Whether to render the download action.
  final bool showDownloadButton;

  /// Whether to render the "more options" action.
  final bool showMoreButton;

  /// Whether to render the comment action.
  final bool showCommentButton;

  /// Whether to render the bottom controls row (play/pause, time).
  final bool showBottomControls;

  /// If `true`, the bookmark action is moved from the side rail
  /// into the more menu.
  final bool bookmarkInMoreMenu;

  /// If `true`, the download action is moved from the side rail
  /// into the more menu.
  final bool downloadInMoreMenu;

  /// Minimum tappable size of action buttons in logical pixels.
  final double actionMinTapTargetSize;

  /// Icon size of action buttons in logical pixels.
  final double actionIconSize;

  /// Size of the like button in logical pixels.
  final double likeButtonSize;

  /// Vertical spacing between action buttons.
  final double actionSpacing;

  /// Minimum tappable size of hashtag chips. `0` keeps the hit area
  /// equal to the rendered text.
  final double hashtagMinTapTargetSize;

  /// Extra entries appended to the more menu.
  final List<CustomAction> customActions;

  /// Localized label for the "report" entry in the more menu.
  final String reportLabel;

  /// Localized label for the "block" entry in the more menu.
  final String blockLabel;

  /// Localized label for the "copy link" entry in the more menu.
  final String copyLinkLabel;

  /// Returns a copy with the provided fields replaced.
  ReelActionsConfig copyWith({
    bool? showFollowButton,
    bool? showBookmarkButton,
    bool? showDownloadButton,
    bool? showMoreButton,
    bool? showCommentButton,
    bool? showBottomControls,
    bool? bookmarkInMoreMenu,
    bool? downloadInMoreMenu,
    double? actionMinTapTargetSize,
    double? actionIconSize,
    double? likeButtonSize,
    double? actionSpacing,
    double? hashtagMinTapTargetSize,
    List<CustomAction>? customActions,
    String? reportLabel,
    String? blockLabel,
    String? copyLinkLabel,
  }) {
    return ReelActionsConfig(
      showFollowButton: showFollowButton ?? this.showFollowButton,
      showBookmarkButton: showBookmarkButton ?? this.showBookmarkButton,
      showDownloadButton: showDownloadButton ?? this.showDownloadButton,
      showMoreButton: showMoreButton ?? this.showMoreButton,
      showCommentButton: showCommentButton ?? this.showCommentButton,
      showBottomControls: showBottomControls ?? this.showBottomControls,
      bookmarkInMoreMenu: bookmarkInMoreMenu ?? this.bookmarkInMoreMenu,
      downloadInMoreMenu: downloadInMoreMenu ?? this.downloadInMoreMenu,
      actionMinTapTargetSize:
          actionMinTapTargetSize ?? this.actionMinTapTargetSize,
      actionIconSize: actionIconSize ?? this.actionIconSize,
      likeButtonSize: likeButtonSize ?? this.likeButtonSize,
      actionSpacing: actionSpacing ?? this.actionSpacing,
      hashtagMinTapTargetSize:
          hashtagMinTapTargetSize ?? this.hashtagMinTapTargetSize,
      customActions: customActions ?? this.customActions,
      reportLabel: reportLabel ?? this.reportLabel,
      blockLabel: blockLabel ?? this.blockLabel,
      copyLinkLabel: copyLinkLabel ?? this.copyLinkLabel,
    );
  }
}
