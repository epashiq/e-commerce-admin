import 'package:dartz/dartz.dart';
import 'package:instagram_demo/features/post/data/post_model.dart';
import 'package:instagram_demo/general/failure/main_failures.dart';

abstract class IPostFacade {
  Future<Either<MainFailures, PostModel>> addPost(
      {required PostModel postModel})async{
        throw UnimplementedError('error');
      }

      Future<Either<MainFailures,List<PostModel>>> fetchPost({required String userId})async{
        throw UnimplementedError('error');
      }
}
