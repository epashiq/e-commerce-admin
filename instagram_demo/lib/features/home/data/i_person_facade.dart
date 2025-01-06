import 'package:dartz/dartz.dart';
import 'package:instagram_demo/features/home/data/model/person_model.dart';
import 'package:instagram_demo/general/failure/main_failures.dart';

abstract class IPersonFacade {
  Future<Either<MainFailures, PersonModel>> addPerson(
      {required PersonModel personModel}) async {
    throw UnimplementedError('error');
  }

  Future<Either<MainFailures, List<PersonModel>>> fetchPerson() async {
    throw UnimplementedError('error');
  }

   Future<Either<MainFailures, Unit>> updateLike(
      {required String personId}) async {
    throw UnimplementedError('error');
  }

  
}

