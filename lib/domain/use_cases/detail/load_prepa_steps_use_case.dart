import 'package:dartz/dartz.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/domain/entities/step.dart';
import 'package:running_planning/domain/repositories/step_repository.dart';

class LoadPrepaStepsUseCase {
  final StepRepository _repository;

  LoadPrepaStepsUseCase(this._repository);

  Future<Either<Failure, List<TrainingStep>>> call(String prepaId) async {
    final result = await _repository.getStepsByPrepaId(prepaId);
    return result.fold((failure) => Left(failure), (steps) {
      final sortedSteps = List<TrainingStep>.from(steps)
        ..sort((a, b) => a.startDate.compareTo(b.startDate));
      final sortedResult = sortedSteps.map((step) {
        return step.checkStep(isDone: step.endDate.isBefore(DateTime.now()));
      }).toList();
      return Right(sortedResult);
    });
  }
}
