
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../repositories/prepa_repository.dart';

class JoinPrepaUseCase {
  final PrepaRepository repository;
  JoinPrepaUseCase(this.repository);

  Future<bool> call(String prepaId) async {
    final result = await repository.joinPrepa(prepaId);
    return result.fold(
      (failure) => false,
      (_) => true,
    );
  }
}