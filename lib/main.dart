import 'package:e_commerce_admin/features/categories/data/i_category_facade.dart';
import 'package:e_commerce_admin/features/categories/presentation/provider/category_provider.dart';
import 'package:e_commerce_admin/features/details/data/i_details_facade.dart';
import 'package:e_commerce_admin/features/details/presentation/provider/details_provider.dart';
import 'package:e_commerce_admin/features/home/presentation/view/home_page.dart';
import 'package:e_commerce_admin/features/order/data/i_order_facade.dart';
import 'package:e_commerce_admin/features/order/presentation/provider/order_provider.dart';
import 'package:e_commerce_admin/features/product/data/i_product_facade.dart';
import 'package:e_commerce_admin/features/product/presentation/provider/product_provider.dart';
import 'package:e_commerce_admin/features/users/data/i_user_facade.dart';
import 'package:e_commerce_admin/features/users/presentation/provider/user_provider.dart';
import 'package:e_commerce_admin/general/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                CategoryProvider(iCategoryFacade: sl<ICategoryFacade>())),
        ChangeNotifierProvider(
            create: (_) =>
                ProductProvider(iProductFacade: sl<IProductFacade>())),
        ChangeNotifierProvider(
            create: (_) =>
                DetailsProvider(iDetailsFacade: sl<IDetailsFacade>())),
        ChangeNotifierProvider(
            create: (_) => UserProvider(iUserFacade: sl<IUserFacade>())),
            ChangeNotifierProvider(create: (_)=> OrderProvider(iOrderFacade: sl<IOrderFacade>()))
       
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
