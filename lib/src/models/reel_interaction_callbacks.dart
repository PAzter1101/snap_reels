import 'package:flutter/foundation.dart';

import 'package:snap_reels/src/models/reel_model.dart';

/// Side-effect callbacks invoked from the overlay actions and the player.
class ReelInteractionCallbacks {
  /// Creates a [ReelInteractionCallbacks].
  const ReelInteractionCallbacks({
    this.onCommentTap,
    this.onShareTap,
    this.onDownloadTap,
    this.onHashtagTap,
    this.onReportTap,
    this.onBlockTap,
    this.onCopyLinkTap,
    this.onPlay,
    this.onPause,
    this.onSeek,
  });

  /// Invoked when the comment action is tapped. Overrides default sheet.
  final void Function(ReelModel)? onCommentTap;

  /// Invoked when the share action is tapped.
  final void Function(ReelModel)? onShareTap;

  /// Invoked when the download action is tapped.
  final void Function(ReelModel)? onDownloadTap;

  /// Invoked when a hashtag chip is tapped. Receives the tag without
  /// the leading `#`.
  final void Function(String)? onHashtagTap;

  /// Invoked when the "report" entry in the more menu is tapped.
  final void Function(ReelModel)? onReportTap;

  /// Invoked when the "block" entry in the more menu is tapped.
  final void Function(ReelModel)? onBlockTap;

  /// Invoked when the "copy link" entry in the more menu is tapped.
  final void Function(ReelModel)? onCopyLinkTap;

  /// Invoked when playback starts.
  final VoidCallback? onPlay;

  /// Invoked when playback pauses.
  final VoidCallback? onPause;

  /// Invoked when the user seeks. Receives the new playback position.
  final void Function(Duration)? onSeek;

  /// Returns a copy with the provided fields replaced.
  ReelInteractionCallbacks copyWith({
    void Function(ReelModel)? onCommentTap,
    void Function(ReelModel)? onShareTap,
    void Function(ReelModel)? onDownloadTap,
    void Function(String)? onHashtagTap,
    void Function(ReelModel)? onReportTap,
    void Function(ReelModel)? onBlockTap,
    void Function(ReelModel)? onCopyLinkTap,
    VoidCallback? onPlay,
    VoidCallback? onPause,
    void Function(Duration)? onSeek,
  }) {
    return ReelInteractionCallbacks(
      onCommentTap: onCommentTap ?? this.onCommentTap,
      onShareTap: onShareTap ?? this.onShareTap,
      onDownloadTap: onDownloadTap ?? this.onDownloadTap,
      onHashtagTap: onHashtagTap ?? this.onHashtagTap,
      onReportTap: onReportTap ?? this.onReportTap,
      onBlockTap: onBlockTap ?? this.onBlockTap,
      onCopyLinkTap: onCopyLinkTap ?? this.onCopyLinkTap,
      onPlay: onPlay ?? this.onPlay,
      onPause: onPause ?? this.onPause,
      onSeek: onSeek ?? this.onSeek,
    );
  }
}
