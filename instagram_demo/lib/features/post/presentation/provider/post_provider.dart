import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_demo/features/post/data/i_post_facade.dart';
import 'package:instagram_demo/features/post/data/post_model.dart';

class PostProvider with ChangeNotifier {
  final IPostFacade iPostFacade;
  PostProvider({required this.iPostFacade});

  final descreptionController = TextEditingController();

  Future<void> addPost({required String userId}) async {
    final result = await iPostFacade.addPost(
        postModel: PostModel(
            userId: userId,
            descreption: descreptionController.text.trim(),
            likecount: 0,
            createdAt: Timestamp.now()));

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        log('Add post succesfully');
      },
    );
  }
}
