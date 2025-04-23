import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final List<Duration> retryDelays;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3, // Default retries
    this.retryDelays = const [Duration(seconds: 1), Duration(seconds: 2), Duration(seconds: 3)],
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if the request is retryable
    if (_shouldRetry(err)) {
      log('RetryInterceptor: Retrying request...');
      try {
        final requestOptions = err.requestOptions;
        final retries = requestOptions.extra['retries'] ?? 0;

        if (retries < maxRetries) {
          // Update retry count
          requestOptions.extra['retries'] = retries + 1;

          // Wait before retrying
          await Future.delayed(retryDelays[retries]);

          // Retry the request
          final response = await dio.request(
            requestOptions.path,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers,
            ),
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters,
          );

          return handler.resolve(response);
        }
      } catch (e) {
        log('RetryInterceptor: Retry failed: $e');
        // return handler.reject(err);
      }
    }

    // Pass the error if not retryable or max retries reached
    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    // Retry only for network or server errors (5xx)
    if (err.type == DioExceptionType.connectionError) {
      log('RetryInterceptor: Skipping retry due to connectionError.');
      return false;
    }
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.receiveTimeout ||
        (err.response?.statusCode != null && err.response!.statusCode! >= 500);
  }
}
