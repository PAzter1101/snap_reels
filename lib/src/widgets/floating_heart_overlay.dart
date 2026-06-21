import 'dart:async';

import 'package:flutter/material.dart';

/// Brief floating heart animation rendered above the target widget when
/// the user double-likes a reel.
class FloatingHeartOverlay {
  const FloatingHeartOverlay._();

  /// Shows the heart anchored to [anchorContext]'s render box. The
  /// animation removes itself when complete.
  static void show(BuildContext anchorContext) {
    final renderBox = anchorContext.findRenderObject();
    if (renderBox is! RenderBox) return;
    final overlay = Overlay.of(anchorContext);
    final position = renderBox.localToGlobal(Offset.zero);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _FloatingHeart(
        origin: position,
        onComplete: entry.remove,
      ),
    );
    overlay.insert(entry);
  }
}

class _FloatingHeart extends StatefulWidget {
  const _FloatingHeart({required this.origin, required this.onComplete});

  final Offset origin;
  final VoidCallback onComplete;

  @override
  State<_FloatingHeart> createState() => _FloatingHeartState();
}

class _FloatingHeartState extends State<_FloatingHeart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _progress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    unawaited(_controller.forward().then((_) => widget.onComplete()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progress,
      builder: (context, _) {
        final t = _progress.value;
        return Positioned(
          left: widget.origin.dx + 20,
          top: widget.origin.dy - 50 * t,
          child: Opacity(
            opacity: 1 - t,
            child: Transform.scale(
              scale: 0.5 + 0.5 * t,
              child: const Icon(Icons.favorite, color: Colors.red, size: 30),
            ),
          ),
        );
      },
    );
  }
}
