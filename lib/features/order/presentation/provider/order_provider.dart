import 'dart:developer';

import 'package:e_commerce_admin/features/order/data/i_order_facade.dart';
import 'package:e_commerce_admin/features/order/data/model/enum_order.dart';
import 'package:e_commerce_admin/features/order/data/model/order_model.dart';
import 'package:flutter/foundation.dart';

class OrderProvider with ChangeNotifier {
  final IOrderFacade iOrderFacade;

  OrderProvider({required this.iOrderFacade});

  List<OrderModel> orderList = [];

  OrderStatus? orderStatus;

  void updateOrderStatusLocally(OrderStatus status) {
    orderStatus = status;
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    final result = await iOrderFacade.fetchOrders();

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        orderList.addAll(success);
        log('fetch orders');
        notifyListeners();
      },
    );
  }

  void clearOrderList() {
    orderList = [];
    notifyListeners();
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required OrderStatus newStatus,
  }) async {
    final result = await iOrderFacade.updateOrderStatus(
      orderId: orderId,
      newStatus: newStatus,
    );

    result.fold(
      (failure) {
        log(failure.errorMessage);
      },
      (success) {
        final orderIndex =
            orderList.indexWhere((order) => order.orderId == orderId);

        if (orderIndex != -1) {
          notifyListeners();
          // orderList[orderIndex].orderStatus = newStatus;
        }

        //   if (orderIndex != -1) {
        // final order = orderList[orderIndex];
        // Check if the status can transition and update
        // if (order.orderStatus.canTransitionTo(newStatus)) {
        //   order.orderStatus = newStatus;
        //   notifyListeners();
        // } else {
        //   // Handle invalid transition here (e.g., show a message)
        //   log('Invalid status transition for order ID: $orderId');
        // }
        // }
        log('order status updated');
        notifyListeners();
      },
    );
  }
}
