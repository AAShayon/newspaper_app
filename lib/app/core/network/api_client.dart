import 'dart:developer';
import 'package:dio/dio.dart';
import '../../config/cache/hive_cache_manager.dart';

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
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final cacheKey = queryParameters != null
          ? '$path?${_generateCacheKey(queryParameters)}'
          : path;

      // Check if data is available in the cache
      final cachedData = await HiveCacheManager.getCache(cacheKey);
      if (cachedData != null) {
        log("Cache hit for $cacheKey");
        return cachedData; // Return cached data
      }

      // If not cached, make the API request
      final response = await _dio.get(path, queryParameters: queryParameters);
      log("API response for $cacheKey: ${response.data}");

      // Save the response to cache
      await HiveCacheManager.saveCache(
        cacheKey,
        response.data as Map<String, dynamic>,
        duration: cacheDuration,
      );

      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      log('GET with Cache $path -> Error: ${e.response?.data}');
      throw _extractErrorMessage(e);
    }
  }

  Future<Response<dynamic>?> getRawResponse(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      log('GET $path -> Response: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      log('GET $path -> Error: ${e.response?.data}');
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

  /// Generate a unique string for query parameters
  String _generateCacheKey(Map<String, dynamic> queryParams) {
    return queryParams.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
  }
}