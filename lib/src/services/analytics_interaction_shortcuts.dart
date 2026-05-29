import 'package:snap_reels/src/models/reel_analytics.dart';
import 'package:snap_reels/src/services/analytics_service.dart';

/// Thin shortcuts over [AnalyticsService.trackInteractionEvent] for each
/// supported gesture / social action.
extension AnalyticsServiceInteractionShortcuts on AnalyticsService {
  /// Records [InteractionEventType.like] or [InteractionEventType.unlike].
  void trackLike(
    String reelId,
    Duration videoPosition, {
    required bool isLiked,
  }) => trackInteractionEvent(
    reelId,
    isLiked ? InteractionEventType.like : InteractionEventType.unlike,
    videoPosition,
    metadata: {'isLiked': isLiked},
  );

  /// Records [InteractionEventType.comment] with the comment text.
  void trackComment(String reelId, Duration videoPosition, String comment) =>
      trackInteractionEvent(
        reelId,
        InteractionEventType.comment,
        videoPosition,
        metadata: {'comment': comment},
      );

  /// Records [InteractionEventType.share] with the share channel.
  void trackShare(String reelId, Duration videoPosition, String shareType) =>
      trackInteractionEvent(
        reelId,
        InteractionEventType.share,
        videoPosition,
        metadata: {'shareType': shareType},
      );

  /// Records [InteractionEventType.follow] or [InteractionEventType.unfollow].
  void trackFollow(
    String reelId,
    Duration videoPosition, {
    required bool isFollowing,
  }) => trackInteractionEvent(
    reelId,
    isFollowing ? InteractionEventType.follow : InteractionEventType.unfollow,
    videoPosition,
    metadata: {'isFollowing': isFollowing},
  );

  /// Records [InteractionEventType.tap].
  void trackTap(
    String reelId,
    Duration videoPosition,
    Map<String, dynamic>? metadata,
  ) => trackInteractionEvent(
    reelId,
    InteractionEventType.tap,
    videoPosition,
    metadata: metadata,
  );

  /// Records [InteractionEventType.doubleTap].
  void trackDoubleTap(String reelId, Duration videoPosition) =>
      trackInteractionEvent(
        reelId,
        InteractionEventType.doubleTap,
        videoPosition,
      );

  /// Records [InteractionEventType.longPress].
  void trackLongPress(String reelId, Duration videoPosition) =>
      trackInteractionEvent(
        reelId,
        InteractionEventType.longPress,
        videoPosition,
      );

  /// Records a swipe gesture. `direction` is one of
  /// `up` / `down` / `left` / `right` (case insensitive); other values
  /// are no-ops.
  void trackSwipe(
    String reelId,
    Duration videoPosition,
    String direction,
  ) {
    final InteractionEventType type;
    switch (direction.toLowerCase()) {
      case 'up':
        type = InteractionEventType.swipeUp;
      case 'down':
        type = InteractionEventType.swipeDown;
      case 'left':
        type = InteractionEventType.swipeLeft;
      case 'right':
        type = InteractionEventType.swipeRight;
      default:
        return;
    }
    trackInteractionEvent(
      reelId,
      type,
      videoPosition,
      metadata: {'direction': direction},
    );
  }
}
