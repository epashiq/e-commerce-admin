import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:instagram_demo/features/post/data/i_post_facade.dart';
import 'package:instagram_demo/features/post/data/post_model.dart';
import 'package:instagram_demo/general/failure/main_failures.dart';

class PostImpl implements IPostFacade {
  final FirebaseFirestore firebaseFirestore;

  PostImpl({required this.firebaseFirestore});

  DocumentSnapshot? lastDocument;
  bool noMoreData = false;
  @override
  Future<Either<MainFailures, PostModel>> addPost(
      {required PostModel postModel}) async {
    try {
      final postRef =
          firebaseFirestore.collection('post').doc(postModel.userId);

      final id = postRef.id;

      final post = postModel.copyWith(id: id);

      await postRef.set(post.toMap());

      return right(post);
    } catch (e) {
      return left(MainFailures.serverFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, List<PostModel>>> fetchPost(
      {required String userId}) async {
    try {
      Query query = firebaseFirestore
          .collection('post')
          .orderBy('createdAt', descending: false);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.limit(10).get();

      if (querySnapshot.docs.length < 0) {
        noMoreData = true;
      } else {
        lastDocument = querySnapshot.docs.last;
      }

      final postList = querySnapshot.docs
          .map((po) => PostModel.fromMap(po.data() as Map<String, dynamic>))
          .toList();

      return right(postList);
    } catch (e) {
      return left(MainFailures.serverFailure(errorMessage: e.toString()));
    }
  }
}
