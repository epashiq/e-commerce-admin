import 'dart:developer';

import 'package:e_commerce_admin/features/users/data/i_user_facade.dart';
import 'package:e_commerce_admin/features/users/data/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final IUserFacade iUserFacade;
  UserProvider({required this.iUserFacade});

   List<UserModel> userList = [];
  bool isLoading = false;
  bool moreData = false;

  Future<void> fetchUsers() async {
    if (isLoading || moreData) return;
    isLoading = true;
    notifyListeners();

    final results = await iUserFacade.fetchUsers();

    results.fold(
      (failure) {
        log(failure.errorMessage);
        log('failed');
      },
      (success) {
        log('fetch users succesfully');
        userList.addAll(success);
        for (var element in success) {
          log('Address: ${element.address},\nName : ${element.name},\nNumber : ${element.number}');
        }
      },
    );
    isLoading = false;
    notifyListeners();
  }

  void cleraUserList(){
    userList = [];
    notifyListeners();
  }
}
