import 'package:e_commerce_admin/features/categories/presentation/provider/category_provider.dart';
import 'package:e_commerce_admin/features/product/presentation/add_product_page.dart';
import 'package:e_commerce_admin/features/product/presentation/view/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryProvider.fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add category'),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, category, child) {
          if (category.isLoading && category.categoryList.isEmpty) {
            return const LinearProgressIndicator();
          } else if (category.categoryList.isEmpty) {
            return const Center(
              child: Text('No category available'),
            );
          } else {
            return ListView.builder(
              itemCount: category.categoryList.length,
              itemBuilder: (context, index) {
                final cat = category.categoryList[index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  AddProductPage(categoryId: cat.id!,),
                          ));
                    },
                    child: ListTile(
                      title: Text(cat.name),
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
                title: const Text('Add Catgories'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTextField(
                      hintText: 'Category Name',
                      controller: categoryProvider.nameController,
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cancel')),
                  TextButton(
                      onPressed: () {
                        categoryProvider.addCategory();
                        Navigator.pop(context);
                      },
                      child: const Text('Add')),
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
