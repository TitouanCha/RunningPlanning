
import 'package:running_planning/data/models/auth_model.dart';

import '../../../domain/entities/loggedUser.dart';

abstract interface class AuthDataSource {
  Future<LoggedUser> login(AuthModel authModel);
  Future<LoggedUser> register(AuthModel authModel);
  Future<LoggedUser> me(String userToken);
}