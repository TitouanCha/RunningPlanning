part of 'prepa_detail_bloc.dart';

sealed class PrepaDetailEvent {}

class LoadPrepaDetail extends PrepaDetailEvent {
  final String prepaId;

  LoadPrepaDetail({required this.prepaId});
}

class SelectTraining extends PrepaDetailEvent {
  final Training training;

  SelectTraining(this.training);
}

class DeselectTraining extends PrepaDetailEvent {
  final Training training;

  DeselectTraining(this.training);
}

class JoinPrepa extends PrepaDetailEvent {
  final String prepaId;

  JoinPrepa({required this.prepaId});
}

class LeavePrepa extends PrepaDetailEvent {
  final String prepaId;

  LeavePrepa({required this.prepaId});
}
