import 'package:flutter/material.dart';

import 'package:snap_reels/src/models/reel_config.dart';

/// Buffering indicator shown by the reel overlay while libmpv is fetching
/// more data. Host apps can replace the UI via
/// `ReelConfig.builders.bufferingBuilder`.
class ReelBufferingIndicator extends StatelessWidget {
  /// Creates the buffering indicator styled by [config].
  const ReelBufferingIndicator({required this.config, super.key});

  /// Styling configuration. Custom UI can be provided via
  /// `ReelConfig.builders.bufferingBuilder`.
  final ReelConfig config;

  @override
  Widget build(BuildContext context) {
    final customBuilder = config.builders.bufferingBuilder;
    if (customBuilder != null) {
      return customBuilder(context);
    }
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                config.styling.accentColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Buffering...',
              style: TextStyle(color: config.styling.textColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
