import 'package:e_commerce_admin/features/details/presentation/view/detail_page.dart';
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
      productProvider.fetchProducts(widget.categoryId);
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
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 3,
              ),
              itemCount: product.productList.length,
              itemBuilder: (context, index) {
                final pro = product.productList[index];
                final discountPercentage =
                    productProvider.calculateDiscountPercentage(
                  mrp: pro.mrpPrize.toInt(),
                  offerPrice: pro.offerPrize.toInt(),
                );

                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            productId: pro.id!,
                          ),
                        ));
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Product: ${pro.product}'),
                        Text('MRP: \$${pro.mrpPrize}'),
                        Text('Offer Price: \$${pro.offerPrize}'),
                        Text(
                            'Discount: ${discountPercentage.toStringAsFixed(2)}%'),
                      ],
                    ),
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
                      hintText: 'Product Name',
                    ),
                    CustomTextField(
                      controller: productProvider.offerPrizeController,
                      hintText: 'Offer Price',
                    ),
                    CustomTextField(
                      controller: productProvider.mrpPrizeController,
                      hintText: 'MRP Price',
                    ),
                    CustomTextField(
                      controller: productProvider.descreptionController,
                      hintText: 'Description',
                    ),
                    CustomTextField(
                      controller: productProvider.stockController,
                      hintText: 'Stock',
                    ),
                    CustomTextField(
                      hintText: 'Color',
                      controller: productProvider.colourController,
                    ),
                    CustomTextField(
                      hintText: 'Material',
                      controller: productProvider.materialController,
                    ),
                    CustomTextField(
                      hintText: 'Production',
                      controller: productProvider.productionController,
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        productProvider.addProduct(
                          colour: productProvider.colourController.text,
                          material: productProvider.materialController.text,
                          production: productProvider.productController.text,
                          categoryId: widget.categoryId,
                        );
                        // PopScopeLoad.addShowDialog(context, 'Add product');
                        Navigator.pop(context);
                      },
                      child: const Text('Add')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
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
