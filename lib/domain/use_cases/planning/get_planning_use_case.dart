import 'package:dartz/dartz.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/domain/entities/planning.dart';
import 'package:running_planning/domain/repositories/planning_repository.dart';

class GetPlanningUseCase {
  final PlanningRepository _repository;

  GetPlanningUseCase(this._repository);

  Future<Either<Failure, Planning>> getPlanning(
    DateTime startDate,
    DateTime endDate,
  ) => _repository.getPlanning(startDate, endDate);
}
