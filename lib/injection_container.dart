
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:running_planning/core/network/dio_client.dart';
import 'package:running_planning/data/repositories/auth/auth_data_source.dart';
import 'package:running_planning/data/repositories/auth/auth_data_source_impl.dart';
import 'package:running_planning/data/repositories/planning/planning_data_source.dart';
import 'package:running_planning/data/repositories/planning/planning_data_source_impl.dart';
import 'package:running_planning/data/repositories/planning/planning_repository_impl.dart';
import 'package:running_planning/domain/repositories/auth_repository.dart';
import 'package:running_planning/domain/repositories/planning_repository.dart';
import 'package:running_planning/domain/use_cases/auth/auth_use_case.dart';
import 'package:running_planning/domain/use_cases/planning/get_planning_use_case.dart';
import 'package:running_planning/domain/use_cases/planning/load_month_calendar_use_case.dart';
import 'package:running_planning/presentation/bloc/auth/auth_bloc.dart';
import 'package:running_planning/presentation/bloc/planning/planning_bloc.dart';

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
  sl.registerLazySingleton<PlanningDataSource>(
          () => PlanningDataSourceImpl(sl())
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<PlanningRepository>(
      () => PlanningRepositoryImpl(sl(), sl())
  );
  
  sl.registerLazySingleton(() => AuthUseCase(sl()));
  sl.registerLazySingleton(() => GetPlanningUseCase(sl()));
  sl.registerLazySingleton(() => LoadMonthCalendarUseCase(sl()));
  
  sl.registerFactory(() => AuthBloc(authUseCase: sl()));
  sl.registerFactory(() => PlanningBloc(getPlanningUseCase: sl(), loadCalendarUseCase: sl()));

}