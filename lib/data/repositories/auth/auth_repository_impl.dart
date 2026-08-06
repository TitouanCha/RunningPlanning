import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:running_planning/core/storage/secure_storage.dart';
import 'package:running_planning/domain/entities/loggedUser.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../models/auth_model.dart';
import 'auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;
  final SecureStorage _secureStorage;

  AuthRepositoryImpl(this._dataSource, this._secureStorage);

  @override
  Future<Either<Failure, LoggedUser>> auth(String name, String password) async {
    try {
      final authModel = AuthModel(name: name, password: password);
      final token = await _secureStorage.getToken();
      late final LoggedUser model;

      model = await _dataSource.login(authModel);

      await _secureStorage.saveToken(model.token);
      await _secureStorage.saveUserId(model.id);
      return Right(model);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return Left(UnauthorizedFailure());
      }
      return Left(ServerFailure(e.response?.statusCode ?? 0, e.message ?? ''));
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      }
      return Left(FetchFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final token = await _secureStorage.getToken();
      if (token.isEmpty) {
        return const Right(false);
      }
      return Right(true);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Right(false);
      }
      return Left(ServerFailure(e.response?.statusCode ?? 0, e.message ?? ''));
    } catch (e) {
      return Left(e.toString() as Failure);
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await _secureStorage.deleteToken();
      return const Right(true);
    } catch (e) {
      return Left(e.toString() as Failure);
    }
  }
}
