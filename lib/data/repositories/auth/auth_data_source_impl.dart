
import 'package:dio/dio.dart';
import 'package:running_planning/core/network/dio_client.dart';
import 'package:running_planning/data/repositories/auth/auth_data_source.dart';
import 'package:running_planning/domain/entities/loggedUser.dart';

import '../../models/auth_model.dart';

class AuthDatasourceImpl implements AuthDataSource {
  final DioClient _client;
  AuthDatasourceImpl(this._client);

  @override
  Future<LoggedUser> login(AuthModel authModel) async {
    final response = await _client.dio.post('/auth/login', data: {
      'name': authModel.name,
      'password': authModel.password,
    });
    LoggedUser user = LoggedUser.fromApi(response.data);
    return user;
  }

  @override
  Future<LoggedUser> register(AuthModel authModel) async {
    final response = await _client.dio.post('/auth', data: {
      'name': authModel.name,
      'password': authModel.password,
    });
    LoggedUser user = LoggedUser.fromApi(response.data);
    return user;
  }

  @override
  Future<LoggedUser> me(String userToken) async {
    final response = await _client.dio.get(
      '/auth/me',
      options: Options(
        headers: {'Authorization': 'Bearer $userToken'},
      ),
    );
    LoggedUser user = LoggedUser.fromApi(response.data);
    return user;
  }
}