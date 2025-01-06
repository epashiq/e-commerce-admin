import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/features/details/data/model/detail_model.dart';
import 'package:e_commerce_admin/features/product/data/i_product_facade.dart';
import 'package:e_commerce_admin/features/product/data/model/product_model.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  final IProductFacade iProductFacade;
  ProductProvider({required this.iProductFacade});

  final productController = TextEditingController();
  final mrpPrizeController = TextEditingController();
  final offerPrizeController = TextEditingController();
  final descreptionController = TextEditingController();
  final stockController = TextEditingController();
  final colourController = TextEditingController();
  final materialController = TextEditingController();
  final productionController = TextEditingController();

  List<ProductModel> productList = [];
  bool isLoading = false;
  bool noMoreData = false;

  Future<void> addProduct(
      {required String categoryId,
      required String colour,
      required String material,
      required String production}) async {
    final offerPrize = int.tryParse(offerPrizeController.text.trim());
    final mrpPrize = int.tryParse(mrpPrizeController.text.trim());
    final stock = int.tryParse(stockController.text.trim());
    final id = const Uuid().v4();
    final result = await iProductFacade.addProducts(
      productModel: ProductModel(
          product: productController.text,
          categoryId: categoryId,
          mrpPrize: mrpPrize!,
          descreption: descreptionController.text,
          stock: stock!,
          offerPrize: offerPrize!,
          details: DetailModel(
              proMaterial: materialController.text,
              proColour: colourController.text,
              production: productionController.text,
              createdAt: Timestamp.now(),
              id: id)),
    );

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        log('Add product successfully');
      },
    );
  }

  Future<void> fetchProducts(String categoryId) async {
    if (isLoading || noMoreData) return;
    isLoading = true;
    notifyListeners();

    final result = await iProductFacade.fetchProducts(categoryId);

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        log('Fetch product successfully');
        productList.addAll(success);
      },
    );
    isLoading = false;
    notifyListeners();
  }

  double calculateDiscountPercentage(
      {required int mrp, required int offerPrice}) {
    if (mrp <= 0) return 0.0;
    final discount = ((mrp - offerPrice) / mrp) * 100;
    return discount;
  }

  void clearExpenseList() {
    productList = [];
    notifyListeners();
  }

  void clearController() {
    productController.clear();
    materialController.clear();
    mrpPrizeController.clear();
    offerPrizeController.clear();
    colourController.clear();
    descreptionController.clear();
    stockController.clear();
  }
}

// import 'dart:developer';

// import 'package:e_commerce_admin/features/product/data/i_product_facade.dart';
// import 'package:e_commerce_admin/features/product/data/model/product_model.dart';
// import 'package:flutter/widgets.dart';

// class ProductProvider with ChangeNotifier {
//   final IProductFacade iProductFacade;
//   ProductProvider({required this.iProductFacade});

//   final productController = TextEditingController();
//   final mrpPrizeController = TextEditingController();
//   final offerPrizeController = TextEditingController();
//   final descreptionController = TextEditingController();
//   final stockController = TextEditingController();
//   final colourController = TextEditingController();
//   final materialController = TextEditingController();
//   final productionController = TextEditingController();

//   List<ProductModel> productList = [];
//   bool isLoading = false;
//   bool noMoreData = false;

//   Future<void> addProduct(
//       {required String categoryId,
//       required String colour,
//       required String material,
//       required String production}) async {
//     final offerPrize = int.tryParse(offerPrizeController.text.trim());
//     final mrpPrize = int.tryParse(mrpPrizeController.text.trim());
//     final stock = int.tryParse(stockController.text.trim());
//     // final id = const Uuid().v4();
//     final result = await iProductFacade.addProducts(
//       productModel: ProductModel(
//         product: productController.text,
//         categoryId: categoryId,
//         mrpPrize: mrpPrize!,
//         descreption: descreptionController.text,
//         stock: stock!,
//         offerPrize: offerPrize!,
//       ),
//     );

//     result.fold(
//       (failure) {
//         log(failure.errorMessage);
//       },
//       (success) {
//         log('Add product successfully');
//       },
//     );
//   }

//   Future<void> fetchProducts(String categoryId) async {
//     if (isLoading || noMoreData) return;
//     isLoading = true;
//     notifyListeners();

//     final result = await iProductFacade.fetchProducts(categoryId);

//     result.fold(
//       (failure) {
//         log(failure.errorMessage);
//       },
//       (success) {
//         log('Fetch product successfully');
//         productList.addAll(success);
//       },
//     );
//     isLoading = false;
//     notifyListeners();
//   }

//   double calculateDiscountPercentage(
//       {required int mrp, required int offerPrice}) {
//     if (mrp <= 0) return 0.0;
//     final discount = ((mrp - offerPrice) / mrp) * 100;
//     return discount;
//   }

//   void clearExpenseList() {
//     productList = [];
//     notifyListeners();
//   }

//   void clearController() {
//     productController.clear();
//     materialController.clear();
//     mrpPrizeController.clear();
//     offerPrizeController.clear();
//     colourController.clear();
//     descreptionController.clear();
//     stockController.clear();
//   }
// }
