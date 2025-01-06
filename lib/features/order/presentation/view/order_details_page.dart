
import 'package:e_commerce_admin/features/order/data/model/enum_order.dart';
import 'package:e_commerce_admin/features/order/data/model/order_model.dart';
import 'package:e_commerce_admin/features/order/presentation/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatefulWidget {
  final OrderModel order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    context
        .read<OrderProvider>()
        .updateOrderStatusLocally(widget.order.orderStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    return Consumer<OrderProvider>(builder: (context, orderProvider, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Order Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User ID: ${widget.order.userId ?? "N/A"}'),
              Text('Order ID: ${widget.order.orderId ?? "N/A"}'),
              Text('Order Status: ${widget.order.orderStatus.name}'),
              const SizedBox(height: 16.0),
              const Text('Products:'),
              widget.order.productModel != null
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: widget.order.productModel!.length,
                        itemBuilder: (context, index) {
                          final productId =
                              widget.order.productModel!.keys.elementAt(index);
                          final productDetails =
                              widget.order.productModel![productId]!;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Product ID: $productId'),
                                ...productDetails.entries.map((detail) {
                                  return Text('${detail.key}: ${detail.value}');
                                }).toList(),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  : const Text('No products available'),
              const SizedBox(height: 16.0),
              const Text('Change Order Status:'),
              DropdownButton<OrderStatus>(
                value: orderProvider.orderStatus,
                items: OrderStatus.values.map((OrderStatus status) {
                  return DropdownMenuItem<OrderStatus>(
                    value: status,
                    child: Text(status.name),
                  );
                }).toList(),
                onChanged: (newStatus) {
                  // log(newStatus!.name);
                  if (newStatus != null) {
                    orderProvider.updateOrderStatusLocally(newStatus);
                    orderProvider.updateOrderStatus(
                      orderId: widget.order.orderId!,
                      newStatus: newStatus,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
