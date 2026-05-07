
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:running_planning/core/network/dio_client.dart';
import 'package:running_planning/data/repositories/auth/auth_datasource.dart';
import 'package:running_planning/data/repositories/auth/auth_datasource_impl.dart';
import 'package:running_planning/domain/repositories/auth_repository.dart';
import 'package:running_planning/domain/use_cases/auth/auth_use_case.dart';
import 'package:running_planning/presentation/bloc/auth/auth_bloc.dart';

import 'core/storage/secure_storage.dart';
import 'data/repositories/auth/auth_repository_impl.dart';

final sl = GetIt.instance;


Future<void> init() async {

  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FlutterSecureStorage());

  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton<SecureStorage>(
    () => SecureStorage(),
  );
  sl.registerLazySingleton<AuthDataSource>(
      () => AuthDatasourceImpl(sl())
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()
    ),
  );
  
  sl.registerLazySingleton(() => AuthUseCase(sl()));
  
  sl.registerFactory(() => AuthBloc(authUseCase: sl()));

}