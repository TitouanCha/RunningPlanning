import 'package:dartz/dartz.dart';
import 'package:running_planning/domain/entities/calendar_day.dart';
import 'package:running_planning/domain/entities/planning.dart';

import '../../core/errors/failures.dart';

abstract class PlanningRepository {
  Future<Either<Failure, Planning>> getPlanning(
    DateTime startDate,
    DateTime endDate,
  );
}
