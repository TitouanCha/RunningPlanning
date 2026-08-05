
import 'package:dartz/dartz.dart';

import 'package:running_planning/core/errors/failures.dart';

import 'package:running_planning/domain/entities/race.dart';

import '../../domain/repositories/race_repository.dart';
import '../data_sources/race/race_data_source.dart';
import '../models/race_model.dart';

class RaceRepositoryImpl extends RaceRepository {
  final RaceDataSource remoteDataSource;
  RaceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Race>> createRace(CreateRaceModel race) async {
    try {
      Race createdRace = await remoteDataSource.createRace(race);
      return Right(createdRace);
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Race>> getRaceById(String raceId) async {
    try {
      Race race = await remoteDataSource.getRaceById(raceId);
      return Right(race);
    } catch (e) {
      if (e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Race>>> getRaces() async {
    try {
      List<Race> races = await remoteDataSource.getRaces();
      return Right(races);
    }catch (e) {
      if (e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Race>>> getUserRaces() async{
    try {
      List<Race> userRaces = await remoteDataSource.getUserRaces();
      return Right(userRaces);
    }catch (e) {
      if (e is NetworkFailure) {
        return Left(FetchFailure(e.message));
      }
      return Left(FetchFailure(e.toString()));
    }
  }
}