

import 'package:dartz/dartz.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/domain/entities/prepa.dart';

import '../../repositories/prepa_repository.dart';

class LoadPrepaDetailUseCase {
  final PrepaRepository _prepaRepository;
  LoadPrepaDetailUseCase(this._prepaRepository);

  Future<Either<Failure,Prepa>> call(String prepaId) async {
    return await _prepaRepository.getPrepaById(prepaId);
  }
}