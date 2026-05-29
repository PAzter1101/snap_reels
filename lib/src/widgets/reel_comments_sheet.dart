import 'package:flutter/material.dart';

import 'package:snap_reels/src/models/reel_config.dart';
import 'package:snap_reels/src/models/reel_model.dart';
import 'package:snap_reels/src/utils/reel_utils.dart';

/// Bottom sheet rendering placeholder comments for [reel].
///
/// Internal building block used by `ReelActions._handleComment` when no
/// custom `onCommentTap` is provided in [ReelConfig].
class ReelCommentsSheet extends StatefulWidget {
  /// Creates the comments sheet.
  const ReelCommentsSheet({
    required this.reel,
    required this.config,
    super.key,
  });

  /// Reel whose comments are being shown.
  final ReelModel reel;

  /// Styling configuration.
  final ReelConfig config;

  @override
  State<ReelCommentsSheet> createState() => _ReelCommentsSheetState();
}

class _ReelCommentsSheetState extends State<ReelCommentsSheet> {
  late final TextEditingController _commentController;
  late final FocusNode _commentFocusNode;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _commentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                _buildHandle(),
                _buildHeader(context),
                const Divider(height: 1),
                Expanded(child: _buildCommentsList(scrollController)),
                _buildInputBar(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 4,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text('Comments', style: Theme.of(context).textTheme.titleLarge),
          const Spacer(),
          Text(
            ReelUtils.formatCount(widget.reel.commentsCount),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsList(ScrollController scrollController) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 10,
      itemBuilder: (context, index) => _CommentRow(
        index: index,
        accentColor: widget.config.styling.accentColor,
      ),
    );
  }

  Widget _buildInputBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: widget.config.styling.accentColor,
            child: const Icon(Icons.person, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _commentController,
              focusNode: _commentFocusNode,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (text) => _submit(context, text),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _submit(context, _commentController.text),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: widget.config.styling.accentColor,
              child: const Icon(Icons.send, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext context, String text) {
    if (text.trim().isEmpty) return;
    _commentController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Comment posted!'),
        backgroundColor: widget.config.styling.accentColor,
      ),
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({required this.index, required this.accentColor});

  final int index;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: accentColor,
            child: Text(
              'U${index + 1}',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'user${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '2h',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Sample comment #${index + 1}. Great content!',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text(
                  'Reply',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  size: 18,
                  color: Colors.grey[600],
                ),
                onPressed: () {},
              ),
              Text(
                '${index + 1}',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
