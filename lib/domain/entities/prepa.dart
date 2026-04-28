
import 'package:running_planning/domain/entities/user.dart';

class Prepa {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String raceName;
  final String raceDate;
  final String raceId;
  final List<User> athletes;

  Prepa({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.raceName,
    required this.raceDate,
    required this.raceId,
    required this.athletes,
  });
}