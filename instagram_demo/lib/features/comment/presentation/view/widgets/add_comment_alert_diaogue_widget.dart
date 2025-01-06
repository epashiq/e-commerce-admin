import 'package:flutter/material.dart';
import 'package:instagram_demo/features/comment/presentation/provider/comment_provider.dart';
import 'package:instagram_demo/features/home/presentation/view/widgets/custom_text_form_field_widget.dart';
import 'package:provider/provider.dart';

class AddCommentAlertDiaogueWidget extends StatelessWidget {
  final VoidCallback onAdd;
  final VoidCallback onCancel;
  const AddCommentAlertDiaogueWidget(
      {super.key, required this.onAdd, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    return AlertDialog(
      title: const Text('add your comment'),
      content: CustomTextField(
        hintText: 'comment',
        controller: commentProvider.commentController,
      ),
      actions: [
        TextButton(onPressed: onCancel, child: const Text('cancel')),
        TextButton(onPressed: onAdd, child: const Text('Add')),
      ],
    );
  }
}
