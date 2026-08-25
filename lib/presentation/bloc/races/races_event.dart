part of 'races_bloc.dart';

@immutable
sealed class RacesEvent {}

class LoadRaces extends RacesEvent {
}

class SearchRaces extends RacesEvent {
  final String query;

  SearchRaces({required this.query});
}

class SortRaces extends RacesEvent {
  final RaceListSort sort;
  SortRaces({required this.sort});
}
