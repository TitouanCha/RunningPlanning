import 'dart:core';
import 'dart:ffi';

import 'package:running_planning/domain/entities/loggedUser.dart';
import 'package:running_planning/domain/enums/race_type.dart';

class Race {
  final String id;
  final String name;
  final DateTime date;
  final RaceType type;
  final int distance;
  final String location;
  final String description;
  final List<String> prepaIds;

  Race({
    required this.id,
    required this.name,
    required this.date,
    required this.type,
    required this.distance,
    required this.location,
    required this.description,
    required this.prepaIds,
  });

  factory Race.fromApi(Map<String, dynamic> json){
    return Race(
        id: json['_id'] as String? ?? 'Aucune données cahrgé',
        name: json['name'] as String? ?? 'Aucune données cahrgé',
        date: DateTime.parse(json['date'] as String? ?? '2004-12-16'),
        type: RaceType.values.firstWhere(
              (e) => e.name.toLowerCase() == (json['type'] as String? ?? '').toLowerCase(),
          orElse: () => RaceType.other,
        ),
        distance: json['distance'] as int? ?? 0,
        location: json['location'] as String? ?? 'Aucune données chargé',
        description: json['description'] as String? ?? 'Aucune données chargé',
        prepaIds: (json['idPrepa'] as List<dynamic>? ?? []).map((e) => e.toString()).toList()
    );
  }
}