import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:running_planning/domain/repositories/auth_repository.dart';

import '../../../domain/use_cases/auth/auth_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthUseCase authUseCase;

  AuthBloc({
    required this.authUseCase,
  }) : super(AuthState()) {
    on<AuthEvent>(_onAuth);
  }

  Future<void> _onAuth(
    AuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (event is Login) {
      emit(state.copyWith(status: AuthStatus.loading));
      try {
        await authUseCase.auth(event.username, event.password);
        emit(state.copyWith(status: AuthStatus.authenticated));
      } catch (error) {
        emit(state.copyWith(status: AuthStatus.error));
      }
    }
  }
}
