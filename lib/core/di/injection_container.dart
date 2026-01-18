import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/product_local_datasource.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../core/constants/app_constants.dart';

final getIt = GetIt.instance;

class InjectionContainer {
  static Future<void> init() async {
    // External dependencies
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.apiTimeout,
        receiveTimeout: AppConstants.apiTimeout,
      ),
    );
    getIt.registerLazySingleton<Dio>(() => dio);

    // Data Sources
    final authLocalDataSource = AuthLocalDataSourceImpl(sharedPreferences);
    getIt.registerLazySingleton<AuthLocalDataSource>(() => authLocalDataSource);

    final authRemoteDataSource = AuthRemoteDataSourceImpl(dio);
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => authRemoteDataSource,
    );

    final productLocalDataSource = ProductLocalDataSourceImpl(
      sharedPreferences,
    );
    getIt.registerLazySingleton<ProductLocalDataSource>(
      () => productLocalDataSource,
    );

    final productRemoteDataSource = ProductRemoteDataSourceImpl(dio);
    getIt.registerLazySingleton<ProductRemoteDataSource>(
      () => productRemoteDataSource,
    );

    // Repositories
    final authRepository = AuthRepositoryImpl(
      remoteDataSource: authRemoteDataSource,
      localDataSource: authLocalDataSource,
    );
    getIt.registerLazySingleton<AuthRepository>(() => authRepository);

    final productRepository = ProductRepositoryImpl(
      remoteDataSource: productRemoteDataSource,
      localDataSource: productLocalDataSource,
    );
    getIt.registerLazySingleton<ProductRepository>(() => productRepository);
  }
}
