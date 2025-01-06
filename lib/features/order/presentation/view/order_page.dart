import 'package:e_commerce_admin/features/order/presentation/provider/order_provider.dart';
import 'package:e_commerce_admin/features/order/presentation/view/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      orderProvider.clearOrderList();
      orderProvider.fetchOrders();
      // orderProvider.clearOrderList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderPro, child) {
          if (orderPro.orderList.isEmpty) {
            return const Center(
              child: Text('No orders available'),
            );
          } else {
            return ListView.builder(
              itemCount: orderPro.orderList.length,
              itemBuilder: (context, index) {
                final order = orderPro.orderList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  OrderDetailsPage(order: order,),
                        ));
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User ID: ${order.userId ?? "N/A"}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Order ID: ${order.orderId ?? "N/A"}',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 14)),
                          const SizedBox(height: 8.0),
                          // const Text(
                          //   'Products:',
                          //   style: TextStyle(
                          //       fontSize: 16, fontWeight: FontWeight.bold),
                          // ),
                          // const SizedBox(height: 8.0),
                          // ...order.productModel?.entries.map((product) {
                          //       final productId = product.key;
                          //       final productDetails = product.value;

                          //       return Padding(
                          //         padding:
                          //             const EdgeInsets.symmetric(vertical: 4.0),
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.start,
                          //           children: [
                          //             Text('Product ID: $productId',
                          //                 style: const TextStyle(
                          //                     fontWeight: FontWeight.bold)),
                          //             ...productDetails.entries.map((detail) {
                          //               return Text(
                          //                   '${detail.key}: ${detail.value}');
                          //             }).toList(),
                          //           ],
                          //         ),
                          //       );
                          //     }).toList() ??
                          //     [const Text('No products available')],
                          Text(order.orderStatus.name),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
