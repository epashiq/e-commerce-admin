import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/features/categories/data/i_category_facade.dart';
import 'package:e_commerce_admin/features/categories/data/model/category_model.dart';
import 'package:flutter/material.dart';

class CategoryProvider with ChangeNotifier {
  final ICategoryFacade iCategoryFacade;
  CategoryProvider({required this.iCategoryFacade});

  final nameController = TextEditingController();

  List<CategoryModel> categoryList = [];
  bool isLoading = false;
  bool noMoreData = false;

  Future<void> addCategory() async {
    final result = await iCategoryFacade.addCategory(
        categoryModel: CategoryModel(
            name: nameController.text.trim(), createdAt: Timestamp.now()));

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        log('Add category succesfully');
        addLocally(success);
      },
    );
  }

  Future<void> fetchCategories() async {
    if (isLoading || noMoreData) return;
    isLoading = true;
    notifyListeners();
    final result = await iCategoryFacade.fetchCategory();

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        categoryList.addAll(success);
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void addLocally(CategoryModel category) {
    categoryList.insert(0, category);
    notifyListeners();
  }

  void clearCategoryList() {
    categoryList = [];
    notifyListeners();
  }
}
