

import 'package:dartz/dartz.dart';
import 'package:running_planning/domain/entities/loggedUser.dart';
import 'package:running_planning/domain/repositories/auth_repository.dart';

import '../../../core/errors/failures.dart';

class AuthUseCase {
  final AuthRepository _repository;
  AuthUseCase(this._repository);

  Future<Either<Failure, LoggedUser>> auth(String email, String password) =>
      _repository.auth(email, password);
}