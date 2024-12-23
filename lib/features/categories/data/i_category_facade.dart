import 'package:dartz/dartz.dart';
import 'package:e_commerce_admin/features/categories/data/model/category_model.dart';
import 'package:e_commerce_admin/general/failures/main_failures.dart';

abstract class ICategoryFacade {
  Future<Either<MainFailure, CategoryModel>> addCategory(
      {required CategoryModel categoryModel}) async {
    throw UnimplementedError('error');
  }
  Future<Either<MainFailure,List<CategoryModel>>> fetchCategory()async{
    throw UnimplementedError('error');
  }
}
