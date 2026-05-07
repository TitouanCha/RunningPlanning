
import 'package:dio/dio.dart';
import 'package:running_planning/core/network/dio_client.dart';
import 'package:running_planning/data/repositories/auth/auth_datasource.dart';
import 'package:running_planning/domain/entities/user.dart';

import '../../models/auth_model.dart';

class AuthDatasourceImpl implements AuthDataSource {
  final DioClient _client;
  AuthDatasourceImpl(this._client);

  @override
  Future<User> login(AuthModel authModel) async {
    final response = await _client.dio.post('/auth/login', data: {
        authModel
    });
    User user = User.fromApi(response.data);
    return user;
  }

  @override
  Future<User> register(AuthModel authModel) async {
    final response = await _client.dio.post('/auth/register', data: {
      authModel
    });
    User user = User.fromApi(response.data);
    return user;
  }

  @override
  Future<User> me(String userToken) async {
    final response = await _client.dio.get(
      '/auth/me',
      options: Options(
        headers: {'Authorization': 'Bearer $userToken'},
      ),
    );
    User user = User.fromApi(response.data);
    return user;
  }
}