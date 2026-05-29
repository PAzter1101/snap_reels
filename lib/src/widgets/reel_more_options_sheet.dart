import 'package:flutter/material.dart';

import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';

/// Bottom sheet rendering the "more options" entries (bookmark, download,
/// report, block, copy link, custom actions).
class ReelMoreOptionsSheet extends StatelessWidget {
  /// Creates the sheet.
  const ReelMoreOptionsSheet({
    required this.reel,
    required this.config,
    required this.onBookmark,
    required this.onDownload,
    required this.onReport,
    required this.onBlock,
    required this.onCopyLink,
    super.key,
  });

  /// Reel that the entries operate on.
  final ReelModel reel;

  /// Styling and behavior configuration.
  final ReelConfig config;

  /// Invoked when the bookmark entry is tapped.
  final VoidCallback onBookmark;

  /// Invoked when the download entry is tapped.
  final VoidCallback onDownload;

  /// Invoked when the report entry is tapped.
  final VoidCallback onReport;

  /// Invoked when the block entry is tapped.
  final VoidCallback onBlock;

  /// Invoked when the copy-link entry is tapped.
  final VoidCallback onCopyLink;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (config.actions.showBookmarkButton &&
                config.actions.bookmarkInMoreMenu)
              ListTile(
                leading: Icon(
                  reel.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                ),
                title: Text(
                  reel.isBookmarked ? 'Remove bookmark' : 'Add bookmark',
                ),
                onTap: () {
                  Navigator.pop(context);
                  onBookmark();
                },
              ),
            if (config.actions.showDownloadButton &&
                config.actions.downloadInMoreMenu)
              ListTile(
                leading: const Icon(Icons.download),
                title: const Text('Download'),
                onTap: () {
                  Navigator.pop(context);
                  onDownload();
                },
              ),
            ListTile(
              leading: const Icon(Icons.report),
              title: Text(config.actions.reportLabel),
              onTap: () {
                Navigator.pop(context);
                onReport();
              },
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: Text(config.actions.blockLabel),
              onTap: () {
                Navigator.pop(context);
                onBlock();
              },
            ),
            ListTile(
              leading: const Icon(Icons.link),
              title: Text(config.actions.copyLinkLabel),
              onTap: () {
                Navigator.pop(context);
                onCopyLink();
              },
            ),
            ...config.actions.customActions.map(
              (action) => ListTile(
                leading: Icon(action.icon),
                title: Text(action.title),
                onTap: () {
                  Navigator.pop(context);
                  action.onTap(reel);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
