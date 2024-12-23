import 'dart:developer';

import 'package:e_commerce_admin/features/product/data/i_product_facade.dart';
import 'package:e_commerce_admin/features/product/data/model/details_model.dart';
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

  List<ProductModel> productList = [];
  bool isLoading = false;
  bool noMoreData = false;

  Future<void> addProduct(
      {required String colour,
      required String material,
      required String categoryId}) async {
    final offerPrize = int.tryParse(offerPrizeController.text.trim());
    final mrpPrize = int.tryParse(offerPrizeController.text.trim());
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
            details: DetailsModel(
                material: materialController.text,
                colour: colourController.text,
                id: id)));

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        log('add product succesfully');
      },
    );
  }

  Future<void> fetchProducts() async {
    if (isLoading || noMoreData) return;
    isLoading = true;
    notifyListeners();

    final result = await iProductFacade.fetchProducts();

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        log('fetch product succesfully');
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
}
