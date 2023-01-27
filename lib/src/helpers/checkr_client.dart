import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_checkr/flutter_checkr.dart';

class CheckrClient {
  final CheckrEnvironment environment;
  final String secretKey;
  final Dio _dio;

  CheckrClient({required this.environment, required this.secretKey})
      : _dio = Dio(BaseOptions(baseUrl: environment.baseUrl))
          ..interceptors.add(
            LogInterceptor(
              request: false,
              requestBody: true,
              responseHeader: false,
              responseBody: true,
            ),
          );

  Future<Response<dynamic>> request({
    required String path,
    required String method,
    dynamic data,
  }) async {
    try {
      return await _dio.request(
        path,
        data: data,
        options: Options(
          method: method,
          headers: <String, String>{
            'Authorization': 'Basic ${base64.encode(utf8.encode(secretKey))}'
          },
        ),
      );
    } on DioError catch (e) {
      Response<dynamic>? response = e.response;
      if (response != null) {
        return response;
      } else {
        throw CheckrException(e.error);
      }
    } catch (e) {
      throw CheckrException(e.toString());
    }
  }
}
