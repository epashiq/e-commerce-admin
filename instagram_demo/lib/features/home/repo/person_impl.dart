import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:instagram_demo/features/home/data/i_person_facade.dart';
import 'package:instagram_demo/features/home/data/model/person_model.dart';
import 'package:instagram_demo/general/failure/main_failures.dart';

@LazySingleton(as: IPersonFacade)
class PersonImpl implements IPersonFacade {
  final FirebaseFirestore firebaseFirestore;
  PersonImpl({required this.firebaseFirestore});

  DocumentSnapshot? lastDocument;
  bool noMoreData = false;

  @override
  Future<Either<MainFailures, PersonModel>> addPerson(
      {required PersonModel personModel}) async {
    try {
      final personRef = firebaseFirestore.collection('person');

      final id = personRef.doc().id;

      final person = personModel.copyWith(id: id);

      await personRef.doc(id).set(person.toMap());

      return right(person);
    } catch (e) {
      return left(MainFailures.serverFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, List<PersonModel>>> fetchPerson() async {
    try {
      Query query = firebaseFirestore
          .collection('person')
          .orderBy('createdAt', descending: false);

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
          .map((pro) => PersonModel.fromMap(pro.data() as Map<String, dynamic>))
          .toList();

      return right(newList);
    } catch (e) {
      return left(MainFailures.serverFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<MainFailures, Unit>> updateLike(
      {required String personId}) async {
    try {
      final personRef = firebaseFirestore.collection('person').doc(personId);

      await personRef.update({'like': FieldValue.increment(1)});

      return right(unit);
    } catch (e) {
      return left(MainFailures.serverFailure(errorMessage: e.toString()));
    }
  }

  // @override
  // Future<Either<MainFailures, Unit>> updateLike(
  //     {required String personId}) async {
  //   try {
  //     final personRef = firebaseFirestore.collection('person').doc(personId);

  //     await firebaseFirestore.runTransaction((transaction) async {
  //       final snapshot = await transaction.get(personRef);

  //       if (!snapshot.exists) {
  //         throw Exception('Document does not exist');
  //       }

  //       final currentLike = snapshot.data()?['like'] ?? 0;

  //       transaction.update(personRef, {'like': currentLike + 1});
  //     });

  //     return right(unit);
  //   } catch (e) {
  //     return left(MainFailures.serverFailure(errorMessage: e.toString()));
  //   }
  // }
}


// https://talksport.com/wp-content/uploads/sites/5/2022/10/8e567fa4-66cc-4c97-b90c-b7643e0ed637.jpg