
import 'dart:core';
import 'dart:ffi';

import 'package:running_planning/domain/entities/user.dart';
import 'package:running_planning/domain/enums/race_type.dart';

class Race {
  final String id;
  final String name;
  final DateTime date;
  final RaceType type;
  final Int distance;
  final String location;
  final String prepaId;
  final String prepaName;
  final String prepaStartDate;
  final List<User> userList;

  Race({
    required this.id,
    required this.name,
    required this.date,
    required this.type,
    required this.distance,
    required this.location,
    required this.prepaId,
    required this.prepaName,
    required this.prepaStartDate,
    required this.userList,
  });
}