import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_planning/presentation/widget/planning_widget/calendar_day_widget.dart';

import '../../../domain/entities/calendar_day.dart';

class WeeklyPlanning extends StatelessWidget {
  final List<List<CalendarDay>> planning;
  final Function(CalendarDay) onDaySelected;
  final DateTime selectedDay;

  const WeeklyPlanning({
    super.key,
    required this.planning,
    required this.onDaySelected,
    required this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WeekDaysHeader(),
        ...planning.map((week) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: week.asMap().entries.map((entry) {
              return CalendarDayWidget(
                calendarDay: entry.value,
                index: entry.key,
                onPressed: onDaySelected,
                selectedDay: selectedDay,
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}

class WeekDaysHeader extends StatelessWidget {
  const WeekDaysHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const days = ["L", "Ma", "Me", "J", "V", "S", "D"];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: days.map((day) {
        return Column(
          children: [
            Container(
              alignment: Alignment.center,
              width: 50,
              height: 20,
              child: Text(day, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        );
      }).toList(),
    );
  }
}
