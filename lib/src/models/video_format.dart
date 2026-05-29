/// Supported video streaming formats.
enum VideoFormat {
  /// Progressive MP4 over HTTP.
  mp4,

  /// HTTP Live Streaming (`.m3u8`).
  hls,

  /// Dynamic Adaptive Streaming over HTTP (`.mpd`).
  dash
  ;

  /// Parses a string representation; falls back to [VideoFormat.hls] for
  /// unknown values to preserve backward compatibility.
  static VideoFormat fromString(String format) {
    switch (format.toLowerCase()) {
      case 'mp4':
        return VideoFormat.mp4;
      case 'hls':
        return VideoFormat.hls;
      case 'dash':
        return VideoFormat.dash;
      default:
        return VideoFormat.hls;
    }
  }
}
