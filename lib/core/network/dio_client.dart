import 'package:dio/dio.dart';

class DioClient {
  final _dio = Dio();

  DioClient._private() {
    _dio.options
      ..connectTimeout = Duration(seconds: 4)
      ..receiveTimeout = Duration(seconds: 4)
      ..baseUrl = "https://api.escuelajs.co/api/v1";
  }

  static final _singletonConstructor = DioClient._private();

  factory DioClient() {
    return _singletonConstructor;
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParams,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> add(
      {required String url, Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(url, data: data);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> update(
      {required String url, Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
      {required String url, Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
