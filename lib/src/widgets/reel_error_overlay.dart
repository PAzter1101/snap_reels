import 'package:flutter/material.dart';

import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';

/// Full-screen error overlay shown when video playback fails. The default UI
/// is a Material-style centered dialog with Cancel and Retry buttons. Host
/// apps can replace the UI via `ReelConfig.builders.errorDialogBuilder`.
class ReelErrorOverlay extends StatelessWidget {
  /// Creates the error overlay for [reel] with [errorMessage].
  const ReelErrorOverlay({
    required this.reel,
    required this.config,
    required this.errorMessage,
    required this.onRetry,
    required this.onCancel,
    super.key,
  });

  /// Reel that failed to play.
  final ReelModel reel;

  /// Styling and behavior configuration.
  final ReelConfig config;

  /// Localized error description displayed to the user.
  final String errorMessage;

  /// Invoked when the user taps the retry button.
  final VoidCallback onRetry;

  /// Invoked when the user dismisses the error overlay.
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final customBuilder = config.builders.errorDialogBuilder;
    if (customBuilder != null) {
      return customBuilder(context, reel, errorMessage, onRetry, onCancel);
    }
    return ColoredBox(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Failed to load video',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                errorMessage,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(onPressed: onCancel, child: const Text('Cancel')),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: onRetry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: config.styling.accentColor,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
