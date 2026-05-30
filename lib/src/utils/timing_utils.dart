import 'dart:async';

/// Time-based helpers (debounce / throttle / timestamps).
class TimingUtils {
  TimingUtils._();

  static final Map<String, DateTime> _throttleMap = {};

  /// Restarts a debounce window for [function]. Pass the previous timer
  /// (or `null`) and store the returned timer for the next call.
  static Timer debounce(
    void Function() function,
    Duration delay, [
    Timer? previousTimer,
  ]) {
    previousTimer?.cancel();
    return Timer(delay, function);
  }

  /// Returns `true` if the throttle window for [key] has elapsed and
  /// records the new timestamp. Returns `false` otherwise.
  static bool throttle(String key, Duration duration) {
    final now = DateTime.now();
    final lastCall = _throttleMap[key];
    if (lastCall == null || now.difference(lastCall) >= duration) {
      _throttleMap[key] = now;
      return true;
    }
    return false;
  }

  /// Current Unix timestamp in milliseconds.
  static int get timestamp => DateTime.now().millisecondsSinceEpoch;

  /// Builds a [DateTime] from a milliseconds-since-epoch [timestamp].
  static DateTime timestampToDateTime(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Coarse English humanized form (`"2 hours ago"`, `"Just now"`, …).
  static String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} '
          'ago';
    }
    if (difference.inHours > 0) {
      final h = difference.inHours;
      return '$h hour${h == 1 ? '' : 's'} ago';
    }
    if (difference.inMinutes > 0) {
      final m = difference.inMinutes;
      return '$m minute${m == 1 ? '' : 's'} ago';
    }
    return 'Just now';
  }
}
