import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/features/details/data/i_details_facade.dart';
import 'package:e_commerce_admin/features/details/data/model/detail_model.dart';
import 'package:flutter/widgets.dart';

class DetailsProvider with ChangeNotifier {
  final IDetailsFacade iDetailsFacade;
  DetailsProvider({required this.iDetailsFacade});

  final materialController = TextEditingController();
  final colourController = TextEditingController();
  final productionController = TextEditingController();

  Future<void> addDetails({required String productId}) async {
    final result = await iDetailsFacade.addDetails(
        productId: productId,
        detailsModel: DetailModel(
            proMaterial: materialController.text,
            proColour: colourController.text,
            production: productionController.text,
            createdAt: Timestamp.now()));

    result.fold(
      (failure) {
        log(failure.toString());
      },
      (success) {
        log('details added succesfully');
      },
    );
  }
}
