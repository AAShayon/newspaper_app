import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:newspaper_app/app/core/network/apiurls.dart';
import '../../config/cache/hive_cache_manager.dart';
import 'interceptors/logger_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

class DioService {
  static final DioService _singleton = DioService._internal();
  late final Dio _dio;

  factory DioService() => _singleton;

  DioService._internal() {
    _setup();
 // Adds authorization headers
  }

  void _setup() {
    log("Dio is initializing...");
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl, // Base URL for the API
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
      ),
    );

    _dio.interceptors.addAll([
      LoggerInterceptor(), // Logs requests and responses
      RetryInterceptor(
        dio: _dio,
        maxRetries: 3, // Retry failed requests 3 times
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
      ),
    ]);
  }

  Dio get instance => _dio;

  /// Custom GET request with Hive-based caching
  Future<dynamic> getWithCache(String path, {Duration? cacheDuration}) async {
    // Check if data is available in the cache
    final cachedData = await HiveCacheManager.getCache(path);
    if (cachedData != null) {
      log("Cache hit for $path");
      return cachedData;
    }

    // If not cached, make the API request
    try {
      final response = await _dio.get(path);
      log("API response for $path: ${response.data}");

      // Save the response to cache
      await HiveCacheManager.saveCache(path, response.data, duration: cacheDuration);
      return response.data;
    } catch (e) {
      log("API error for $path: $e");
      rethrow; // Re-throw the error for further handling
    }
  }

}
