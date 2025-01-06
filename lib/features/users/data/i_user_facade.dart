import 'package:dartz/dartz.dart';
import 'package:e_commerce_admin/features/users/data/user_model.dart';
import 'package:e_commerce_admin/general/failures/main_failures.dart';

abstract class IUserFacade {
  Future<Either<MainFailure,List<UserModel>>> fetchUsers()async{
    throw UnimplementedError('error');
  }
}