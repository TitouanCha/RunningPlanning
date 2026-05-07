import 'package:dio/dio.dart';

class DioClient {
  late final Dio _dio;

  DioClient(){
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:3001',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
        },
      )
    );

    _dio.interceptors.add(
      LogInterceptor(responseBody: true),
    );
  }

  Dio get dio => _dio;
}