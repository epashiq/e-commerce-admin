import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_admin/features/details/data/i_details_facade.dart';
import 'package:e_commerce_admin/features/details/data/model/detail_model.dart';
import 'package:e_commerce_admin/general/failures/main_failures.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@LazySingleton(as: IDetailsFacade)
class DetailsImpl implements IDetailsFacade {
  final FirebaseFirestore firebaseFirestore;
  DetailsImpl({required this.firebaseFirestore});

  @override
  Future<Either<MainFailure, DetailModel>> addDetails(
      {required String productId, required DetailModel detailsModel}) async {
    try {
      final detailsRef =
          firebaseFirestore.collection('products').doc(productId);

      final detailsId = const Uuid().v4();

      await detailsRef.update(
          {'details.$detailsId': detailsModel.copyWith(id: detailsId).toMap()});

      return right(detailsModel.copyWith(id: detailsId));
    } catch (e) {
      return left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }
  

  }
  
 

