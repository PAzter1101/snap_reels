import 'package:flutter/foundation.dart';

import 'package:snap_reels/src/models/reel_analytics.dart';
import 'package:snap_reels/src/services/analytics_calculations.dart';
import 'package:snap_reels/src/services/analytics_device_info_collector.dart';
import 'package:snap_reels/src/services/analytics_summary.dart';

export 'package:snap_reels/src/services/analytics_interaction_shortcuts.dart';
export 'package:snap_reels/src/services/analytics_playback_shortcuts.dart';
export 'package:snap_reels/src/services/analytics_summary.dart';

/// Service for collecting and reporting analytics data
class AnalyticsService {
  /// Returns the singleton instance, creating it on first access.
  factory AnalyticsService() => _instance ??= AnalyticsService._internal();
  AnalyticsService._internal();
  static AnalyticsService? _instance;

  bool _isEnabled = false;
  late DeviceInfo _deviceInfo;
  final Map<String, ReelAnalytics> _activeAnalytics = {};
  final List<ReelAnalytics> _pendingAnalytics = [];

  /// Callback for sending analytics data to external service
  Future<void> Function(ReelAnalytics analytics)? onAnalyticsReported;

  /// Callback for batch sending analytics data
  Future<void> Function(List<ReelAnalytics> analytics)?
  onBatchAnalyticsReported;

  /// Initialize the analytics service
  Future<void> initialize({
    bool enabled = true,
    Future<void> Function(ReelAnalytics analytics)? onAnalyticsReported,
    Future<void> Function(List<ReelAnalytics> analytics)?
    onBatchAnalyticsReported,
  }) async {
    _isEnabled = enabled;
    if (!_isEnabled) return;

    this.onAnalyticsReported = onAnalyticsReported;
    this.onBatchAnalyticsReported = onBatchAnalyticsReported;

    _deviceInfo = await AnalyticsDeviceInfoCollector.collect();
  }

  /// Start tracking a reel session
  Future<void> startReelSession(String reelId, {String? userId}) async {
    if (!_isEnabled) return;

    final sessionId = _generateSessionId();
    final analytics = ReelAnalytics(
      sessionId: sessionId,
      reelId: reelId,
      userId: userId,
      deviceInfo: _deviceInfo,
      performanceMetrics: const PerformanceMetrics(),
      sessionStartTime: DateTime.now(),
    );

    _activeAnalytics[reelId] = analytics;
  }

  /// End tracking a reel session
  Future<void> endReelSession(String reelId) async {
    if (!_isEnabled) return;

    final analytics = _activeAnalytics.remove(reelId);
    if (analytics != null) {
      final updatedAnalytics = analytics.copyWith(
        sessionEndTime: DateTime.now(),
      );

      _pendingAnalytics.add(updatedAnalytics);

      // Report immediately if callback is provided
      if (onAnalyticsReported != null) {
        try {
          await onAnalyticsReported!(updatedAnalytics);
        } catch (e) {
          debugPrint('Error reporting analytics: $e');
        }
      }
    }
  }

  /// Track a playback event
  void trackPlaybackEvent(
    String reelId,
    PlaybackEventType type,
    Duration position, {
    Duration? duration,
    Map<String, dynamic>? metadata,
  }) {
    if (!_isEnabled) return;

    final analytics = _activeAnalytics[reelId];
    if (analytics != null) {
      final event = PlaybackEvent(
        type: type,
        timestamp: DateTime.now(),
        position: position,
        duration: duration,
        metadata: metadata,
      );

      final updatedEvents = List<PlaybackEvent>.from(analytics.playbackEvents)
        ..add(event);

      _activeAnalytics[reelId] = analytics.copyWith(
        playbackEvents: updatedEvents,
      );
    }
  }

  /// Track an interaction event
  void trackInteractionEvent(
    String reelId,
    InteractionEventType type,
    Duration videoPosition, {
    Map<String, dynamic>? metadata,
  }) {
    if (!_isEnabled) return;

    final analytics = _activeAnalytics[reelId];
    if (analytics != null) {
      final event = InteractionEvent(
        type: type,
        timestamp: DateTime.now(),
        videoPosition: videoPosition,
        metadata: metadata,
      );

      final updatedEvents = List<InteractionEvent>.from(
        analytics.interactionEvents,
      )..add(event);

      _activeAnalytics[reelId] = analytics.copyWith(
        interactionEvents: updatedEvents,
      );
    }
  }

  /// Update performance metrics
  void updatePerformanceMetrics(
    String reelId,
    PerformanceMetrics metrics,
  ) {
    if (!_isEnabled) return;

    final analytics = _activeAnalytics[reelId];
    if (analytics != null) {
      _activeAnalytics[reelId] = analytics.copyWith(
        performanceMetrics: metrics,
      );
    }
  }

  /// Get current analytics for a reel
  ReelAnalytics? getReelAnalytics(String reelId) {
    return _activeAnalytics[reelId];
  }

  /// Get all pending analytics
  List<ReelAnalytics> getPendingAnalytics() {
    return List.from(_pendingAnalytics);
  }

  /// Clear pending analytics
  void clearPendingAnalytics() {
    _pendingAnalytics.clear();
  }

  /// Send batch analytics
  Future<void> sendBatchAnalytics() async {
    if (!_isEnabled || _pendingAnalytics.isEmpty) return;

    if (onBatchAnalyticsReported != null) {
      try {
        await onBatchAnalyticsReported!(_pendingAnalytics);
        _pendingAnalytics.clear();
      } catch (e) {
        debugPrint('Error sending batch analytics: $e');
      }
    }
  }

  /// Get analytics summary for a reel
  AnalyticsSummary getAnalyticsSummary(String reelId) {
    final analytics = _activeAnalytics[reelId];
    if (analytics == null) {
      return AnalyticsSummary.empty();
    }

    final playbackEvents = analytics.playbackEvents;
    final interactionEvents = analytics.interactionEvents;
    final performance = analytics.performanceMetrics;

    final totalPlayTime = AnalyticsCalculations.totalPlayTime(playbackEvents);
    final watchPercentage = AnalyticsCalculations.watchPercentage(
      playbackEvents,
    );
    final interactionRate = AnalyticsCalculations.interactionRate(
      interactionEvents,
      totalPlayTime,
    );
    final bufferingEvents = playbackEvents
        .where((e) => e.type == PlaybackEventType.buffering)
        .length;

    return AnalyticsSummary(
      totalPlayTime: totalPlayTime,
      watchPercentage: watchPercentage,
      interactionRate: interactionRate,
      bufferingEvents: bufferingEvents,
      performanceScore: AnalyticsCalculations.performanceScore(performance),
      likesCount: interactionEvents
          .where((e) => e.type == InteractionEventType.like)
          .length,
      commentsCount: interactionEvents
          .where((e) => e.type == InteractionEventType.comment)
          .length,
      sharesCount: interactionEvents
          .where((e) => e.type == InteractionEventType.share)
          .length,
    );
  }

  String _generateSessionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp * 1000 + (timestamp % 1000)).toString();
    return 'session_$random';
  }

  /// Enable or disable analytics
  void setEnabled({required bool enabled}) {
    _isEnabled = enabled;
    if (!enabled) {
      _activeAnalytics.clear();
      _pendingAnalytics.clear();
    }
  }

  /// Check if analytics is enabled
  bool get isEnabled => _isEnabled;
}
