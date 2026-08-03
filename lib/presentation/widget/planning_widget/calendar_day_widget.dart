import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:running_planning/domain/entities/calendar_day.dart';

bool isSameDay(DateTime a, DateTime b) {
  return a.day == b.day && a.month == b.month && a.year == b.year;
}

class CalendarDayWidget extends StatelessWidget {
  final CalendarDay calendarDay;
  final int index;
  final Function(CalendarDay) onPressed;
  final DateTime selectedDay;

  const CalendarDayWidget({super.key, required this.calendarDay, required this.index, required this.onPressed, required this.selectedDay});

  @override
  Widget build(BuildContext context) {

    final prepa = calendarDay.prepas.isNotEmpty ? calendarDay.prepas.first : null;
    final isLeftPrepa =
        prepa != null && (isSameDay(prepa.startDate, calendarDay.day) || index == 0);
    final isRightPrepa =
        prepa != null && (isSameDay(prepa.endDate, calendarDay.day) || index == 6);

    final steps = calendarDay.steps.isNotEmpty ? calendarDay.steps.first : null;
    final isLeftSteps =
        steps != null && (isSameDay(steps.startDate, calendarDay.day) || index == 0);
    final isRightSteps =
        steps != null && (isSameDay(steps.endDate, calendarDay.day) || index == 6);

    return Padding(
      padding: const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: () => onPressed(calendarDay),
        child: Container(
          alignment: Alignment.center,
          width: 50,
          height: 50,
          child: Padding(
            padding: EdgeInsets.only(
              top: 3,
              bottom: 3,
              left: isLeftPrepa ? 2 : 0,
              right: isRightPrepa ? 2 : 0
            ),
            child: Container(
              decoration: BoxDecoration(
                color: calendarDay.prepas.isNotEmpty
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
                    color: calendarDay.steps.isNotEmpty
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
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSameDay(selectedDay, calendarDay.day)
                          ? Colors.white
                          : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if(calendarDay.races.isNotEmpty)
                          SvgPicture.asset(
                            "assets/icons/cup.svg"
                          )
                        else Text(calendarDay.day.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (calendarDay.trainings.isNotEmpty)
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
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
        ),
      ),
    );
  }
}
