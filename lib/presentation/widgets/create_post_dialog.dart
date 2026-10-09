import 'package:flutter/material.dart';

/// Dialog for creating a new community post
/// Shows a text input field and handles post submission
/// Uses a callback to delegate post creation to the parent widget
class CreatePostDialog extends StatefulWidget {
  const CreatePostDialog({super.key, required this.onPostSubmitted});

  final void Function(String content) onPostSubmitted;

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final TextEditingController _postController = TextEditingController();

  @override
  void dispose() {
    _postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Post'),
      content: TextField(
        controller: _postController,
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: "What's on your mind?",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _postController.clear();
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final content = _postController.text.trim();

            if (content.isEmpty) return;

            widget.onPostSubmitted(content);
            _postController.clear();
            Navigator.pop(context);
          },
          child: const Text('Post'),
        ),
      ],
    );
  }
}
