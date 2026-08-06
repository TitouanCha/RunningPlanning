
import 'package:running_planning/core/storage/secure_storage.dart';

class IsUserCreatorUseCase {
  final SecureStorage _secureStorage;
  IsUserCreatorUseCase(this._secureStorage);

  Future<bool> call(String creatorId) async {
    final userId = await _secureStorage.getUserId();
    return userId == creatorId;
  }
}