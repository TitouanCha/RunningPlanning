
import 'package:dartz/dartz.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/domain/entities/step.dart';
import 'package:running_planning/domain/repositories/step_repository.dart';

class LoadPrepaStepsUseCase {
  final StepRepository _repository;
  LoadPrepaStepsUseCase(this._repository);

  Future<Either<Failure, List<TrainingStep>>> call(String prepaId) async {
    return await _repository.getStepsByPrepaId(prepaId);
  }
}