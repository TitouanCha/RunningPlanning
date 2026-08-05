import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/domain/entities/training.dart';
import 'package:running_planning/domain/use_cases/detail/load_race_detail_use_case.dart';

import '../../../domain/entities/prepa.dart';
import '../../../domain/entities/race.dart';
import '../../../domain/entities/step.dart';
import '../../../domain/use_cases/detail/load_prepa_detail_use_case.dart';

part 'prepa_detail_event.dart';

part 'prepa_detail_state.dart';

class PrepaDetailBloc extends Bloc<PrepaDetailEvent, PrepaDetailState> {
  final LoadPrepaDetailUseCase loadPrepa;
  final LoadRaceDetailUseCase loadRace;

  PrepaDetailBloc({ required this.loadPrepa, required this.loadRace}) : super(PrepaDetailState()) {
    on<LoadPrepaDetail>(_onLoadPrepaDetail);
    on<SelectTraining>(_onSelectTraining);
  }

  Future<void> _onLoadPrepaDetail(
      LoadPrepaDetail event,
      Emitter<PrepaDetailState> emit,
      ) async {
    emit(state.copyWith(status: PrepaDetailStatus.loadingPrepa));

    final prepaResult = await loadPrepa(event.prepaId);

    if (prepaResult.isLeft()) {
      emit(state.copyWith(
        status: PrepaDetailStatus.failure,
        errorMessage: "Erreur de chargement des detail de la prepa",
      ));
      return;
    }

    final prepa = prepaResult.getOrElse(() => throw Exception());
    emit(state.copyWith(prepa: prepa));

    final raceResult = await loadRace(prepa.raceId);

    if (raceResult.isLeft()) {
      emit(state.copyWith(
        status: PrepaDetailStatus.failure,
        errorMessage: "Erreur de chargement du detail de la course",
      ));
      return;
    }

    final race = raceResult.getOrElse(() => throw Exception());
    emit(state.copyWith(status: PrepaDetailStatus.success, race: race));
  }

  Future<void> _onSelectTraining(
    SelectTraining event,
    Emitter<PrepaDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedTrainings: List.from(state.selectedTrainings)
          ..add(event.training),
      ),
    );
  }
}
