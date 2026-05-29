import 'package:snap_reels/src/models/reel_analytics.dart';

/// Pure functions deriving metrics from collected analytics events.
class AnalyticsCalculations {
  const AnalyticsCalculations._();

  /// Sums `started`/`resumed` → `paused`/`completed` intervals plus any
  /// still-open interval up to `now`.
  static Duration totalPlayTime(List<PlaybackEvent> events) {
    var totalTime = Duration.zero;
    DateTime? playStartTime;

    for (final event in events) {
      switch (event.type) {
        case PlaybackEventType.started:
        case PlaybackEventType.resumed:
          playStartTime = event.timestamp;
        case PlaybackEventType.paused:
        case PlaybackEventType.completed:
          if (playStartTime != null) {
            totalTime += event.timestamp.difference(playStartTime);
            playStartTime = null;
          }
        case PlaybackEventType.seeked:
        case PlaybackEventType.buffering:
        case PlaybackEventType.error:
        case PlaybackEventType.qualityChanged:
        case PlaybackEventType.volumeChanged:
        case PlaybackEventType.speedChanged:
          break;
      }
    }

    if (playStartTime != null) {
      totalTime += DateTime.now().difference(playStartTime);
    }

    return totalTime;
  }

  /// Returns 100 if a `completed` event is present, otherwise the furthest
  /// position reached divided by the first known video duration.
  static double watchPercentage(List<PlaybackEvent> events) {
    final completedEvents = events.where(
      (e) => e.type == PlaybackEventType.completed,
    );
    if (completedEvents.isNotEmpty) return 100;

    var maxPosition = Duration.zero;
    for (final event in events) {
      if (event.position > maxPosition) {
        maxPosition = event.position;
      }
    }

    final durationEvents = events.where((e) => e.duration != null);
    if (durationEvents.isNotEmpty) {
      final duration = durationEvents.first.duration!;
      return (maxPosition.inMilliseconds / duration.inMilliseconds * 100).clamp(
        0.0,
        100.0,
      );
    }

    return 0;
  }

  /// Interactions per minute of play time. Returns 0 for empty play time.
  static double interactionRate(
    List<InteractionEvent> interactions,
    Duration playTime,
  ) {
    if (playTime.inSeconds == 0) return 0;
    return interactions.length /
        (playTime.inMinutes > 0 ? playTime.inMinutes : 1.0);
  }

  /// 0–100 composite score: penalizes dropped frames, buffering stalls
  /// and slow load times.
  static double performanceScore(PerformanceMetrics metrics) {
    var score = 100.0;

    if (metrics.totalFrames > 0) {
      final frameDropRate = metrics.droppedFrames / metrics.totalFrames;
      score -= frameDropRate * 30;
    }

    score -= metrics.bufferingCount * 5;
    score -= metrics.totalBufferingTime.inSeconds * 2;

    if (metrics.loadTime != null) {
      final loadTimeSeconds = metrics.loadTime!.inSeconds;
      if (loadTimeSeconds > 5) {
        score -= (loadTimeSeconds - 5) * 3;
      }
    }

    return score.clamp(0.0, 100.0);
  }
}
