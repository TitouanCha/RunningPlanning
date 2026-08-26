part of 'add_steps_bloc.dart';

@immutable
sealed class AddStepsEvent {}

class AddStep extends AddStepsEvent {
  final String stepName;
  final String stepDescription;
  final DateTime startDate;
  final DateTime endDate;

  AddStep({
    required this.stepName,
    required this.stepDescription,
    required this.startDate,
    required this.endDate,
  });
}

class InitStepId extends AddStepsEvent {
  final String prepaId;
  InitStepId({required this.prepaId});
}
