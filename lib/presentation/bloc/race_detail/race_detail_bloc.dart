import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/domain/entities/prepa.dart';
import 'package:running_planning/domain/use_cases/detail/get_race_detail_use_case.dart';
import 'package:running_planning/domain/use_cases/detail/load_prepa_detail_use_case.dart';

import '../../../domain/entities/race.dart';

part 'race_detail_event.dart';

part 'race_detail_state.dart';

class RaceDetailBloc extends Bloc<RaceDetailEvent, RaceState> {
  final GetRaceDetailUseCase getRaceDetail;
  final LoadPrepaDetailUseCase getPrepaDetail;

  RaceDetailBloc({required this.getRaceDetail, required this.getPrepaDetail}) : super(RaceState()) {
    on<LoadRaceDetail>(_onLoadRace);
  }

  Future<void> _onLoadRace(
    LoadRaceDetail event,
    Emitter<RaceState> emit,
  ) async {
    emit(
      state.copyWith(
        raceId: event.raceId,
        status: RaceDetailStatus.loadingRace,
      ),
    );
    try {
      final raceEither = await getRaceDetail(event.raceId);
      raceEither.fold(
        (failure) => emit(
          state.copyWith(
            status: RaceDetailStatus.error,
            errorMessage: failure.toString(),
          ),
        ),
        (race) =>
            emit(state.copyWith(status: RaceDetailStatus.success, race: race)),
      );
      if(state.race != null) {
        for(final id in state.race!.prepaIds){
          final prepaEither = await getPrepaDetail(id);
          prepaEither.fold(
            (failure) => emit(
              state.copyWith(
                status: RaceDetailStatus.error,
                errorMessage: failure.toString(),
              ),
            ),
            (prepa) {
              final updatedPrepas = List<Prepa>.from(state.prepas)..add(prepa);
              emit(state.copyWith(prepas: updatedPrepas));
            },
          );
        }
      }

    } catch (e) {
      emit(
        state.copyWith(
          status: RaceDetailStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
