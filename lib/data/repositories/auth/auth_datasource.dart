
import 'package:running_planning/data/models/auth_model.dart';

import '../../../domain/entities/user.dart';

abstract interface class AuthDataSource {
  Future<User> login(AuthModel authModel);
  Future<User> register(AuthModel authModel);
  Future<User> me(String userToken);
}