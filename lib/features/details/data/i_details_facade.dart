import 'package:dartz/dartz.dart';
import 'package:e_commerce_admin/features/details/data/model/detail_model.dart';
import 'package:e_commerce_admin/general/failures/main_failures.dart';

abstract class IDetailsFacade {
  Future<Either<MainFailure, DetailModel>> addDetails(
      {required String productId, required DetailModel detailsModel}) async {
    throw UnimplementedError('error');
  }  
}
