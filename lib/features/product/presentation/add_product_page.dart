import 'package:e_commerce_admin/features/product/presentation/provider/product_provider.dart';
import 'package:e_commerce_admin/features/product/presentation/view/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  final String categoryId;
  const AddProductPage({super.key, required this.categoryId});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      productProvider.fetchProducts();
      productProvider.clearExpenseList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add products'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, product, child) {
          if (product.isLoading && product.productList.isEmpty) {
            return const LinearProgressIndicator();
          } else if (product.productList.isEmpty) {
            return const Text('No products available');
          } else {
            return ListView.builder(
              itemCount: product.productList.length,
              itemBuilder: (context, index) {
                final pro = product.productList[index];
                final discountPercentage =
                    productProvider.calculateDiscountPercentage(
                  mrp: pro.mrpPrize.toInt(),
                  offerPrice: pro.offerPrize.toInt(),
                );

                return Card(
                  child: Column(
                    children: [
                      Text('Product: ${pro.product}'),
                      Text('MRP: \$${pro.mrpPrize}'),
                      Text('Offer Price: \$${pro.offerPrize}'),
                      Text(
                          'Discount: ${discountPercentage.toStringAsFixed(2)}%'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      controller: productProvider.productController,
                      hintText: 'products',
                    ),
                    CustomTextField(
                      controller: productProvider.offerPrizeController,
                      hintText: 'offer prize',
                    ),
                    CustomTextField(
                      controller: productProvider.mrpPrizeController,
                      hintText: 'mrp prize',
                    ),
                    CustomTextField(
                      controller: productProvider.descreptionController,
                      hintText: 'descreption',
                    ),
                    CustomTextField(
                      controller: productProvider.stockController,
                      hintText: 'Stock',
                    ),
                    CustomTextField(
                      hintText: 'colour',
                      controller: productProvider.colourController,
                    ),
                    CustomTextField(
                      hintText: 'colour',
                      controller: productProvider.materialController,
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        productProvider.addProduct(
                            categoryId: widget.categoryId,
                            colour: productProvider.colourController.text,
                            material: productProvider.materialController.text);

                        Navigator.pop(context);
                      },
                      child: const Text('Add')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cancel')),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
