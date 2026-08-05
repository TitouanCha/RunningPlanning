
import 'package:running_planning/data/models/race_model.dart';

import '../../../../domain/entities/race.dart';

abstract class RaceDataSource {
  Future<Race> createRace(CreateRaceModel race);
  Future<List<Race>> getRaces();
  Future<List<Race>> getUserRaces();
  Future<Race> getRaceById(String raceId);
}
