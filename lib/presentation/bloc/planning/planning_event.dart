part of 'planning_bloc.dart';

@immutable
sealed class PlanningEvent {}

final class SwitchMonth extends PlanningEvent{
  final DateTime month;
  SwitchMonth({required this.month});
}

final class SelectDay extends PlanningEvent{
  final DateTime day;
  SelectDay({required this.day});
}

final class LoadCalendar extends PlanningEvent{
  final DateTime date;
  LoadCalendar({required this.date});
}
