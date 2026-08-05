
import 'package:running_planning/domain/entities/planning.dart';

abstract class PlanningDataSource {
  Future<Planning> getPlanning(DateTime startDate, DateTime endDate, String userToken);
}