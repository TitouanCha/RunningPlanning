import 'package:dartz/dartz.dart';
import 'package:running_planning/domain/entities/prepa.dart';
import 'package:running_planning/domain/repositories/prepa_repository.dart';

import '../../../core/errors/failures.dart';

class GetUserRaceUseCase {
  final PrepaRepository _repository;

  GetUserRaceUseCase(this._repository);

  Future<Either<Failure, List<Prepa>>> call(bool activeRace) async {
    final DateTime now = DateTime.now();
    
    final result = await _repository.getUserPrepas();
    return result.fold((failure) => Left(failure), (prepas) {
      final List<Prepa> activeRaces;
      if (activeRace) {
        activeRaces = prepas.where((prepa) => prepa.raceDate.isAfter(now)).toList();
      } else {
        activeRaces = prepas.where((race) => race.raceDate.isBefore(now)).toList();
      }
      activeRaces.sort((a, b) => a.raceDate.compareTo(b.raceDate));
      return Right(activeRaces);
    });
  }
}
