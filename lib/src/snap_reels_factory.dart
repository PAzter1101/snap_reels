import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';
import 'package:snap_reels/src/snap_reels_widget.dart';

/// Convenience constructors for [SnapReels].
extension SnapReelsExtension on SnapReels {
  /// Builds a [SnapReels] feed from a list of plain video URLs. Each URL
  /// becomes a [ReelModel] with a synthetic timestamp-based id.
  static SnapReels fromUrls(
    List<String> videoUrls, {
    ReelConfig config = const ReelConfig(),
    int initialIndex = 0,
    void Function(int index, ReelModel reel)? onPageChanged,
    void Function(ReelModel reel, Duration position)? onVideoTapped,
  }) {
    final reels = videoUrls.asMap().entries.map((entry) {
      return ReelModel(
        id: 'reel_${entry.key}_${DateTime.now().millisecondsSinceEpoch}',
        videoSource: VideoSource(url: entry.value),
      );
    }).toList();

    return SnapReels(
      reels: reels,
      config: config,
      initialIndex: initialIndex,
      onPageChanged: onPageChanged,
      onTap: onVideoTapped,
    );
  }
}
