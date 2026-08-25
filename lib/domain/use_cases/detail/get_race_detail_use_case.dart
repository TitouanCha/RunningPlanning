
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../entities/race.dart';
import '../../repositories/race_repository.dart';

class GetRaceDetailUseCase {
  final RaceRepository repository;
  GetRaceDetailUseCase(this.repository);

  Future<Either<Failure, Race>> call(String raceId) async {
    return await repository.getRaceById(raceId);
  }
}