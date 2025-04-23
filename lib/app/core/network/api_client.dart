import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:newspaper_app/app/core/network/dio_config.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  /// Generic GET Request
  Future<Map<String, dynamic>> get(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      log('GET $path -> Response: ${response.statusCode}');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      log('GET $path -> Error: ${e.response?.data}');
      throw _extractErrorMessage(e);
    }
  }

  /// GET Request with Cache
  Future<Map<String, dynamic>> getWithCache(
      String path, {
        Duration? cacheDuration,
      }) async {
    try {
      final response =
      await DioService().getWithCache(path, cacheDuration: cacheDuration);
      return response as Map<String, dynamic>;
    } on DioException catch (e) {
      log('GET with Cache $path -> Error: ${e.response?.data}');
      throw _extractErrorMessage(e);
    }
  }

  /// Generic POST Request
  Future<Map<String, dynamic>> post(
      String path, {
        dynamic data,
      }) async {
    try {
      final response = await _dio.post(path, data: data);
      log('POST $path -> Response: ${response.statusCode}');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      log('POST $path -> Error: ${e.response?.data}');
      throw _extractErrorMessage(e);
    }
  }

  /// Generic PUT Request
  Future<Map<String, dynamic>> put(
      String path, {
        dynamic data,
      }) async {
    try {
      final response = await _dio.put(path, data: data);
      log('PUT $path -> Response: ${response.statusCode}');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      log('PUT $path -> Error: ${e.response?.data}');
      throw _extractErrorMessage(e);
    }
  }

///
//   Future<Map<String, dynamic>> put(
//       String path, {
//         dynamic data,
//         Map<String, dynamic>? headers, // Add headers parameter here
//       }) async {
//     try {
//       final response = await _dio.request(
//         path,
//         options: Options(
//           method: 'PUT',
//           headers: headers,
//           contentType: Headers.jsonContentType,
//         ),
//         data: data,
//       );
//       log('PUT $path -> Response: ${response.statusCode}');
//       return response.data as Map<String, dynamic>;
//     } on DioException catch (e) {
//       log('PUT $path -> Error: ${e.response?.data}');
//       throw _extractErrorMessage(e);
//     }
//   }

  /// Generic DELETE Request
  Future<Map<String, dynamic>> delete(
      String path, {
        dynamic data,
      }) async {
    try {
      final response = await _dio.delete(path, data: data);
      log('DELETE $path -> Response: ${response.statusCode}');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      log('DELETE $path -> Error: ${e.response?.data}');
      throw _extractErrorMessage(e);
    }
  }

  /// Private method to extract error message from DioException
  String _extractErrorMessage(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection available';
    }
    if (e.response?.data != null &&
        e.response!.data is Map<String, dynamic> &&
        e.response!.data['message'] != null) {
      return e.response!.data['message']; // Specific message from API
    } else if (e.message != null) {
      return e.message!; // Dio message
    }
    return 'Something went wrong'; // Fallback message
  }
}
