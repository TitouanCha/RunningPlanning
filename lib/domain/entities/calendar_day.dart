import 'package:running_planning/domain/entities/prepa.dart';
import 'package:running_planning/domain/entities/race.dart';
import 'package:running_planning/domain/entities/step.dart';
import 'package:running_planning/domain/entities/training.dart';

class CalendarDay {
  final DateTime day;
  final List<Prepa> prepas;
  final List<Race> races;
  final List<TrainingStep> steps;
  final List<Training> trainings;

  CalendarDay({
    required this.day,
    required this.prepas,
    required this.races,
    required this.steps,
    required this.trainings,
  });
}
