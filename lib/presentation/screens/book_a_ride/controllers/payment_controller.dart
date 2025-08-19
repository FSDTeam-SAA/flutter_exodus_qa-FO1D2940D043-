import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/network/network_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/domain/repositories/payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../data/models/payment/payment_response.dart';

class PaymentController extends BaseController {
  final PaymentRepository _paymentRepository;

  PaymentController(this._paymentRepository);

  NetworkResult<PaymentResponse> createPaymentIntent({
    required String userId,
    required String ticketId,
    required String reserveBusId,
    required double amount,
  }) async {
    setLoading(true);
    try {
      final result = await _paymentRepository.createPaymentIntent(
        userId: userId,
        ticketId: ticketId,
        reserveBusId: reserveBusId,
        amount: amount,
      );

      if (result.isLeft()) {
        setError("An error occurred while creating payment intent");
      }

      dPrint("Create Payment Intent result: ${result}");
      return result;
    } finally {
      setLoading(false);
    }
  }

  NetworkResult<PaymentIntent> processPayment({
    required String clientSecret,
  }) async {
    setLoading(true);
    try {
      final result = await _paymentRepository.processPayment(
        clientSecret: clientSecret,
      );

      dPrint("Process Payment result: $result");
      return result;
    } finally {
      setLoading(false);
    }
  }

  NetworkResult<bool> confirmPayment(String paymentIntentId) async {
    setLoading(true);
    try {
      final result = await _paymentRepository.confirmPayment(paymentIntentId);

      dPrint("Confirm Payment result: $result");
      return result;
    } finally {
      setLoading(false);
    }
  }
}
