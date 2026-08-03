import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/domain/entities/calendar_day.dart';
import 'package:running_planning/domain/entities/planning.dart';
import 'package:running_planning/domain/entities/step.dart';
import 'package:running_planning/domain/repositories/planning_repository.dart';

import '../../entities/prepa.dart';
import '../../entities/race.dart';
import '../../entities/training.dart';

class LoadMonthCalendarUseCase {
  final PlanningRepository _repository;

  LoadMonthCalendarUseCase(this._repository);

  Future<Either<Failure, List<List<CalendarDay>>>> loadPlanning(
    DateTime month,
  ) async {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    final DateTime startDate = firstDayOfMonth.subtract(
      Duration(days: firstDayOfMonth.weekday - 1),
    );

    final DateTime endDate = lastDayOfMonth.add(
      Duration(days: 7 - lastDayOfMonth.weekday),
    );

    final Either<Failure, Planning> monthPlanning = await _repository
        .getPlanning(startDate, endDate);

    return monthPlanning.fold((failure) => Left(failure), (planning) {
      final weeks = <List<CalendarDay>>[];

      var currentWeek = <CalendarDay>[];
      var currentDate = startDate;

      while (!currentDate.isAfter(endDate)) {
        final List<Prepa> prepas = planning.prepa
            .where(
              (prepa) =>
                  prepa.startDate.isBefore(currentDate.add(Duration(days: 1))) &&
                  prepa.endDate.isAfter(currentDate),
            )
            .toList();
        final List<Race> races = planning.race
            .where((race) => race.date.day == currentDate.day &&
                race.date.month == currentDate.month)
            .toList();
        final List<TrainingStep> steps = planning.steps
            .where(
              (step) =>
                  step.startDate.isBefore(currentDate.add(Duration(days: 1))) &&
                  step.endDate.isAfter(currentDate),
            )
            .toList();
        final List<Training> trainings = planning.training
            .where((training) =>
              training.startDate.isBefore(currentDate.add(Duration(days: 1))) &&
              training.endDate.isAfter(currentDate)
            ).toList();
        currentWeek.add(
          CalendarDay(
            day: currentDate,
            prepas: prepas,
            races: races,
            steps: steps,
            trainings: trainings,
          ),
        );

        if (currentWeek.length == 7) {
          weeks.add(currentWeek);
          currentWeek = [];
        }

        currentDate = currentDate.add(const Duration(days: 1));
      }
      return Right(weeks);
    });
  }
}
