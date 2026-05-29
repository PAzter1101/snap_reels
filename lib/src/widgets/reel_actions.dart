import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:like_button/like_button.dart';

import 'package:snap_reels/src/controllers/reel_controller.dart';
import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';
import 'package:snap_reels/src/utils/reel_utils.dart';

/// Right-side action stack: like, comment, share, etc.
class ReelActions extends StatefulWidget {
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
  State<ReelActions> createState() => _ReelActionsState();
}

class _ReelActionsState extends State<ReelActions>
    with TickerProviderStateMixin {
  late AnimationController _pulseAnimationController;
  late Animation<double> _pulseAnimation;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _pulseAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseAnimation =
        Tween<double>(
          begin: 1,
          end: 1.1,
        ).animate(
          CurvedAnimation(
            parent: _pulseAnimationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _isDisposed = true;
    _pulseAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReelController>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Like button using LikeButton package
        LikeButton(
          isLiked: widget.reel.isLiked,
          likeCount: widget.reel.likesCount,
          size: widget.config.likeButtonSize,
          countPostion: CountPostion.bottom,
          likeCountAnimationType: LikeCountAnimationType.none,
          likeBuilder: (isLiked) {
            return Icon(
              IconlyLight.heart,
              color: isLiked ? Colors.red : widget.config.textColor,
              size: widget.config.likeButtonSize,
            );
          },
          countBuilder: (count, isLiked, text) {
            if (count == null || count == 0) return const SizedBox.shrink();
            return Text(
              ReelUtils.formatCount(count),
              style: TextStyle(
                color: widget.config.textColor,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            );
          },
          onTap: (isLiked) async {
            _handleLike(controller);
            return !isLiked;
          },
        ),
        SizedBox(height: widget.config.actionSpacing),
        // Comment button (only show if enabled)
        if (widget.config.showCommentButton)
          _buildActionButton(
            icon: IconlyLight.chat,
            iconColor: widget.config.textColor,
            count: widget.reel.commentsCount,
            onTap: () => _handleComment(controller),
          ),
        if (widget.config.showCommentButton) const SizedBox(height: 16),
        // Share button
        _buildActionButton(
          icon: IconlyLight.send,
          iconColor: widget.config.textColor,
          count: widget.reel.sharesCount,
          onTap: () => _handleShare(controller),
        ),
        SizedBox(height: widget.config.actionSpacing),
        // Bookmark button (only show if not in more menu)
        if (widget.config.showBookmarkButton &&
            !widget.config.bookmarkInMoreMenu)
          _buildActionButton(
            icon: widget.reel.isBookmarked
                ? Icons.bookmark
                : Icons.bookmark_border,
            iconColor: widget.reel.isBookmarked
                ? widget.config.accentColor
                : widget.config.textColor,
            onTap: () => _handleBookmark(controller),
          ),
        if (widget.config.showBookmarkButton &&
            !widget.config.bookmarkInMoreMenu)
          SizedBox(height: widget.config.actionSpacing),
        // Download button (only show if not in more menu)
        if (widget.config.showDownloadButton &&
            !widget.config.downloadInMoreMenu)
          _buildActionButton(
            icon: Icons.download,
            iconColor: widget.config.textColor,
            onTap: () => _handleDownload(controller),
          ),
        if (widget.config.showDownloadButton &&
            !widget.config.downloadInMoreMenu)
          SizedBox(height: widget.config.actionSpacing),
        // More options button
        if (widget.config.showMoreButton)
          _buildActionButton(
            icon: Icons.more_vert,
            iconColor: widget.config.textColor,
            onTap: () => _showMoreOptions(context, controller),
          ),
        if (widget.config.showMoreButton) const SizedBox(height: 16),
        // Creator avatar (spinning music note style)
        if (widget.reel.musicTitle != null) _buildMusicAvatar(),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
    int? count,
    Animation<double>? animation,
  }) {
    Widget iconWidget = Icon(
      icon,
      color: iconColor,
      size: widget.config.actionIconSize,
    );

    if (animation != null && !_isDisposed) {
      iconWidget = Transform.scale(
        scale: animation.value,
        child: iconWidget,
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minWidth: widget.config.actionMinTapTargetSize,
          minHeight: widget.config.actionMinTapTargetSize,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,
            if (count != null && count > 0) ...[
              const SizedBox(height: 0),
              Text(
                ReelUtils.formatCount(count),
                style: TextStyle(
                  color: widget.config.textColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMusicAvatar() {
    return AnimatedBuilder(
      animation: _pulseAnimationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _pulseAnimationController.value * 2 * 3.14159,
          child: Transform.scale(
            scale: _pulseAnimation.value,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    widget.config.accentColor,
                    widget.config.accentColor.withAlpha(128),
                  ],
                ),
                border: Border.all(
                  color: widget.config.textColor,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.music_note,
                color: widget.config.textColor,
                size: 20,
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleLike(ReelController controller) {
    if (!widget.reel.isLiked && mounted) {
      _showFloatingHeart();
    }
    widget.onLike?.call();
  }

  void _handleComment(ReelController controller) {
    if (widget.config.onCommentTap != null) {
      widget.config.onCommentTap!(widget.reel);
    } else {
      unawaited(_showCommentsBottomSheet(context, controller));
    }
    widget.onComment?.call();
  }

  void _handleShare(ReelController controller) {
    if (widget.config.onShareTap != null) {
      widget.config.onShareTap!(widget.reel);
    } else {
      debugPrint('Sharing reel: ${widget.reel.videoSource.url}');
    }
    widget.onShare?.call();
  }

  void _handleBookmark(ReelController controller) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.reel.isBookmarked
              ? 'Removed from bookmarks'
              : 'Added to bookmarks',
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: widget.config.accentColor,
      ),
    );
  }

  void _handleDownload(ReelController controller) {
    if (widget.config.onDownloadTap != null) {
      widget.config.onDownloadTap!(widget.reel);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Download started...'),
          duration: const Duration(seconds: 2),
          backgroundColor: widget.config.accentColor,
        ),
      );
    }
  }

  void _showFloatingHeart() {
    if (!mounted) return;
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject()! as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    late OverlayEntry overlayEntry;
    late AnimationController animationController;

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    final animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    overlayEntry = OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Positioned(
            left: position.dx + 20,
            top: position.dy - (50 * animation.value),
            child: Opacity(
              opacity: 1.0 - animation.value,
              child: Transform.scale(
                scale: 0.5 + (0.5 * animation.value),
                child: const Icon(
                  IconlyLight.heart,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ),
          );
        },
      ),
    );

    overlay.insert(overlayEntry);

    unawaited(
      animationController.forward().then((_) {
        overlayEntry.remove();
        animationController.dispose();
      }),
    );
  }

  Future<void> _showCommentsBottomSheet(
    BuildContext context,
    ReelController controller,
  ) async {
    final commentController = TextEditingController();
    final commentFocusNode = FocusNode();

    try {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            maxChildSize: 0.9,
            minChildSize: 0.3,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    // Handle bar
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Comments',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Spacer(),
                          Text(
                            ReelUtils.formatCount(widget.reel.commentsCount),
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Comments list
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: 10, // Placeholder
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundColor: widget.config.accentColor,
                                  child: Text(
                                    'U${index + 1}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'user${index + 1}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            '2h',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Sample comment #${index + 1}. '
                                        'Great content!',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            'Reply',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        size: 18,
                                        color: Colors.grey[600],
                                      ),
                                      onPressed: () {},
                                    ),
                                    Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    // Comment input
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: widget.config.accentColor,
                            child: const Icon(
                              Icons.person,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              focusNode: commentFocusNode,
                              decoration: InputDecoration(
                                hintText: 'Add a comment...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[100],
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              maxLines: null,
                              textInputAction: TextInputAction.send,
                              onSubmitted: (text) {
                                if (text.trim().isNotEmpty) {
                                  // Handle comment submission
                                  commentController.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Comment posted!'),
                                      backgroundColor:
                                          widget.config.accentColor,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              final text = commentController.text.trim();
                              if (text.isNotEmpty) {
                                // Handle comment submission
                                commentController.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('Comment posted!'),
                                    backgroundColor: widget.config.accentColor,
                                  ),
                                );
                              }
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: widget.config.accentColor,
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    } finally {
      commentController.dispose();
      commentFocusNode.dispose();
    }
  }

  void _showMoreOptions(BuildContext context, ReelController controller) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        builder: (context) => SafeArea(
          top: false,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bookmark in more menu
                if (widget.config.showBookmarkButton &&
                    widget.config.bookmarkInMoreMenu)
                  ListTile(
                    leading: Icon(
                      widget.reel.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                    ),
                    title: Text(
                      widget.reel.isBookmarked
                          ? 'Remove bookmark'
                          : 'Add bookmark',
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _handleBookmark(controller);
                    },
                  ),
                // Download in more menu
                if (widget.config.showDownloadButton &&
                    widget.config.downloadInMoreMenu)
                  ListTile(
                    leading: const Icon(Icons.download),
                    title: const Text('Download'),
                    onTap: () {
                      Navigator.pop(context);
                      _handleDownload(controller);
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.report),
                  title: Text(widget.config.reportLabel),
                  onTap: () {
                    Navigator.pop(context);
                    _handleReport(controller);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.block),
                  title: Text(widget.config.blockLabel),
                  onTap: () {
                    Navigator.pop(context);
                    _handleBlock(controller);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.link),
                  title: Text(widget.config.copyLinkLabel),
                  onTap: () {
                    Navigator.pop(context);
                    _handleCopyLink(controller);
                  },
                ),
                if (widget.config.customActions.isNotEmpty)
                  ...widget.config.customActions.map(
                    (action) => ListTile(
                      leading: Icon(action.icon),
                      title: Text(action.title),
                      onTap: () {
                        Navigator.pop(context);
                        action.onTap(widget.reel);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleReport(ReelController controller) {
    if (widget.config.onReportTap != null) {
      widget.config.onReportTap!(widget.reel);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Content reported'),
          backgroundColor: widget.config.accentColor,
        ),
      );
    }
  }

  void _handleBlock(ReelController controller) {
    if (widget.config.onBlockTap != null) {
      widget.config.onBlockTap!(widget.reel);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('User blocked'),
          backgroundColor: widget.config.accentColor,
        ),
      );
    }
    widget.onBlock?.call();
  }

  void _handleCopyLink(ReelController controller) {
    if (widget.config.onCopyLinkTap != null) {
      widget.config.onCopyLinkTap!(widget.reel);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Link copied to clipboard'),
          backgroundColor: widget.config.accentColor,
        ),
      );
    }
  }
}
