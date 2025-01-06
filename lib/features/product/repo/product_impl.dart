import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_admin/features/product/data/i_product_facade.dart';
import 'package:e_commerce_admin/features/product/data/model/product_model.dart';
import 'package:e_commerce_admin/general/failures/main_failures.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IProductFacade)
class ProductImpl implements IProductFacade {
  final FirebaseFirestore firebaseFirestore;
  ProductImpl({required this.firebaseFirestore});

  DocumentSnapshot? lastDocument;
  bool noMoreData = false;

  @override
  Future<Either<MainFailure, ProductModel>> addProducts(
      {required ProductModel productModel}) async {
    try {
      final productRef = firebaseFirestore.collection('products');

      final id = productRef.doc().id;

      final product = productModel.copyWith(id: id);

      await productRef.doc(id).set(product.toMap());

      return right(product);
    } catch (e) {
      return left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<MainFailure, List<ProductModel>>> fetchProducts(
      String categoryId) async {
    try {
      Query query = firebaseFirestore
          .collection('products')
          .where('categoryId', isEqualTo: categoryId)
          .orderBy('product', descending: false);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.limit(10).get();

      if (querySnapshot.docs.length < 10) {
        noMoreData = true;
      } else {
        lastDocument = querySnapshot.docs.last;
      }

      final newList = querySnapshot.docs
          .map(
              (pro) => ProductModel.fromMap(pro.data() as Map<String, dynamic>))
          .toList();

      return right(newList);
    } catch (e) {
      return left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }
}
