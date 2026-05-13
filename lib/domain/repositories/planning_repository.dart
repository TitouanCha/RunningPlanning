
import 'package:running_planning/domain/entities/planning.dart';

abstract interface class PlanningRepository {
  Future<Program> getPlannings();
}