import 'package:exodus/core/network/api_result.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../data/models/payment/payment_response.dart';

abstract class PaymentRepository {
  Future<ApiResult<PaymentResponse>> createPaymentIntent({
    required String userId,
    String? ticketId,
    String? reserveBusId,
    required double amount,
  });

  Future<ApiResult<bool>> confirmPayment(String paymentIntentId);

  Future<ApiResult<PaymentIntent>> processPayment({
    required String clientSecret,
    // required BuildContext context,
  });
}
