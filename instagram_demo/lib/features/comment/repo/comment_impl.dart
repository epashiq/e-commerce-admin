import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_demo/features/comment/data/i_comment_facade.dart';
import 'package:instagram_demo/features/comment/data/model/comment_model.dart';
import 'package:instagram_demo/general/failure/main_failures.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: ICommentFacade)
class CommentImpl implements ICommentFacade {
  final FirebaseFirestore firebaseFirestore;

  CommentImpl({required this.firebaseFirestore});

  @override
  Future<Either<MainFailures, CommentModel>> addComment({
    required String personId,
    required CommentModel commentModel,
  }) async {
    try {
      final commentRef = firebaseFirestore.collection('person').doc(personId);
      final generalDoc = firebaseFirestore.collection('general').doc('count');

      final personSnapshot = await commentRef.get();
      if (!personSnapshot.exists) {
        return left(const MainFailures.serverFailure(
          errorMessage: "Person document not found.",
        ));
      }

      final generalSnapshot = await generalDoc.get();
      if (!generalSnapshot.exists) {
        await generalDoc.set({'commentCount': 0});
      }

      final batch = firebaseFirestore.batch();

      final commentId = const Uuid().v4();
      final updatedComment = commentModel.copyWith(id: commentId).toMap();

      batch.update(commentRef, {'comment.$commentId': updatedComment});

      batch.update(commentRef, {'commentCount': FieldValue.increment(1)});

      batch.update(generalDoc, {'totalComments': FieldValue.increment(1)});

      await batch.commit();

      return right(commentModel.copyWith(id: commentId));
    } catch (e) {
      return left(MainFailures.serverFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, List<CommentModel>>> fetchComments(
      {required String personId}) async {
    try {
      final commentRef =
          await firebaseFirestore.collection('person').doc(personId).get();

      if (commentRef.exists) {
        final commentData = commentRef.data();

        final Map<String, dynamic> commentMap =
            Map<String, dynamic>.from(commentData?['comment'] ?? {});

        List<CommentModel> commentList = [];

        commentMap.forEach((key, value) {
          final comment = CommentModel.fromMap(value);
          commentList.add(comment);
        });

        return right(commentList);
      } else {
        return right([]);
      }
    } catch (e) {
      return left(MainFailures.serverFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, Unit>> updateCommentCount(
      {required String personId}) async {
    try {
      final commentRef = firebaseFirestore.collection('person').doc(personId);

      await commentRef.update({'commentCount': FieldValue.increment(1)});

      return right(unit);
    } catch (e) {
      return left(MainFailures.serverFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, void>> deleteComments(
      {required String personId, required String commentId}) async {
    try {
      final commentRef = firebaseFirestore.collection('person').doc(personId);

      await commentRef.update({'comment.$commentId': FieldValue.delete()});

      return right(null);
    } catch (e) {
      return left(MainFailures.serverFailure(errorMessage: e.toString()));
    }
  }
}
