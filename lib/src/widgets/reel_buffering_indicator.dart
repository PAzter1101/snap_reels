import 'package:flutter/material.dart';
import '../models/reel_config.dart';

/// Buffering indicator shown by the reel overlay while libmpv is fetching
/// more data. Host apps can replace the UI via [ReelConfig.bufferingBuilder].
class ReelBufferingIndicator extends StatelessWidget {
  const ReelBufferingIndicator({super.key, required this.config});

  final ReelConfig config;

  @override
  Widget build(BuildContext context) {
    final customBuilder = config.bufferingBuilder;
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
              valueColor: AlwaysStoppedAnimation<Color>(config.accentColor),
            ),
            const SizedBox(height: 8),
            Text(
              'Buffering...',
              style: TextStyle(color: config.textColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
