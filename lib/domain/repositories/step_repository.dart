
import 'package:dartz/dartz.dart';
import 'package:running_planning/core/errors/failures.dart';

import '../entities/step.dart';

abstract class StepRepository {
  Future<Either<Failure,TrainingStep>> getStepById(String id);
  Future<Either<Failure,List<TrainingStep>>> getStepsByPrepaId(String prepaId);
  Future<Either<Failure,TrainingStep>> createPrepaStep(TrainingStep step, String prepaId);
}