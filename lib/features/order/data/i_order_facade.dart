import 'package:dartz/dartz.dart';
import 'package:e_commerce_admin/features/order/data/model/enum_order.dart';
import 'package:e_commerce_admin/features/order/data/model/order_model.dart';
import 'package:e_commerce_admin/general/failures/main_failures.dart';

abstract class IOrderFacade {
  Future<Either<MainFailure, List<OrderModel>>> fetchOrders() async {
    throw UnimplementedError('error');
  }

  Future<Either<MainFailure, Unit>> updateOrderStatus(
      {required String orderId, required OrderStatus newStatus}) async {
    throw UnimplementedError('error');
  }
}
