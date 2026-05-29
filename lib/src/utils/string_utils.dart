import 'dart:math';

/// String validation / transformation helpers.
class StringUtils {
  StringUtils._();

  /// Generates a `<millis>_<random>` style identifier.
  static String generateId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = Random().nextInt(999999);
    return '${timestamp}_$random';
  }

  /// Loose RFC-5321 email check.
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Whether [str] parses as a double.
  static bool isNumeric(String str) => double.tryParse(str) != null;

  /// Title-cases each whitespace-separated word in [text].
  static String capitalizeWords(String text) {
    return text
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  /// Truncates [text] to [maxLength] characters and appends `…`
  /// when truncation occurred.
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
