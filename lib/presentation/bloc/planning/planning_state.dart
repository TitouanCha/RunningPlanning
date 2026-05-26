part of 'planning_bloc.dart';

enum PlanningStatus { loading, loaded, error }

class PlanningState {
  final PlanningStatus status;
  final List<List<CalendarDay>> calendar;
  final Planning dailyProgram;
  final String? errorMsg;

  PlanningState({
    this.status = PlanningStatus.loaded,
    this.calendar = const [],
    this.dailyProgram = const Planning(
      prepa: [],
      steps: [],
      training: [],
      race: [],
    ),
    this.errorMsg,
  });

  PlanningState copyWith({
    PlanningStatus? status,
    List<List<CalendarDay>>? calendar,
    Planning? dailyProgram,
    String? errorMsg,
  }) {
    return PlanningState(
      status: status ?? this.status,
      calendar: calendar ?? this.calendar,
      dailyProgram: dailyProgram ?? this.dailyProgram,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
