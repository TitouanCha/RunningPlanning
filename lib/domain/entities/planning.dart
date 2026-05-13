import 'package:running_planning/domain/entities/prepa.dart';
import 'package:running_planning/domain/entities/race.dart';
import 'package:running_planning/domain/entities/training.dart';

class Program {
  final List<Prepa> prepa;
  final List<Training> training;
  final List<Race> race;

  Program({required this.prepa, required this.training, required this.race});
}
