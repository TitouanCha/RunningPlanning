

import 'package:flutter/cupertino.dart';
import 'package:running_planning/domain/entities/calendar_day.dart';
import 'package:running_planning/domain/entities/planning.dart';

class DayDetailWidget extends StatelessWidget{
  final Planning dailyProgram;

  const DayDetailWidget({super.key, required this.dailyProgram});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(dailyProgram.steps.length.toString()),
        Text(dailyProgram.training.length.toString()),
        Text(dailyProgram.prepa.length.toString()),
        Text(dailyProgram.race.length.toString())
      ],
    );
  }
}