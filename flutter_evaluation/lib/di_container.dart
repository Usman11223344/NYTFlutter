import 'package:dio/dio.dart';
import 'package:flutter_evaluation/data/repository/articles_repo.dart';
import 'package:flutter_evaluation/provider/articles_provider.dart';
import 'package:flutter_evaluation/provider/search_provider.dart';
import 'package:flutter_evaluation/utils/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/dio_client.dart';
import 'data/datasource/logging_interceptor.dart';
import 'data/repository/search_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  // sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(AppConstants.baseURL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(
      () => ArticlesRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => SearchRepo(dioClient: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerFactory(() => ArticlesProvider(articlesRepo: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));

  // Provider
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
