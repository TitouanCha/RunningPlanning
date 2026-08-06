import 'package:dio/dio.dart';
import 'package:running_planning/core/network/dio_client.dart';
import 'package:running_planning/core/storage/secure_storage.dart';
import 'package:running_planning/data/data_sources/step/step_data_source.dart';

import '../../../domain/entities/step.dart';

class StepDataSourceImpl extends StepDataSources {
  final DioClient _client;
  final SecureStorage _secureStorage;

  StepDataSourceImpl(this._client, this._secureStorage);

  @override
  Future<TrainingStep> createPrepaStep(TrainingStep step, String prepaId) {
    // TODO: implement createPrepaStep
    throw UnimplementedError();
  }

  @override
  Future<TrainingStep> getStepById(String id) async {
    final String useToken = await _secureStorage.getToken();
    final result = await _client.dio.get(
      '/steps/$id',
      options: Options(headers: {'Authorization': 'Bearer $useToken'}),
    );
    TrainingStep fetchedStep = TrainingStep.fromApi(result.data);
    return fetchedStep;
  }

  @override
  Future<List<TrainingStep>> getStepsByPrepaId(String prepaId) async {
    final String useToken = await _secureStorage.getToken();
    final result = await _client.dio.get(
      '/prepa/$prepaId/steps',
      options: Options(headers: {'Authorization': 'Bearer $useToken'}),
    );
    List<TrainingStep> fetchedSteps = (result.data['steps'] as List)
        .map((step) => TrainingStep.fromApi(step))
        .toList();
    return fetchedSteps;
  }
}
