import 'package:dio/dio.dart';
import 'package:running_planning/core/storage/secure_storage.dart';
import 'package:running_planning/data/data_sources/race/race_data_source.dart';
import 'package:running_planning/data/models/race_model.dart';
import 'package:running_planning/domain/entities/race.dart';

import '../../../core/network/dio_client.dart';

class RaceDataSourceImpl extends RaceDataSource {
  final DioClient _client;
  final SecureStorage _secureStorage;

  RaceDataSourceImpl(this._client, this._secureStorage);

  @override
  Future<Race> createRace(CreateRaceModel race) async {
    final userToken = await _secureStorage.getToken();
    final newRace = await _client.dio.post(
      "/race",
      options: Options(headers: {'Authorization': 'Bearer $userToken'}),
      data: {race.toJson()},
    );
    Race createdRace = Race.fromApi(newRace.data);
    return createdRace;
  }

  @override
  Future<Race> getRaceById(String raceId) async {
    final userToken = await _secureStorage.getToken();
    final race = await _client.dio.get(
      "/race/$raceId",
      options: Options(headers: {'Authorization': 'Bearer $userToken'}),
    );
    Race fetchedRace = Race.fromApi(race.data);
    return fetchedRace;
  }

  @override
  Future<List<Race>> getRaces() async {
    final userToken = await _secureStorage.getToken();
    final races = await _client.dio.get(
      "/race",
      options: Options(headers: {'Authorization': 'Bearer $userToken'}),
    );
    List<Race> fetchedRaces = (races.data as List).map((race) => Race.fromApi(race)).toList();
    return fetchedRaces;
  }

  @override
  Future<List<Race>> getUserRaces() async {
    final userToken = await _secureStorage.getToken();
    final races = await _client.dio.get(
      "/race/me",
        options: Options(headers: {'Authorization': 'Bearer $userToken'}),
    );
    List<Race> fetchedRaces = (races.data as List).map((race) => Race.fromApi(race)).toList();
    return fetchedRaces;
  }
}
