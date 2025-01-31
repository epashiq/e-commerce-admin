

import 'package:e_commerce_admin/general/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt sl = GetIt.instance;

@InjectableInit(
  initializerName : 'init',
  preferRelativeImports : true,
  asExtension : false,
)

Future<void> configureDependency()async{
  await init(sl,environment:Environment.prod);
}