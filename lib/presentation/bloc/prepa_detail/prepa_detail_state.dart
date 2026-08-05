part of 'prepa_detail_bloc.dart';

enum PrepaDetailStatus { initial, loadingPrepa, loadingTrainings, success, failure }

class PrepaDetailState {
  final String prepaId;
  final PrepaDetailStatus status;
  final Prepa? prepa;
  final Race? race;
  final List<TrainingStep> steps;
  final List<Training> selectedTrainings;
  final String? errorMessage;

  const PrepaDetailState({
    this.prepaId = '',
    this.status = PrepaDetailStatus.initial,
    this.prepa,
    this.race,
    this.steps = const [],
    this.selectedTrainings = const [],
    this.errorMessage,
  });

  PrepaDetailState copyWith({
    PrepaDetailStatus? status,
    Prepa? prepa,
    Race? race,
    List<TrainingStep>? steps,
    List<Training>? selectedTrainings,
    String? errorMessage,
  }) {
    return PrepaDetailState(
      status: status ?? this.status,
      prepa: prepa ?? this.prepa,
      race: race ?? this.race,
      steps: steps ?? this.steps,
      selectedTrainings: selectedTrainings ?? this.selectedTrainings,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}