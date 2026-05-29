import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Spinning music note avatar shown in the action stack when a reel has
/// a music title. Rotates continuously and pulses while playing.
class ReelMusicAvatar extends StatefulWidget {
  /// Creates the spinning music avatar.
  const ReelMusicAvatar({
    required this.accentColor,
    required this.iconColor,
    super.key,
    this.size = 40,
  });

  /// Color used for the avatar gradient.
  final Color accentColor;

  /// Color of the music note icon and the surrounding border.
  final Color iconColor;

  /// Diameter of the avatar in logical pixels.
  final double size;

  @override
  State<ReelMusicAvatar> createState() => _ReelMusicAvatarState();
}

class _ReelMusicAvatarState extends State<ReelMusicAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    unawaited(_controller.repeat());
    _pulse = Tween<double>(begin: 1, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: Transform.scale(
            scale: _pulse.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    widget.accentColor,
                    widget.accentColor.withAlpha(128),
                  ],
                ),
                border: Border.all(color: widget.iconColor, width: 2),
              ),
              child: Icon(
                Icons.music_note,
                color: widget.iconColor,
                size: widget.size / 2,
              ),
            ),
          ),
        );
      },
    );
  }
}
