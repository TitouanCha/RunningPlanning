import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:running_planning/domain/entities/calendar_day.dart';
import 'package:running_planning/domain/entities/planning.dart';
import 'package:running_planning/domain/use_cases/planning/get_planning_use_case.dart';

import '../../../domain/use_cases/planning/load_month_calendar_use_case.dart';

part 'planning_event.dart';

part 'planning_state.dart';

class PlanningBloc extends Bloc<PlanningEvent, PlanningState> {
  final GetPlanningUseCase getPlanningUseCase;
  final LoadMonthCalendarUseCase loadCalendarUseCase;

  PlanningBloc({
    required this.getPlanningUseCase,
    required this.loadCalendarUseCase,
  }) : super(PlanningState()) {
    on<SwitchMonth>(_onSwitchMonth);
    on<SelectDay>(_onSelectDay);
    on<LoadCalendar>(_onLoadCalendar);
  }

  Future<void> _onSwitchMonth(
    SwitchMonth event,
    Emitter<PlanningState> emit,
  ) async {
    await _onLoadCalendar(LoadCalendar(date: event.month), emit);
  }

  Future<void> _onSelectDay(
    SelectDay event,
    Emitter<PlanningState> emit,
  ) async {
    try {
      final dailyProgram = await _loadDailyProgram(event.day);
      emit(
        state.copyWith(
          status: PlanningStatus.loaded,
          selectedDate: event.day,
          dailyProgram: dailyProgram,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PlanningStatus.error));
    }
  }

  Future<void> _onLoadCalendar(
    LoadCalendar event,
    Emitter<PlanningState> emit,
  ) async {
    final today = DateTime.now();
    emit(state.copyWith(status: PlanningStatus.loading));
    try {
      final result = await loadCalendarUseCase.loadPlanning(event.date);
      if (result.isLeft()) {
        final failure = result.swap().getOrElse(() => throw Exception());
        emit(
          state.copyWith(
            status: PlanningStatus.error,
            errorMsg: failure.message,
          ),
        );
        return;
      }
      final calendar = result.getOrElse(() => []);
      final dailyProgram = await _loadDailyProgram(today);
      emit(
        state.copyWith(
          status: PlanningStatus.loaded,
          calendar: calendar,
          dailyProgram: dailyProgram,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: PlanningStatus.error, errorMsg: e.toString()),
      );
    }
  }

  Future<Planning> _loadDailyProgram(DateTime day) async {
    final dailyProgram = await getPlanningUseCase.getPlanning(day, day);

    return dailyProgram.fold(
      (_) => Planning(prepa: [], steps: [], training: [], race: []),
      (data) => data,
    );
  }
}
