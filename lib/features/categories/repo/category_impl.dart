import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_admin/features/categories/data/i_category_facade.dart';
import 'package:e_commerce_admin/features/categories/data/model/category_model.dart';
import 'package:e_commerce_admin/general/failures/main_failures.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ICategoryFacade)
class CategoryImpl implements ICategoryFacade {
  final FirebaseFirestore firebaseFirestore;

  DocumentSnapshot? lastDocument;
  bool noMoreData = false;

  CategoryImpl({required this.firebaseFirestore});
  @override
  Future<Either<MainFailure, CategoryModel>> addCategory(
      {required CategoryModel categoryModel}) async {
    try {
      final categoryRef = firebaseFirestore.collection('category');

      final id = categoryRef.doc().id;

      final category = categoryModel.copyWith(id: id);

      await categoryRef.doc().set(category.toMap());

      return right(category);
    } catch (e) {
      return Left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<MainFailure, List<CategoryModel>>> fetchCategory() async {
    try {
      Query query = firebaseFirestore
          .collection('category')
          .orderBy('name', descending: false);

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
          .map((cat) =>
              CategoryModel.fromMap(cat.data() as Map<String, dynamic>))
          .toList();

      return right(newList);
    } catch (e) {
      return left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }
}
