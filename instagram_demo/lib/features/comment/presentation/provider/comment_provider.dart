import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_demo/features/comment/data/i_comment_facade.dart';
import 'package:instagram_demo/features/comment/data/model/comment_model.dart';

class CommentProvider with ChangeNotifier {
  final ICommentFacade iCommentFacade;

  CommentProvider({required this.iCommentFacade});

  final commentController = TextEditingController();

  bool isfetching = false;
  List<CommentModel> commentList = [];

  Future<void> addComment({required String personId}) async {
    final result = await iCommentFacade.addComment(
        personId: personId,
        commentModel: CommentModel(
            commentCount: 0,
            personId: personId,
            comment: commentController.text.trim(),
            createdAt: Timestamp.now()));

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        log('add comment succesfully');
        addLocally(success);
      },
    );
  }

  Future<void> fetchComments({required String personId}) async {
    isfetching = true;
    notifyListeners();
    final result = await iCommentFacade.fetchComments(personId: personId);

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        commentList.addAll(success);
      },
    );
    isfetching = false;
    notifyListeners();
  }

  void clearCommentList() {
    commentList = [];
    notifyListeners();
  }

  void addLocally(CommentModel comment) {
    commentList.insert(0, comment);
    notifyListeners();
  }

  Future<void> updateCommentCount({required String personId}) async {
    final result = await iCommentFacade.updateCommentCount(personId: personId);

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        final index =
            commentList.indexWhere((comment) => comment.personId == personId);

        if (index != -1) {
          commentList[index] = commentList[index]
              .copyWith(commentCount: commentList[index].commentCount + 1);
        }
      },
    );
  }

  Future<void> deleteComments(
      {required String personId, required String commentId}) async {
    final results = await iCommentFacade.deleteComments(
        personId: personId, commentId: commentId);

    results.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        commentList.removeWhere((comment) => comment.id == commentId);
        log('delete comments');
      },
    );
  }
}
