import 'package:flutter/material.dart';

import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';

/// Left-aligned overlay block: avatar, username, follow button, caption,
/// hashtags and music title. Stateless — rebuilds when the parent
/// rebuilds with a new reel/config.
class ReelUserInfoOverlay extends StatelessWidget {
  /// Creates a [ReelUserInfoOverlay].
  const ReelUserInfoOverlay({
    required this.reel,
    required this.config,
    this.onFollowTap,
    this.onHashtagTap,
    super.key,
  });

  /// Reel whose author info is rendered.
  final ReelModel reel;

  /// Styling and behavior configuration.
  final ReelConfig config;

  /// Invoked when the "Follow" button is tapped.
  final VoidCallback? onFollowTap;

  /// Invoked when a hashtag chip is tapped. Receives the tag without `#`.
  final void Function(String hashtag)? onHashtagTap;

  @override
  Widget build(BuildContext context) {
    if (reel.user == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUserRow(),
        const SizedBox(height: 12),
        if (reel.caption?.isNotEmpty == true) _buildCaption(),
        const SizedBox(height: 8),
        if (config.styling.showHashtags && reel.hashtags.isNotEmpty)
          _buildHashtags(),
        const SizedBox(height: 8),
        if (reel.musicTitle != null) _buildMusic(),
      ],
    );
  }

  Widget _buildUserRow() {
    final user = reel.user!;
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: user.profilePictureUrl != null
              ? NetworkImage(user.profilePictureUrl!)
              : null,
          backgroundColor: config.styling.accentColor,
          child: user.profilePictureUrl == null
              ? Icon(
                  Icons.person,
                  color: config.styling.textColor,
                  size: 20,
                )
              : null,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username,
                style: TextStyle(
                  color: config.styling.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              if (user.displayName != null)
                Text(
                  user.displayName!,
                  style: TextStyle(
                    color: config.styling.textColor.withAlpha(192),
                    fontSize: 12,
                  ),
                ),
            ],
          ),
        ),
        if (config.actions.showFollowButton && !user.isFollowing)
          _buildFollowButton(),
      ],
    );
  }

  Widget _buildFollowButton() {
    return OutlinedButton(
      onPressed: onFollowTap,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: config.styling.followButtonColor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
      child: Text(
        'Follow',
        style: TextStyle(
          color: config.styling.followButtonColor,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildCaption() {
    return Text(
      reel.caption!,
      style: TextStyle(
        color: config.styling.textColor,
        fontSize: 14,
        height: 1.3,
      ),
      maxLines: config.styling.maxCaptionLines,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildHashtags() {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: reel.hashtags
          .take(5)
          .map(
            (hashtag) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onHashtagTap?.call(hashtag),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: config.actions.hashtagMinTapTargetSize,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  '#$hashtag',
                  style: TextStyle(
                    color: config.styling.accentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildMusic() {
    return Row(
      children: [
        Icon(
          Icons.music_note,
          color: config.styling.textColor.withAlpha(192),
          size: 14,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            reel.musicTitle!,
            style: TextStyle(
              color: config.styling.textColor.withAlpha(192),
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
