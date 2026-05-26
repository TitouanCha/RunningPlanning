import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:running_planning/presentation/bloc/planning/planning_bloc.dart';

import '../../domain/entities/calendar_day.dart';

int getWeeksIntMonth(int year, int month) {
  DateTime firstDay = DateTime(year, month, 1);
  DateTime lastDay = DateTime(year, month + 1, 0);
  int totalDays = lastDay.day;
  int firstWeekDay = firstDay.weekday;
  return ((totalDays + firstWeekDay - 1) / 7).ceil();
}

class PlanningScreen extends StatelessWidget {
  final DateTime now = DateTime.now();
  final int year;
  final int month;
  final int day;
  final int weekDay;
  final DateTime daysInMonth;
  final DateTime firstDayOfWeek;

  List<String> monthName = [
    "Janvier",
    "Fevrier",
    "Mars",
    "Avril",
    "Mai",
    "Juin",
    "Juillet",
    "Aout",
    "Septembre",
    "Octobre",
    "Novembre",
    "Decembre",
  ];

  PlanningScreen({super.key})
    : year = DateTime.now().year,
      month = DateTime.now().month,
      day = DateTime.now().day,
      weekDay = DateTime.now().weekday,
      daysInMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
      firstDayOfWeek = DateTime.now().subtract(
        Duration(days: DateTime.now().weekday - 1),
      );

  @override
  Widget build(BuildContext context) {
    final weekInMonth = getWeeksIntMonth(year, month);
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: BlocConsumer<PlanningBloc, PlanningState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.status == PlanningStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == PlanningStatus.error) {
            return Center(child: Text("Erreur de chargement du planning : ${state.errorMsg}"));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.rectangle,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_back_ios),
                            ),
                            Text(
                              monthName[month - 1],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              year.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios),
                            ),
                          ],
                        ),
                      ),
                      WeekDaysHeader(),
                      _WeeklyPlanning(planning: state.calendar),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _WeeklyPlanning extends StatelessWidget {
  final List<List<CalendarDay>> planning;

  const _WeeklyPlanning({super.key, required this.planning});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: planning.map((week) {
        return Row(
          children: week.map((day) {
            return Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
              ),
              child: Text(day.day.day.toString()),
            );
          }).toList(),
        );
      }).toList(),
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
