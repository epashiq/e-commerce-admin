import 'package:dartz/dartz.dart';
import 'package:instagram_demo/features/comment/data/model/comment_model.dart';
import 'package:instagram_demo/general/failure/main_failures.dart';

abstract class ICommentFacade {
  Future<Either<MainFailures, CommentModel>> addComment(
      {required String personId, required CommentModel commentModel}) async {
    throw UnimplementedError('error');
  }

  Future<Either<MainFailures, List<CommentModel>>> fetchComments(
      {required String personId}) async {
    throw UnimplementedError();
  }

  Future<Either<MainFailures, Unit>> updateCommentCount(
      {required String personId}) async {
    throw UnimplementedError('error');
  }

  Future<Either<MainFailures,void>> deleteComments({required String personId,required String commentId})async{
    throw UnimplementedError('no delete comments');
  }
}
