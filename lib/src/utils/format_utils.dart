/// Number / duration / size formatting helpers.
class FormatUtils {
  FormatUtils._();

  /// Formats [duration] as `MM:SS` or `HH:MM:SS` for durations ≥ 1 hour.
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      final hours = twoDigits(duration.inHours);
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  /// Same as [formatDuration] but accepts nullable milliseconds.
  /// Returns `00:00` when null.
  static String formatDurationFromMilliseconds(int? milliseconds) {
    if (milliseconds == null) return '00:00';
    return formatDuration(Duration(milliseconds: milliseconds));
  }

  /// Formats a large [count] using `K` / `M` / `B` suffixes.
  static String formatCount(int count) {
    if (count < 1000) return count.toString();
    if (count < 1000000) {
      final value = count / 1000;
      return value % 1 == 0
          ? '${value.toInt()}K'
          : '${value.toStringAsFixed(1)}K';
    }
    if (count < 1000000000) {
      final value = count / 1000000;
      return value % 1 == 0
          ? '${value.toInt()}M'
          : '${value.toStringAsFixed(1)}M';
    }
    final value = count / 1000000000;
    return value % 1 == 0
        ? '${value.toInt()}B'
        : '${value.toStringAsFixed(1)}B';
  }

  /// Formats [bytes] as a binary-unit string (B / KB / MB / GB).
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}
