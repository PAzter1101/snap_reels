/// Aggregated metrics for a single reel session, derived from collected
/// playback and interaction events via the analytics service.
class AnalyticsSummary {
  /// Creates an [AnalyticsSummary] with all aggregate metrics.
  const AnalyticsSummary({
    required this.totalPlayTime,
    required this.watchPercentage,
    required this.interactionRate,
    required this.bufferingEvents,
    required this.performanceScore,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
  });

  /// Returns an all-zero summary, useful as a default placeholder.
  factory AnalyticsSummary.empty() {
    return const AnalyticsSummary(
      totalPlayTime: Duration.zero,
      watchPercentage: 0,
      interactionRate: 0,
      bufferingEvents: 0,
      performanceScore: 0,
      likesCount: 0,
      commentsCount: 0,
      sharesCount: 0,
    );
  }

  /// Total time the user spent watching the reel.
  final Duration totalPlayTime;

  /// Fraction of the video duration watched, in `[0, 1]`.
  final double watchPercentage;

  /// Interactions per second across the session.
  final double interactionRate;

  /// Number of buffering stalls during playback.
  final int bufferingEvents;

  /// Composite score in `[0, 1]` derived from buffering and frame drops.
  final double performanceScore;

  /// Number of likes captured for the session.
  final int likesCount;

  /// Number of comments captured for the session.
  final int commentsCount;

  /// Number of shares captured for the session.
  final int sharesCount;

  /// Serializes the summary to a JSON-friendly map.
  Map<String, dynamic> toJson() {
    return {
      'totalPlayTime': totalPlayTime.inMilliseconds,
      'watchPercentage': watchPercentage,
      'interactionRate': interactionRate,
      'bufferingEvents': bufferingEvents,
      'performanceScore': performanceScore,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'sharesCount': sharesCount,
    };
  }

  @override
  String toString() {
    return 'AnalyticsSummary('
        'playTime: ${totalPlayTime.inSeconds}s, '
        'watch: ${watchPercentage.toStringAsFixed(1)}%, '
        'interactions: ${interactionRate.toStringAsFixed(1)}/min, '
        'performance: ${performanceScore.toStringAsFixed(1)})';
  }
}
