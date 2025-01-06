// import 'package:e_commerce_admin/features/product/data/model/product_model.dart';
// import 'package:flutter/material.dart';

// class ProductDetailsPage extends StatefulWidget {
//   final ProductModel productModel;
//   const ProductDetailsPage({super.key, required this.productModel});

//   @override
//   State<ProductDetailsPage> createState() => _ProductDetailsPageState();
// }

// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> detailsWidgets =
//         widget.productModel.details.entries.map((entry) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Detail Category: ${entry.key}',
//           ),
//           ...entry.value.entries.map((subEntry) {
//             return Padding(
//               padding: const EdgeInsets.only(left: 16.0),
//               child: Text(
//                 '${subEntry.key}: ${subEntry.value}',
//               ),
//             );
//           }).toList(),
//         ],
//       );
//     }).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Product Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Product: ${widget.productModel.product}',
//             ),
//             Text(
//               'MRP: \$${widget.productModel.mrpPrize}',
//             ),
//             Text(
//               'Offer Price: \$${widget.productModel.offerPrize}',
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Details:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             ...detailsWidgets, 
//           ],
//         ),
//       ),
//     );
//   }
// }
