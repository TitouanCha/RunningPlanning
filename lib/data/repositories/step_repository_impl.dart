

import 'package:dartz/dartz.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/domain/entities/step.dart';

import '../../domain/repositories/step_repository.dart';
import '../data_sources/step/step_data_source.dart';

class StepRepositoryImpl extends StepRepository {
  final StepDataSources _dataSource;
  StepRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, TrainingStep>> createPrepaStep(TrainingStep step, String prepaId) {
    // TODO: implement createPrepaStep
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TrainingStep>> getStepById(String id) async {
    try {
      final TrainingStep step = await _dataSource.getStepById(id);
      return Right(step);
    } catch (e) {
      if(e is NetworkFailure) {
        return Future.value(Left(FetchFailure(e.message)));
      }
      return Future.value(Left(FetchFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<TrainingStep>>> getStepsByPrepaId(String prepaId) async {
    try {
      List<TrainingStep> steps = await _dataSource.getStepsByPrepaId(prepaId);
      return Right(steps);
    } catch (e) {
      if(e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }
  }

}