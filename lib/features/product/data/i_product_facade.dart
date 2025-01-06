import 'package:dartz/dartz.dart';
import 'package:e_commerce_admin/features/product/data/model/product_model.dart';
import 'package:e_commerce_admin/general/failures/main_failures.dart';

abstract class IProductFacade {
  Future<Either<MainFailure,ProductModel>> addProducts({required ProductModel productModel})async{
    throw UnimplementedError('error');
  }

  Future<Either<MainFailure,List<ProductModel>>> fetchProducts(String categoryId)async{
    throw UnimplementedError('error');
  }
}