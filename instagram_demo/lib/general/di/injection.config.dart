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

import '../../features/comment/data/i_comment_facade.dart' as _i130;
import '../../features/comment/repo/comment_impl.dart' as _i135;
import '../../features/home/data/i_person_facade.dart' as _i253;
import '../../features/home/repo/person_impl.dart' as _i231;
import 'njectable_module.dart' as _i813;

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
  await gh.factoryAsync<_i813.FirebaseServices>(
    () => injectableModule.firebaseServices,
    preResolve: true,
  );
  gh.lazySingleton<_i974.FirebaseFirestore>(
      () => injectableModule.firebaseFirestore);
  gh.lazySingleton<_i130.ICommentFacade>(() =>
      _i135.CommentImpl(firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  gh.lazySingleton<_i253.IPersonFacade>(
      () => _i231.PersonImpl(firebaseFirestore: gh<_i974.FirebaseFirestore>()));
  return getIt;
}

class _$InjectableModule extends _i813.InjectableModule {}
