import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/domain/entities/training.dart';
import 'package:running_planning/domain/use_cases/detail/is_user_joined_use_case.dart';
import 'package:running_planning/domain/use_cases/detail/join_prepa_use_case.dart';
import 'package:running_planning/domain/use_cases/detail/load_race_detail_use_case.dart';

import '../../../domain/entities/prepa.dart';
import '../../../domain/entities/race.dart';
import '../../../domain/entities/step.dart';
import '../../../domain/use_cases/detail/is_user_creator_use_case.dart';
import '../../../domain/use_cases/detail/leave_prepa_use_case.dart';
import '../../../domain/use_cases/detail/load_prepa_detail_use_case.dart';
import '../../../domain/use_cases/detail/load_prepa_steps_use_case.dart';

part 'prepa_detail_event.dart';

part 'prepa_detail_state.dart';

class PrepaDetailBloc extends Bloc<PrepaDetailEvent, PrepaDetailState> {
  final LoadPrepaDetailUseCase loadPrepa;
  final LoadRaceDetailUseCase loadRace;
  final LoadPrepaStepsUseCase loadSteps;
  final IsUserJoinedUseCase isUserJoined;
  final IsUserCreatorUseCase isUserCreator;
  final JoinPrepaUseCase joinPrepa;
  final LeavePrepaUseCase leavePrepa;

  PrepaDetailBloc({
    required this.loadPrepa,
    required this.loadRace,
    required this.loadSteps,
    required this.isUserJoined,
    required this.isUserCreator,
    required this.joinPrepa,
    required this.leavePrepa,
  }) : super(PrepaDetailState()) {
    on<LoadPrepaDetail>(_onLoadPrepaDetail);
    on<SelectTraining>(_onSelectTraining);
    on<JoinPrepa>(_onJoinPrepa);
    on<LeavePrepa>(_onLeavePrepa);
  }

  Future<void> _onLoadPrepaDetail(
    LoadPrepaDetail event,
    Emitter<PrepaDetailState> emit,
  ) async {
    emit(state.copyWith(status: PrepaDetailStatus.loadingPrepa));

    final prepaResult = await loadPrepa(event.prepaId);
    if (prepaResult.isLeft()) {
      emit(
        state.copyWith(
          status: PrepaDetailStatus.failure,
          errorMessage: "Erreur de chargement des detail de la prepa",
        ),
      );
      return;
    }
    final prepa = prepaResult.getOrElse(() => throw Exception());
    final isJoined = await isUserJoined(prepa.athletes ?? []);
    final isCreator = await isUserCreator(prepa.creatorId ?? '');
    emit(
      state.copyWith(
        prepa: prepa,
        isUserJoinedPrepa: isJoined,
        isUserCreator: isCreator,
      ),
    );

    final raceResult = await loadRace(prepa.raceId);
    if (raceResult.isLeft()) {
      emit(
        state.copyWith(
          status: PrepaDetailStatus.failure,
          errorMessage: "Erreur de chargement du detail de la course",
        ),
      );
      return;
    }

    final race = raceResult.getOrElse(() => throw Exception());
    emit(state.copyWith(race: race));

    final stepsResult = await loadSteps(prepa.id);
    if (stepsResult.isLeft()) {
      emit(
        state.copyWith(
          status: PrepaDetailStatus.failure,
          errorMessage: "Erreur de chargement des étapes de la prepa",
        ),
      );
      return;
    }

    final trainingSteps = stepsResult.getOrElse(() => throw Exception());
    emit(
      state.copyWith(status: PrepaDetailStatus.success, steps: trainingSteps),
    );
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

  Future<void> _onJoinPrepa(
    JoinPrepa event,
    Emitter<PrepaDetailState> emit,
  ) async {
    final result = await joinPrepa(event.prepaId);
    if(result){
      emit(state.copyWith(isUserJoinedPrepa: true));
    } else {
      emit(
        state.copyWith(
          status: PrepaDetailStatus.failure,
          errorMessage: "Erreur lors de la tentative de rejoindre la prepa",
        ),
      );
    }
  }

  Future<void> _onLeavePrepa(
    LeavePrepa event,
    Emitter<PrepaDetailState> emit,
  ) async {
    final result = await leavePrepa(event.prepaId);
    if(result){
      emit(state.copyWith(isUserJoinedPrepa: false));
    } else {
      emit(
        state.copyWith(
          status: PrepaDetailStatus.failure,
          errorMessage: "Erreur lors de la tentative de quitter la prepa",
        ),
      );
    }
  }
}
