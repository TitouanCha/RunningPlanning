import 'package:dartz/dartz.dart';
import 'package:running_planning/core/errors/failures.dart';

import '../../entities/race.dart';
import '../../repositories/race_repository.dart';

class GetNewRacesUseCase {
  final RaceRepository raceRepository;

  GetNewRacesUseCase(this.raceRepository);

  Future<Either<Failure, List<Race>>> call() async {
    final result = await raceRepository.getRaces();
    return result.fold(
      (failure) => Left(failure),
      (races) => Right(
        races
            .where((race) => race.date.isAfter(DateTime.now()))
            .toList()
            .reversed
            .toList(),
      ),
    );
  }
}
