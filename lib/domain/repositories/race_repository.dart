
import 'package:dartz/dartz.dart';
import 'package:running_planning/core/errors/failures.dart';
import 'package:running_planning/data/models/race_model.dart';
import '../entities/race.dart';

abstract class RaceRepository {
  Future<Either<Failure, Race>> createRace(CreateRaceModel race);
  Future<Either<Failure, List<Race>>> getRaces();
  Future<Either<Failure, Race>> getRaceById(String raceId);
  Future<Either<Failure, List<Race>>> getUserRaces();
}