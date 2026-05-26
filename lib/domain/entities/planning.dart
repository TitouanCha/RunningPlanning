import 'package:running_planning/domain/entities/prepa.dart';
import 'package:running_planning/domain/entities/race.dart';
import 'package:running_planning/domain/entities/step.dart';
import 'package:running_planning/domain/entities/training.dart';

final class Planning {
  final List<Prepa> prepa;
  final List<TrainingStep> steps;
  final List<Training> training;
  final List<Race> race;

  const Planning({
    required this.prepa,
    required this.steps,
    required this.training,
    required this.race,
  });

  factory Planning.fromApi(Map<String, dynamic> json) {
    final jsonPrepas = json['prepas'] as List<dynamic>;
    final List<Prepa> prepas = jsonPrepas
        .map((jsonPrepa) => Prepa.fromApi(jsonPrepa))
        .toList();
    final jsonRaces = json['race'] as List<dynamic>;
    final List<Race> races = jsonRaces
        .map((race) => Race.fromApi(race))
        .toList();
    final jsonTrainingSteps = json['steps'] as List<dynamic>;
    final List<TrainingStep> trainingSteps = jsonTrainingSteps
        .map((step) => TrainingStep.fromApi(step))
        .toList();
    final jsonTrainings = json['training'] as List<dynamic>;
    final List<Training> trainings = jsonTrainings
        .map((training) => Training.fromApi(training))
        .toList();

    return Planning(
      prepa: prepas,
      race: races,
      steps: trainingSteps,
      training: trainings,
    );
  }
}
