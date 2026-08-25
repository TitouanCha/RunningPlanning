import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:running_planning/domain/use_cases/races/get_new_races_use_case.dart';

import '../../../domain/entities/race.dart';

part 'races_event.dart';

part 'races_state.dart';

class RacesBloc extends Bloc<RacesEvent, RacesState> {
  final GetNewRacesUseCase getRacesUseCase;

  RacesBloc({required this.getRacesUseCase}) : super(RacesState()) {
    on<LoadRaces>(_onLoadRaces);
    on<SearchRaces>(_onSearchRaces);
    on<SortRaces>(_onSortRaces);
  }

  Future<void> _onLoadRaces(LoadRaces event, Emitter<RacesState> emit) async {
    emit(state.copyWith(status: RaceStatus.loadingRace));
    try {
      final racesEither = await getRacesUseCase();
      racesEither.fold(
        (failure) => emit(
          state.copyWith(
            status: RaceStatus.error,
            errorMessage: failure.toString(),
          ),
        ),
        (races) => emit(
          state.copyWith(
            status: RaceStatus.success,
            allRaces: races,
            races: races,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: RaceStatus.error, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onSearchRaces(SearchRaces event, Emitter<RacesState> emit) async {
    final query = event.query.toLowerCase();
    final filtered = state.allRaces.where((prepa) => prepa.name.toLowerCase().contains(query)).toList();
    emit(state.copyWith(races: filtered));
  }

  Future<void> _onSortRaces(SortRaces event, Emitter<RacesState> emit) async {
    List<Race> sorted = List.from(state.races);
    switch (event.sort) {
      case RaceListSort.dateDesc:
        sorted.sort((a, b) => b.date.compareTo(a.date));
        break;
      case RaceListSort.dateAsc:
        sorted.sort((a, b) => a.date.compareTo(b.date));
        break;
      case RaceListSort.nameAsc:
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case RaceListSort.nameDesc:
        sorted.sort((a, b) => b.name.compareTo(a.name));
        break;
      case RaceListSort.durationAsc:
        sorted.sort((a, b) => a.distance.compareTo(b.distance));
        break;
      case RaceListSort.durationDesc:
        sorted.sort((a, b) => b.distance.compareTo(a.distance));
        break;
    }
    emit(state.copyWith(races: sorted));
  }
}
