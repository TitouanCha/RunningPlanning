part of 'race_detail_bloc.dart';

sealed class RaceDetailEvent {}

class LoadRaceDetail extends RaceDetailEvent {
  final String raceId;
  LoadRaceDetail({required this.raceId});
}
