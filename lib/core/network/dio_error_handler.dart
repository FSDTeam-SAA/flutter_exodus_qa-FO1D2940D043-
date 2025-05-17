import 'package:dio/dio.dart';

String dioErrorToUserMessage(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return "Connection timed out. Please try again.";
    case DioExceptionType.sendTimeout:
      return "Request timed out. Please check your network.";
    case DioExceptionType.receiveTimeout:
      return "Server took too long to respond.";
    case DioExceptionType.badCertificate:
      return "Invalid server certificate.";
    case DioExceptionType.badResponse:
      return "Server error occurred.";
    case DioExceptionType.cancel:
      return "Request was cancelled.";
    case DioExceptionType.connectionError:
      return "No internet connection.";
    case DioExceptionType.unknown:
      return "Something went wrong. Please try again.";
  }
}
