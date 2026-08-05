
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/race.dart';
import '../../repositories/race_repository.dart';

class LoadRaceDetailUseCase {
  final RaceRepository _raceRepository;
  LoadRaceDetailUseCase(this._raceRepository);

  Future<Either<Failure, Race>> call(String raceId) async {
    return await _raceRepository.getRaceById(raceId);
  }
}