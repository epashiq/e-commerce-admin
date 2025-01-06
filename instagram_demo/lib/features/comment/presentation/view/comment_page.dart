import 'package:flutter/material.dart';
import 'package:instagram_demo/features/comment/presentation/provider/comment_provider.dart';
import 'package:instagram_demo/features/comment/presentation/view/widgets/add_comment_alert_diaogue_widget.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatefulWidget {
  final String personId;
  const CommentPage({super.key, required this.personId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  void initState() {
    super.initState();
    final commentProvider =
        Provider.of<CommentProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      commentProvider.fetchComments(personId: widget.personId);
      commentProvider.clearCommentList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final commentProvider = Provider.of<CommentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Consumer<CommentProvider>(
        builder: (context, commentPro, child) {
          if (commentPro.isfetching) {
            return const Center(child: LinearProgressIndicator());
          } else if (commentPro.commentList.isEmpty) {
            return const Center(
              child: Text('No comment Available'),
            );
          } else {
            return ListView.builder(
              itemCount: commentPro.commentList.length,
              itemBuilder: (context, index) {
                final comment = commentPro.commentList[index];
                return Card(
                  child: ListTile(
                    leading: Text('${index + 1}'),
                    title: Text(comment.comment),
                    trailing: IconButton(
                        onPressed: () {
                          commentPro.deleteComments(
                              personId: widget.personId,
                              commentId: comment.id!);
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddCommentAlertDiaogueWidget(onAdd: () {
                commentProvider.addComment(personId: widget.personId);
                Navigator.pop(context);
              }, onCancel: () {
                Navigator.pop(context);
              });
              // return AlertDialog(
              //   title: const Text('add your comment'),
              //   content: CustomTextField(
              //     hintText: 'comment',
              //     controller: commentProvider.commentController,
              //   ),
              //   actions: [
              //     TextButton(
              //         onPressed: () {
              //           Navigator.pop(context);
              //         },
              //         child: const Text('cancel')),
              //     TextButton(
              //         onPressed: () {
              //           commentProvider.addComment(personId: widget.personId);
              //         },
              //         child: const Text('Add')),
              //   ],
              // );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
