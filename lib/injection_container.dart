import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:running_planning/core/network/dio_client.dart';
import 'package:running_planning/data/data_sources/prepa/prepa_data_source.dart';
import 'package:running_planning/data/repositories/auth/auth_data_source.dart';
import 'package:running_planning/data/repositories/auth/auth_data_source_impl.dart';
import 'package:running_planning/data/data_sources/planning/planning_data_source_impl.dart';
import 'package:running_planning/data/repositories/planning_repository_impl.dart';
import 'package:running_planning/domain/repositories/auth_repository.dart';
import 'package:running_planning/domain/repositories/planning_repository.dart';
import 'package:running_planning/domain/repositories/prepa_repository.dart';
import 'package:running_planning/domain/repositories/race_repository.dart';
import 'package:running_planning/domain/use_cases/auth/auth_use_case.dart';
import 'package:running_planning/domain/use_cases/detail/load_prepa_detail_use_case.dart';
import 'package:running_planning/domain/use_cases/detail/load_race_detail_use_case.dart';
import 'package:running_planning/domain/use_cases/planning/get_planning_use_case.dart';
import 'package:running_planning/domain/use_cases/planning/load_month_calendar_use_case.dart';
import 'package:running_planning/domain/use_cases/races/get_user_race_use_case.dart';
import 'package:running_planning/presentation/bloc/auth/auth_bloc.dart';
import 'package:running_planning/presentation/bloc/planning/planning_bloc.dart';
import 'package:running_planning/presentation/bloc/prepa_detail/prepa_detail_bloc.dart';
import 'package:running_planning/presentation/bloc/user_race/user_race_bloc.dart';

import 'core/storage/secure_storage.dart';
import 'data/data_sources/planning/planning_data_source.dart';
import 'data/data_sources/prepa/prepa_data_source_impl.dart';
import 'data/data_sources/race/race_data_source.dart';
import 'data/data_sources/race/race_data_source_impl.dart';
import 'data/repositories/auth/auth_repository_impl.dart';
import 'data/repositories/prepa_repository_impl.dart';
import 'data/repositories/race_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => FlutterSecureStorage());

  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton<SecureStorage>(() => SecureStorage());
  sl.registerLazySingleton<AuthDataSource>(() => AuthDatasourceImpl(sl()));
  sl.registerLazySingleton<PlanningDataSource>(
    () => PlanningDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<RaceDataSource>(
    () => RaceDataSourceImpl(sl(), sl()),
  );
  sl.registerLazySingleton<PrepaDataSource>(
    () => PrepaDataSourceImpl(sl(), sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<PlanningRepository>(
    () => PlanningRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<RaceRepository>(
    () => RaceRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<PrepaRepository>(() => PrepaRepositoryImpl(sl()));


  sl.registerLazySingleton(() => AuthUseCase(sl()));
  sl.registerLazySingleton(() => GetPlanningUseCase(sl()));
  sl.registerLazySingleton(() => LoadMonthCalendarUseCase(sl()));
  sl.registerLazySingleton(() => GetUserRaceUseCase(sl()));
  sl.registerLazySingleton(() => LoadPrepaDetailUseCase(sl()));
  sl.registerLazySingleton(() => LoadRaceDetailUseCase(sl()));


  sl.registerLazySingleton(() => AuthBloc(authUseCase: sl()));
  sl.registerLazySingleton(
    () => PlanningBloc(getPlanningUseCase: sl(), loadCalendarUseCase: sl()),
  );
  sl.registerLazySingleton(
    () => UserRaceBloc(getUserRace: sl<GetUserRaceUseCase>()),
  );
  sl.registerFactory(
      () => PrepaDetailBloc(loadPrepa: sl(), loadRace: sl())
  );
}
