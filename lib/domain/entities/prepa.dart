import 'package:running_planning/domain/entities/User.dart';
import 'package:running_planning/domain/enums/race_type.dart';

class Prepa {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final int prepaDuration;
  final String raceName;
  final DateTime raceDate;
  final RaceType raceType;
  final int raceDistance;
  final String raceId;
  final List<User>? athletes;
  final String? creatorId;

  Prepa({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.prepaDuration,
    required this.raceName,
    required this.raceDate,
    required this.raceType,
    required this.raceDistance,
    required this.raceId,
    this.athletes,
    this.creatorId,
  });

  factory Prepa.fromApi(Map<String, dynamic> json) {
    final startDateFromApi = DateTime.parse(json['startDate'] as String? ?? '2004-12-16');
    final endDateFromApi = DateTime.parse(json['endDate'] as String? ?? '2004-12-16');
    final durationFromApi = endDateFromApi.difference(startDateFromApi);
    final durationDays = durationFromApi.inDays;
    return Prepa(
      id: json['_id'] as String? ?? 'Aucune données cahrgé',
      name: json['name'] as String? ?? 'Aucune données cahrgé',
      startDate: startDateFromApi,
      endDate: endDateFromApi,
      prepaDuration: durationDays,
      raceName: json['idRace']['name'] as String? ?? 'Aucune données cahrgé',
      raceDate: DateTime.parse(json['idRace']['date'] as String? ?? '2004-12-16'),
      raceType: RaceType.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['idRace']['type'] as String? ?? '').toLowerCase(),
        orElse: () => RaceType.other,
      ),
      raceId: json['idRace']['_id'] as String? ?? 'Aucune données cahrgé',
      raceDistance: json['idRace']['distance'] as int? ?? 0,
      athletes: (json['userList'] as List<dynamic>?)
          ?.map((user) => User.fromApi(user as Map<String, dynamic>))
          .toList() ?? [],
      creatorId: json['createdBy']["_id"] as String? ?? 'Aucune données cahrgé',
    );
  }
}
