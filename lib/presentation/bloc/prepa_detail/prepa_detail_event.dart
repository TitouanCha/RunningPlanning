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
