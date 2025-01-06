import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_admin/features/order/data/i_order_facade.dart';
import 'package:e_commerce_admin/features/order/data/model/enum_order.dart';
import 'package:e_commerce_admin/features/order/data/model/order_model.dart';
import 'package:e_commerce_admin/general/failures/main_failures.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IOrderFacade)
class OrderImpl implements IOrderFacade {
  final FirebaseFirestore firebaseFirestore;

  OrderImpl({required this.firebaseFirestore});

  @override
  Future<Either<MainFailure, List<OrderModel>>> fetchOrders() async {
    try {
      Query query = firebaseFirestore
          .collection('orders')
          .orderBy('createdAt', descending: true);

      QuerySnapshot querySnapshot = await query.get();

      final nelist = querySnapshot.docs
          .map((or) => OrderModel.fromMap(or.data() as Map<String, dynamic>))
          .toList();

      return right(nelist);
    } catch (e) {
      return left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<MainFailure, Unit>> updateOrderStatus(
      {required String orderId, required OrderStatus newStatus}) async {
    log('statusss $newStatus');
    try {
      final orderDoc =
          await firebaseFirestore.collection('orders').doc(orderId).get();

      if (!orderDoc.exists) {
        return left(MainFailure.serverFailure(
            errorMessage: 'Order not found with ID: $orderId'));
      }

      // final currentOrder =
      //     OrderModel.fromMap(orderDoc.data() as Map<String, dynamic>);

      // if (!currentOrder.orderStatus.canTransitionTo(newStatus)) {
      //   return left(MainFailure.serverFailure(
      //       errorMessage:
      //           'Invalid status transition from ${currentOrder.orderStatus.name} to ${newStatus.name}'));
      // }

      await firebaseFirestore.collection('orders').doc(orderId).update({
        'orderStatus': newStatus.name.toLowerCase(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return right(unit);
    } catch (e) {
      return left(MainFailure.serverFailure(errorMessage: e.toString()));
    }
  }
}
