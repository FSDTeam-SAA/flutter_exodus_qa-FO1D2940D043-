import 'package:exodus/core/utils/debug_logger.dart';

class PaymentResponse {
  final String transactionId;

  PaymentResponse({required this.transactionId});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    dPrint("PaymentResponse json -> $json");
    return PaymentResponse(
      transactionId: json['transactionId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
    };
  }
}