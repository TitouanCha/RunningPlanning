part of 'races_bloc.dart';

enum RaceStatus { initial, loadingRace, success, error }

enum RaceListSort {
  dateDesc,
  dateAsc,
  nameAsc,
  nameDesc,
  durationAsc,
  durationDesc;

  String get label => switch (this) {
    RaceListSort.dateDesc => 'Date (récente)',
    RaceListSort.dateAsc => 'Date (ancienne)',
    RaceListSort.nameAsc => 'Nom (A → Z)',
    RaceListSort.nameDesc => 'Nom (Z → A)',
    RaceListSort.durationAsc => 'Durée (courte)',
    RaceListSort.durationDesc => 'Durée (longue)',
  };
}

class RacesState {
  final RaceStatus status;
  final List<Race> allRaces;
  final List<Race> races;
  final String? errorMessage;

  const RacesState({
    this.status = RaceStatus.loadingRace,
    this.allRaces = const [],
    this.races = const [],
    this.errorMessage,
  });

  RacesState copyWith({
    RaceStatus? status,
    List<Race>? allRaces,
    List<Race>? races,
    String? errorMessage,
  }) {
    return RacesState(
      status: status ?? this.status,
      allRaces: allRaces ?? this.allRaces,
      races: races ?? this.races,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
