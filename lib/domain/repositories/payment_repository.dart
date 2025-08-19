import 'package:exodus/core/network/api_result.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../core/network/network_result.dart';
import '../../data/models/payment/payment_response.dart';

abstract class PaymentRepository {
  NetworkResult<PaymentResponse> createPaymentIntent({
    required String userId,
    String? ticketId,
    String? reserveBusId,
    required double amount,
  });

  NetworkResult<bool> confirmPayment(String paymentIntentId);

  NetworkResult<PaymentIntent> processPayment({
    required String clientSecret,
    // required BuildContext context,
  });
}
