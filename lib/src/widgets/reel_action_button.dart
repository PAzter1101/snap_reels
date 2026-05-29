import 'package:flutter/material.dart';

import 'package:snap_reels/src/models/reel_actions_config.dart';
import 'package:snap_reels/src/utils/reel_utils.dart';

/// Single tappable icon + optional count label used in the action stack.
class ReelActionButton extends StatelessWidget {
  /// Creates the action button.
  const ReelActionButton({
    required this.icon,
    required this.iconColor,
    required this.actions,
    required this.onTap,
    this.count,
    super.key,
  });

  /// Icon glyph rendered inside the tap target.
  final IconData icon;

  /// Color applied to the icon and the count label.
  final Color iconColor;

  /// Sizing rules for tap target and icon.
  final ReelActionsConfig actions;

  /// Invoked when the button is tapped.
  final VoidCallback onTap;

  /// Optional count rendered under the icon. Hidden when `null` or `0`.
  final int? count;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          minWidth: actions.actionMinTapTargetSize,
          minHeight: actions.actionMinTapTargetSize,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: actions.actionIconSize),
            if (count != null && count! > 0)
              Text(
                ReelUtils.formatCount(count!),
                style: TextStyle(
                  color: iconColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
