
import 'package:running_planning/domain/repositories/prepa_repository.dart';

class LeavePrepaUseCase {
  final PrepaRepository _repository;
  LeavePrepaUseCase(this._repository);

  Future<bool> call(String prepaId) async {
    final result = await _repository.leavePrepa(prepaId);
    return result.fold(
      (failure) => false,
      (_) => true,
    );
  }

}