import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_admin/features/users/data/i_user_facade.dart';
import 'package:e_commerce_admin/features/users/data/user_model.dart';
import 'package:e_commerce_admin/general/failures/main_failures.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IUserFacade)
class UserImpl implements IUserFacade {
  final FirebaseFirestore firebaseFirestore;
  UserImpl({required this.firebaseFirestore});

  DocumentSnapshot? lastDocument;
  bool noMoreData = false;

  @override
  Future<Either<MainFailure, List<UserModel>>> fetchUsers() async {
    try {
      Query query = firebaseFirestore.collection('users');
      log('1');

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }
      log('2');

      QuerySnapshot querySnapshot = await query.limit(10).get();
      log(querySnapshot.docs.length.toString());

      if (querySnapshot.docs.length < 10) {
        noMoreData = true;
      } else {
        lastDocument = querySnapshot.docs.last;
      }

      final newList = querySnapshot.docs
          .map((us) => UserModel.fromMap(us.data() as Map<String, dynamic>))
          .toList();

      return right(newList);
    } catch (e) {
      return left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }

}
