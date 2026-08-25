part of 'race_detail_bloc.dart';


enum RaceDetailStatus { initial, loadingRace, success, error }
class RaceState {
  final RaceDetailStatus status;
  final String raceId;
  final Race? race;
  final bool isFavorite;
  final List<Prepa> prepas;
  final String? errorMessage;

  const RaceState({
    this.status = RaceDetailStatus.loadingRace,
    this.raceId = '',
    this.race,
    this.isFavorite = false,
    this.prepas = const [],
    this.errorMessage,
  });

  RaceState copyWith({
    String? raceId,
    Race? race,
    bool? isFavorite,
    List<Prepa>? prepas,
    RaceDetailStatus? status,
    String? errorMessage,
  }){
    return RaceState(
      raceId: raceId ?? this.raceId,
      race: race ?? this.race,
      isFavorite: isFavorite ?? this.isFavorite,
      prepas: prepas ?? this.prepas,
      status: status ?? this.status,
    );
  }
}
