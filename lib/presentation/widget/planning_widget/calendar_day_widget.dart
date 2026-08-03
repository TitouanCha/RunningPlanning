import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_planning/domain/entities/calendar_day.dart';

bool isSameDay(DateTime a, DateTime b) {
  return a.day == b.day && a.month == b.month && a.year == b.year;
}

class CalendarDayWidget extends StatelessWidget {
  final CalendarDay day;
  final int index;

  const CalendarDayWidget({super.key, required this.day, required this.index});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().day;
    final month = DateTime.now().month;

    final prepa = day.prepas.isNotEmpty ? day.prepas.first : null;
    final isLeftPrepa =
        prepa != null && (isSameDay(prepa.startDate, day.day) || index == 0);
    final isRightPrepa =
        prepa != null && (isSameDay(prepa.endDate, day.day) || index == 6);

    final steps = day.steps.isNotEmpty ? day.steps.first : null;
    final isLeftSteps =
        steps != null && (isSameDay(steps.startDate, day.day) || index == 0);
    final isRightSteps =
        steps != null && (isSameDay(steps.endDate, day.day) || index == 6);

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        alignment: Alignment.center,
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: day.day.day == today && day.day.month == month
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 3,
            bottom: 3,
            left: isLeftPrepa ? 2 : 0,
            right: isRightPrepa ? 2 : 0
          ),
          child: Container(
            decoration: BoxDecoration(
              color: day.prepas.isNotEmpty
                  ? Color(0xFF64B5F6)
                  : Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: isLeftPrepa ? Radius.circular(25) : Radius.zero,
                topRight: isRightPrepa ? Radius.circular(25) : Radius.zero,
                bottomLeft: isLeftPrepa ? Radius.circular(25) : Radius.zero,
                bottomRight: isRightPrepa ? Radius.circular(25) : Radius.zero,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: isLeftSteps ? 5 : 0,
                right: isRightSteps ? 5 : 0,
                top: 5,
                bottom: 5,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: day.steps.isNotEmpty
                      ? Color(0xFFFFF176)
                      : Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: isLeftSteps ? Radius.circular(25) : Radius.zero,
                    topRight: isRightSteps ? Radius.circular(25) : Radius.zero,
                    bottomLeft: isLeftSteps ? Radius.circular(25) : Radius.zero,
                    bottomRight: isRightSteps
                        ? Radius.circular(25)
                        : Radius.zero,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(day.races.isNotEmpty)
                      SvgPicture.asset(
                        "assets/icons/cup.svg"
                      )
                    else Text(day.day.day.toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (day.trainings.isNotEmpty)
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
