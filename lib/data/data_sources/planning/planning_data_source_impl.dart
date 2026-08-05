

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:running_planning/core/network/dio_client.dart';
import 'package:running_planning/data/data_sources/planning/planning_data_source.dart';
import 'package:running_planning/domain/entities/planning.dart';

import '../../../core/errors/failures.dart';

class PlanningDataSourceImpl implements PlanningDataSource {
  final DioClient _client;
  PlanningDataSourceImpl(this._client);

  @override
  Future<Planning> getPlanning(DateTime startDate, DateTime endDate, String userToken) async{
    try{
      final String formattedStartDate = DateFormat('dd/MM/yyyy').format(startDate);
      final String formattedEndDate = DateFormat('dd/MM/yyyy').format(endDate);
      final response = await _client.dio.get("/planning",
          options: Options(
            headers: {'Authorization' : 'Bearer $userToken'},
          ),
          queryParameters: {
            'startDate' : formattedStartDate,
            'endDate' : formattedEndDate
          }
      );
      Planning planning = Planning.fromApi(response.data);
      return planning;
    }
    on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        throw UnauthorizedFailure();
      }
      throw NetworkFailure(e.message ?? 'Erreur réseau inconnue');
    }
    catch (e) {
      throw NetworkFailure(e.toString());
    }
  }
}