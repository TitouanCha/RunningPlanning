import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/domain/use_cases/races/get_user_race_use_case.dart';

import '../../../domain/entities/prepa.dart';
import '../../../domain/entities/race.dart';

part 'user_race_event.dart';

part 'user_race_state.dart';

class UserRaceBloc extends Bloc<UserRaceEvent, UserRaceState> {
  final GetUserRaceUseCase getUserRace;

  UserRaceBloc({required this.getUserRace}) : super(UserRaceState()) {
    on<LoadUserRaces>(_onLoadUserRaces);
    on<TogglePastRaceDisplayed>((event, emit) {
      emit(state.copyWith(isPastRaceDisplayed: !state.isPastRaceDisplayed));
    });
  }

  Future<void> _onLoadUserRaces(
    LoadUserRaces event,
    Emitter<UserRaceState> emit,
  ) async {
    emit(state.copyWith(status: event.isActiveRaces ? UserRaceStatus.loadingNextRace : UserRaceStatus.loadingPastRace));
    final result = await getUserRace(event.isActiveRaces);
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: UserRaceStatus.error,
          errorMessage: failure.toString(),
        ),
      ),
      (prepas) {
        if (event.isActiveRaces) {
          emit(
            state.copyWith(
              status: UserRaceStatus.success,
              userNextPrepa: prepas,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: UserRaceStatus.success,
              userPastPrepa: prepas,
            ),
          );
        }
      },
    );
  }
}
