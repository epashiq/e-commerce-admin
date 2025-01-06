// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/categories/data/i_category_facade.dart' as _i232;
import '../../features/categories/repo/category_impl.dart' as _i286;
import '../../features/details/data/i_details_facade.dart' as _i865;
import '../../features/details/repo/details_impl.dart' as _i254;
import '../../features/order/data/i_order_facade.dart' as _i266;
import '../../features/order/repo/order_impl.dart' as _i825;
import '../../features/product/data/i_product_facade.dart' as _i656;
import '../../features/product/repo/product_impl.dart' as _i688;
import '../../features/users/data/i_user_facade.dart' as _i848;
import '../../features/users/repo/user_impl.dart' as _i923;
import 'injectable_module.dart' as _i109;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final injectableModule = _$InjectableModule();
  await gh.factoryAsync<_i109.FirebaseServices>(
    () => injectableModule.firebaseServices,
    preResolve: true,
  );
  gh.lazySingleton<_i974.FirebaseFirestore>(
      () => injectableModule.firebaseFirestore);
  gh.lazySingleton<_i865.IDetailsFacade>(() =>
      _i254.DetailsImpl(firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i656.IProductFacade>(() =>
      _i688.ProductImpl(firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i266.IOrderFacade>(
      () => _i825.OrderImpl(firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i848.IUserFacade>(
      () => _i923.UserImpl(firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i232.ICategoryFacade>(() =>
      _i286.CategoryImpl(firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  return getIt;
}

class _$InjectableModule extends _i109.InjectableModule {}
