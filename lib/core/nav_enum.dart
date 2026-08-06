
import 'package:flutter/cupertino.dart';
import 'package:running_planning/domain/entities/planning.dart';

import '../presentation/screen/planning_screen.dart';

enum NavEnum {
  planning(label: 'Planning', iconPath: 'assets/icons/calendar.svg'),
  training(label: 'Prepas', iconPath: 'assets/icons/dumbbell.svg'),
  profile(label: 'Profil', iconPath: 'assets/icons/profile.svg'),
  trainingDetail(label: 'Détail entrainement', iconPath: 'assets/icons/dumbbell.svg'),
  prepaDetail(label: 'Détail prépa', iconPath: 'assets/icons/prepa.svg'),
  races(label: 'Courses', iconPath: 'assets/icons/race.svg'),
  raceDetail(label: 'Détail course', iconPath: 'assets/icons/race.svg');

  const NavEnum({required this.label, required this.iconPath});
  final String label;
  final String iconPath;

}