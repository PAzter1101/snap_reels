/// Video-URL recognition and thumbnail extraction.
class VideoUrlUtils {
  VideoUrlUtils._();

  static const _videoExtensions = [
    '.mp4',
    '.mov',
    '.avi',
    '.mkv',
    '.webm',
    '.flv',
    '.wmv',
    '.m4v',
    '.3gp',
  ];

  /// Validates that [url] parses and uses an `http`/`https` scheme.
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.isScheme('http') || uri.isScheme('https'));
    } catch (e) {
      return false;
    }
  }

  /// Whether [url] ends with a known video file extension.
  static bool isVideoUrl(String url) {
    final lowercaseUrl = url.toLowerCase();
    return _videoExtensions.any(lowercaseUrl.contains);
  }

  /// Extracts a YouTube or Vimeo video id from [url], or `null` if no
  /// pattern matches.
  static String? extractVideoId(String url) {
    final youtubeRegex = RegExp(
      r'(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})',
      caseSensitive: false,
    );
    final youtubeMatch = youtubeRegex.firstMatch(url);
    if (youtubeMatch != null) return youtubeMatch.group(1);

    final vimeoRegex = RegExp(r'vimeo\.com\/(\d+)', caseSensitive: false);
    final vimeoMatch = vimeoRegex.firstMatch(url);
    if (vimeoMatch != null) return vimeoMatch.group(1);

    return null;
  }

  /// Returns the canonical thumbnail URL for known platforms
  /// (YouTube / Vimeo), or `null` otherwise.
  static String? getThumbnailUrl(String videoUrl) {
    final videoId = extractVideoId(videoUrl);
    if (videoId == null) return null;

    if (videoUrl.contains('youtube') || videoUrl.contains('youtu.be')) {
      return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';
    }
    if (videoUrl.contains('vimeo')) {
      return 'https://vumbnail.com/$videoId.jpg';
    }
    return null;
  }
}
