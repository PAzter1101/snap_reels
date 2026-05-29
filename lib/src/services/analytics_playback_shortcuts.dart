import 'package:snap_reels/src/models/reel_analytics.dart';
import 'package:snap_reels/src/services/analytics_service.dart';

/// Thin shortcuts over [AnalyticsService.trackPlaybackEvent] for each
/// [PlaybackEventType].
extension AnalyticsServicePlaybackShortcuts on AnalyticsService {
  /// Records [PlaybackEventType.started].
  void trackVideoStarted(String reelId, Duration position) =>
      trackPlaybackEvent(reelId, PlaybackEventType.started, position);

  /// Records [PlaybackEventType.paused].
  void trackVideoPaused(String reelId, Duration position) =>
      trackPlaybackEvent(reelId, PlaybackEventType.paused, position);

  /// Records [PlaybackEventType.resumed].
  void trackVideoResumed(String reelId, Duration position) =>
      trackPlaybackEvent(reelId, PlaybackEventType.resumed, position);

  /// Records [PlaybackEventType.completed].
  void trackVideoCompleted(String reelId, Duration position) =>
      trackPlaybackEvent(reelId, PlaybackEventType.completed, position);

  /// Records [PlaybackEventType.seeked].
  void trackVideoSeeked(
    String reelId,
    Duration position,
    Duration? duration,
  ) => trackPlaybackEvent(
    reelId,
    PlaybackEventType.seeked,
    position,
    duration: duration,
  );

  /// Records [PlaybackEventType.buffering].
  void trackBufferingStarted(String reelId, Duration position) =>
      trackPlaybackEvent(reelId, PlaybackEventType.buffering, position);

  /// Records [PlaybackEventType.error] with the error message in metadata.
  void trackVideoError(String reelId, Duration position, String error) =>
      trackPlaybackEvent(
        reelId,
        PlaybackEventType.error,
        position,
        metadata: {'error': error},
      );
}
