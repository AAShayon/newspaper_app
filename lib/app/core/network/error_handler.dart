import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String getMessage(DioException error) {
    if (error.response?.data != null &&
        error.response?.data is Map<String, dynamic> &&
        error.response!.data['message'] != null) {
      return error.response!.data['message']; // Extract message from response
    }

    switch (error.type) {
      case DioExceptionType.cancel:
        return "Request was cancelled";
      case DioExceptionType.connectionTimeout:
        return "Connection timeout occurred";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout occurred";
      case DioExceptionType.sendTimeout:
        return "Send timeout occurred";
      case DioExceptionType.badResponse:
        return "Invalid server response";
      case DioExceptionType.unknown:
        return "No internet connection available";
      case DioExceptionType.connectionError:
        return "Connection error occurred";
      case DioExceptionType.badCertificate:
        return "Certificate error occurred";
      }
  }
}


