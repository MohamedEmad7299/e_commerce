import 'package:e_commerce/data/cache_helper/cache_helper.dart';
import 'package:e_commerce/network/dio_helper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<DioHelper>(() => DioHelper());
  getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
}
