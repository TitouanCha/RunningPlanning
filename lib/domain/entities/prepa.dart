import 'package:running_planning/domain/entities/User.dart';
import 'package:running_planning/domain/enums/race_type.dart';

class Prepa {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String raceName;
  final DateTime raceDate;
  final RaceType raceType;
  final String raceId;
  final List<User>? athletes;

  Prepa({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.raceName,
    required this.raceDate,
    required this.raceType,
    required this.raceId,
    this.athletes,
  });

  factory Prepa.fromApi(Map<String, dynamic> json) {
    return Prepa(
      id: json['_id'] as String? ?? 'Aucune données cahrgé',
      name: json['name'] as String? ?? 'Aucune données cahrgé',
      startDate: DateTime.parse(json['startDate'] as String? ?? '2004-12-16'),
      endDate: DateTime.parse(json['endDate'] as String? ?? '2004-12-16'),
      raceName: json['idRace']['name'] as String? ?? 'Aucune données cahrgé',
      raceDate: DateTime.parse(json['idRace']['date'] as String? ?? '2004-12-16'),
      raceType: RaceType.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['idRace']['type'] as String? ?? '').toLowerCase(),
        orElse: () => RaceType.other,
      ),
      raceId: json['idRace']['_id'] as String? ?? 'Aucune données cahrgé',
      athletes: (json['userList'] as List<dynamic>?)
          ?.map((user) => User.fromApi(user as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}
