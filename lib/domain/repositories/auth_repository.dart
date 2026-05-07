
import 'package:dartz/dartz.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> auth(String name, String password);
  //Future<Either<Failure, User>> register(String name, String password);
  Future<Either<Failure, bool>> isAuthenticated();
  Future<Either<Failure, void>> logout();
}