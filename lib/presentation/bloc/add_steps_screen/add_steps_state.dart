part of 'add_steps_bloc.dart';

enum StepStatus { initial, loading, success, failure }

class AddStepsState {
  final String stepId;
  final StepStatus stepStatus;
  final String? errorMessage;

  AddStepsState({
    this.stepId = '',
    this.stepStatus = StepStatus.initial,
    this.errorMessage,
  });

  AddStepsState copyWith({
    String? stepId,
    StepStatus? stepStatus,
    String? errorMessage,
  }) {
    return AddStepsState(
      stepId: stepId ?? this.stepId,
      stepStatus: stepStatus ?? this.stepStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
