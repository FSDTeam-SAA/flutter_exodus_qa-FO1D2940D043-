import 'package:exodus/core/utils/debug_logger.dart';

class BaseResponse<T> {
  final bool success;
  final String message;
  final T? data;

  BaseResponse({required this.success, required this.message, this.data});

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    dPrint("Base Response -> ${json['message']}");
    return BaseResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
