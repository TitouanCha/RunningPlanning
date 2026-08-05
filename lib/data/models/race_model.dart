
import 'package:running_planning/domain/enums/race_type.dart';

class CreateRaceModel {
  final String name;
  final RaceType type;
  final DateTime date;
  final int distance;
  final String location;
  final String description;


  CreateRaceModel({
    required this.name,
    required this.type,
    required this.date,
    required this.distance,
    required this.location,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type.toString().split('.').last,
      'date': date.toIso8601String(),
      'distance': distance,
      'location': location,
      'description': description,
    };
  }
}