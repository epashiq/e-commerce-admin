import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_demo/features/home/data/i_person_facade.dart';
import 'package:instagram_demo/features/home/data/model/person_model.dart';

class PersonProvider with ChangeNotifier {
  final IPersonFacade iPersonFacade;
  PersonProvider({required this.iPersonFacade});

  final nameController = TextEditingController();
  final placeController = TextEditingController();
  final descreptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  List<PersonModel> personList = [];
  bool isLoading = false;
  bool noMoreData = false;

  Future<void> addPerson() async {
    final result = await iPersonFacade.addPerson(
      personModel: PersonModel(
          name: nameController.text.trim(),
          place: placeController.text.trim(),
          descreption: descreptionController.text.trim(),
          createdAt: Timestamp.now(),
          like: 0,
          imageUrl: imageUrlController.text),
    );

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        addLocally(success);
        log('Add post succesfully');
      },
    );
  }

  Future<void> fetchPerson() async {
    if (isLoading || noMoreData) return;
    isLoading = true;
    notifyListeners();
    final result = await iPersonFacade.fetchPerson();

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        personList.addAll(success);
        log('fetvh post succesfully');
        for (var person in success) {
          log('''
          Name : ${person.name}
          Place : ${person.place}
          Descreption : ${person.descreption}
          like : ${person.like}
          imageUrl : ${person.imageUrl} ''');
        }
      },
    );

    isLoading = false;
    notifyListeners();
  }

  void clearController() {
    nameController.clear();
    placeController.clear();
    descreptionController.clear();
    notifyListeners();
  }

  void addLocally(PersonModel personModel) {
    personList.insert(0, personModel);
    notifyListeners();
  }

  Future<void> updateLike({required String personId}) async {
    final result = await iPersonFacade.updateLike(personId: personId);

    result.fold(
      (failure) { 
        log(failure.errorMessage);
      },
      (success) {
        final index = personList.indexWhere((person) => person.id == personId);

        if (index != -1) {
          personList[index] =
              personList[index].copyWith(like: personList[index].like + 1);
          notifyListeners();
        }
        log('Like Updated');
      },
    );
  }

  void clearList() {
    personList = [];
    notifyListeners();
  }
}
