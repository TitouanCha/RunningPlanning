import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/core/storage/secure_storage.dart';

import 'package:running_planning/domain/entities/planning.dart';

import '../../domain/repositories/planning_repository.dart';
import '../data_sources/planning/planning_data_source.dart';

class PlanningRepositoryImpl extends PlanningRepository {
  final PlanningDataSource _dataSource;
  final SecureStorage _secureStorage;

  PlanningRepositoryImpl(this._dataSource, this._secureStorage);

  @override
  Future<Either<Failure, Planning>> getPlanning(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final userToken = await _secureStorage.getToken();
      final Planning planning = await _dataSource.getPlanning(
        startDate,
        endDate,
        userToken,
      );
      return Right(planning);
    } on DioException catch (e) {
      return Left(FetchFailure(e.message ?? 'Erreur réseau'));
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }
  }
}
