import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:like_button/like_button.dart';

import 'package:snap_reels/src/controllers/reel_controller.dart';
import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';
import 'package:snap_reels/src/utils/reel_utils.dart';
import 'package:snap_reels/src/widgets/floating_heart_overlay.dart';
import 'package:snap_reels/src/widgets/reel_action_button.dart';
import 'package:snap_reels/src/widgets/reel_comments_sheet.dart';
import 'package:snap_reels/src/widgets/reel_more_options_sheet.dart';
import 'package:snap_reels/src/widgets/reel_music_avatar.dart';

/// Right-side action stack: like, comment, share, etc.
class ReelActions extends StatelessWidget {
  /// Creates the action stack bound to [reel] and [config].
  const ReelActions({
    required this.reel,
    required this.config,
    super.key,
    this.onLike,
    this.onShare,
    this.onComment,
    this.onFollow,
    this.onBlock,
  });

  /// Reel whose counters and like-state are reflected by the buttons.
  final ReelModel reel;

  /// Styling and behavior configuration.
  final ReelConfig config;

  /// Invoked when the like button is tapped.
  final VoidCallback? onLike;

  /// Invoked when the share button is tapped.
  final VoidCallback? onShare;

  /// Invoked when the comment button is tapped.
  final VoidCallback? onComment;

  /// Invoked when the follow button is tapped.
  final VoidCallback? onFollow;

  /// Invoked when the block entry in the more menu is tapped.
  final VoidCallback? onBlock;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReelController>();
    final actions = config.actions;
    final styling = config.styling;
    final spacing = SizedBox(height: actions.actionSpacing);

    final bookmarkOutsideMenu =
        actions.showBookmarkButton && !actions.bookmarkInMoreMenu;
    final downloadOutsideMenu =
        actions.showDownloadButton && !actions.downloadInMoreMenu;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LikeButton(
          isLiked: reel.isLiked,
          likeCount: reel.likesCount,
          size: actions.likeButtonSize,
          countPostion: CountPostion.bottom,
          likeCountAnimationType: LikeCountAnimationType.none,
          likeBuilder: (isLiked) => Icon(
            IconlyLight.heart,
            color: isLiked ? Colors.red : styling.textColor,
            size: actions.likeButtonSize,
          ),
          countBuilder: (count, isLiked, text) {
            if (count == null || count == 0) return const SizedBox.shrink();
            return Text(
              ReelUtils.formatCount(count),
              style: TextStyle(
                color: styling.textColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            );
          },
          onTap: (isLiked) async {
            _handleLike(context);
            return !isLiked;
          },
        ),
        spacing,
        if (actions.showCommentButton) ...[
          ReelActionButton(
            icon: IconlyLight.chat,
            iconColor: styling.textColor,
            actions: actions,
            count: reel.commentsCount,
            onTap: () => _handleComment(context, controller),
          ),
          const SizedBox(height: 16),
        ],
        ReelActionButton(
          icon: IconlyLight.send,
          iconColor: styling.textColor,
          actions: actions,
          count: reel.sharesCount,
          onTap: () => _handleShare(context),
        ),
        spacing,
        if (bookmarkOutsideMenu) ...[
          ReelActionButton(
            icon: reel.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            iconColor: reel.isBookmarked
                ? styling.accentColor
                : styling.textColor,
            actions: actions,
            onTap: () => _handleBookmark(context),
          ),
          spacing,
        ],
        if (downloadOutsideMenu) ...[
          ReelActionButton(
            icon: Icons.download,
            iconColor: styling.textColor,
            actions: actions,
            onTap: () => _handleDownload(context),
          ),
          spacing,
        ],
        if (actions.showMoreButton) ...[
          ReelActionButton(
            icon: Icons.more_vert,
            iconColor: styling.textColor,
            actions: actions,
            onTap: () => _showMoreOptions(context, controller),
          ),
          const SizedBox(height: 16),
        ],
        if (reel.musicTitle != null)
          ReelMusicAvatar(
            accentColor: styling.accentColor,
            iconColor: styling.textColor,
          ),
      ],
    );
  }

  void _handleLike(BuildContext context) {
    if (!reel.isLiked) FloatingHeartOverlay.show(context);
    onLike?.call();
  }

  void _handleComment(BuildContext context, ReelController controller) {
    final custom = config.callbacks.onCommentTap;
    if (custom != null) {
      custom(reel);
    } else {
      unawaited(
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => ReelCommentsSheet(reel: reel, config: config),
        ),
      );
    }
    onComment?.call();
  }

  void _handleShare(BuildContext context) {
    final custom = config.callbacks.onShareTap;
    if (custom != null) {
      custom(reel);
    } else {
      debugPrint('Sharing reel: ${reel.videoSource.url}');
    }
    onShare?.call();
  }

  void _handleBookmark(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          reel.isBookmarked ? 'Removed from bookmarks' : 'Added to bookmarks',
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: config.styling.accentColor,
      ),
    );
  }

  void _handleDownload(BuildContext context) {
    final custom = config.callbacks.onDownloadTap;
    if (custom != null) {
      custom(reel);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Download started...'),
        duration: const Duration(seconds: 2),
        backgroundColor: config.styling.accentColor,
      ),
    );
  }

  void _showMoreOptions(BuildContext context, ReelController controller) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (_) => ReelMoreOptionsSheet(
          reel: reel,
          config: config,
          onBookmark: () => _handleBookmark(context),
          onDownload: () => _handleDownload(context),
          onReport: () => _handleReport(context),
          onBlock: () => _handleBlock(context),
          onCopyLink: () => _handleCopyLink(context),
        ),
      ),
    );
  }

  void _handleReport(BuildContext context) {
    final custom = config.callbacks.onReportTap;
    if (custom != null) {
      custom(reel);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Content reported'),
        backgroundColor: config.styling.accentColor,
      ),
    );
  }

  void _handleBlock(BuildContext context) {
    final custom = config.callbacks.onBlockTap;
    if (custom != null) {
      custom(reel);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('User blocked'),
          backgroundColor: config.styling.accentColor,
        ),
      );
    }
    onBlock?.call();
  }

  void _handleCopyLink(BuildContext context) {
    final custom = config.callbacks.onCopyLinkTap;
    if (custom != null) {
      custom(reel);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Link copied to clipboard'),
        backgroundColor: config.styling.accentColor,
      ),
    );
  }
}
