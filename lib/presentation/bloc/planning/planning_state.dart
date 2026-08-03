part of 'planning_bloc.dart';

enum PlanningStatus { loading, loaded, error }

class PlanningState {
  final PlanningStatus status;
  final List<List<CalendarDay>> calendar;
  final Planning dailyProgram;
  final DateTime selectedDate;
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
    DateTime? selectedDate,
    this.errorMsg,
  }) : selectedDate = selectedDate ?? DateTime.now();

  PlanningState copyWith({
    PlanningStatus? status,
    List<List<CalendarDay>>? calendar,
    Planning? dailyProgram,
    DateTime? selectedDate,
    String? errorMsg,
  }) {
    return PlanningState(
      status: status ?? this.status,
      calendar: calendar ?? this.calendar,
      dailyProgram: dailyProgram ?? this.dailyProgram,
      selectedDate: selectedDate ?? this.selectedDate,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
