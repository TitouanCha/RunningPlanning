

import 'package:dio/dio.dart';
import 'package:flutter/src/material/stepper.dart';
import 'package:running_planning/core/network/dio_client.dart';
import 'package:running_planning/data/data_sources/prepa/prepa_data_source.dart';
import 'package:running_planning/data/models/add_step_model.dart';
import 'package:running_planning/domain/entities/prepa.dart';
import 'package:running_planning/domain/entities/step.dart';

import '../../../core/storage/secure_storage.dart';

class PrepaDataSourceImpl extends PrepaDataSource{
  final DioClient _client;
  final SecureStorage _secureStorage;

  PrepaDataSourceImpl(this._client, this._secureStorage);

  @override
  Future<Prepa> createPrepa(Prepa prepa) async {
    // TODO: implement createPrepa
    throw UnimplementedError();
  }

  @override
  Future<Prepa> getPrepaById(String prepaId) async {
    final userToken = await _secureStorage.getToken();
    return await _client.dio.get(
      "/prepa/$prepaId",
      options: Options(headers: {'Authorization': 'Bearer $userToken'}),
    ).then((response) {
      return Prepa.fromApi(response.data);
    });
  }

  @override
  Future<List<Prepa>> getPrepas() async {
    final userToken = await _secureStorage.getToken();
    return await _client.dio.get(
      "/prepa",
      options: Options(headers: {'Authorization': 'Bearer $userToken'}),
    ).then((response) {
      return (response.data as List).map((prepa) => Prepa.fromApi(prepa)).toList();
    });
  }

  @override
  Future<List<Prepa>> getUserPrepas() async{
    final userToken = await _secureStorage.getToken();
    return await _client.dio.get(
      "/prepa/me",
      options: Options(headers: {'Authorization': 'Bearer $userToken'}),
    ).then((response) {
      return (response.data as List).map((prepa) => Prepa.fromApi(prepa)).toList();
    });
  }

  @override
  Future<void> joinPrepa(String prepaId) async {
    final userToken = await _secureStorage.getToken();
    return await _client.dio.patch(
          "/prepa/$prepaId/runners/me",
          options: Options(headers: {'Authorization': 'Bearer $userToken'}),
    ).then((response) {
      return;
    });
  }

  @override
  Future<void> leavePrepa(String prepaId) async {
    final userToken = await _secureStorage.getToken();
    return _client.dio.delete(
      "/prepa/$prepaId/runners/me",
      options: Options(headers: {'Authorization': 'Bearer $userToken'}),
    ).then((response) {
      return;
    });
  }

  @override
  Future<List<TrainingStep>> addSteps(String prepaId, List<AddStepModel> steps) async {
    final userToken = await _secureStorage.getToken();
    return _client.dio.post(
      "/prepa/$prepaId/steps",
      data: steps.map((step) => step.toJson()).toList(),
      options: Options(headers: {'Authorization': 'Bearer $userToken'}),
    ).then((response) {
      return (response.data as List<dynamic>)
          .map((step) => TrainingStep.fromApi(step as Map<String, dynamic>))
          .toList();
    });
  }
}