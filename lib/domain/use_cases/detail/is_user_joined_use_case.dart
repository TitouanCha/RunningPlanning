
import 'package:running_planning/core/storage/secure_storage.dart';

import '../../entities/User.dart';

class IsUserJoinedUseCase {
  final SecureStorage _secureStorage;
  IsUserJoinedUseCase(this._secureStorage);

  Future<bool> call(List<User> joinedUsers) async {
    final userId = await _secureStorage.getUserId();
    return joinedUsers.any((u) => u.id == userId);
  }
}