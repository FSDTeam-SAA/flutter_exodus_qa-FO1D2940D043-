import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/domain/repositories/payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../data/models/payment/payment_response.dart';

class PaymentController extends BaseController {
  final PaymentRepository _paymentRepository;

  PaymentController(this._paymentRepository);

  Future<ApiResult<PaymentResponse>> createPaymentIntent({
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
      
      dPrint("Create Payment Intent result: ${result}");
      return result;
    } catch (e) {
      dPrint("Error creating payment intent: $e");
      return ApiError("An error occurred while creating payment intent");
    } finally {
      setLoading(false);
    }
  }

  Future<ApiResult<PaymentIntent>> processPayment({
    required String clientSecret,
  }) async {
    setLoading(true);
    try {
      final result = await _paymentRepository.processPayment(
        clientSecret: clientSecret,
      );
      
      dPrint("Process Payment result: $result");
      return result;
    } catch (e) {
      dPrint("Error processing payment: $e");
      return ApiError("An error occurred while processing payment");
    } finally {
      setLoading(false);
    }
  }

  Future<ApiResult<bool>> confirmPayment(String paymentIntentId) async {
    setLoading(true);
    try {
      final result = await _paymentRepository.confirmPayment(paymentIntentId);
      
      dPrint("Confirm Payment result: $result");
      return result;
    } catch (e) {
      dPrint("Error confirming payment: $e");
      return ApiError("An error occurred while confirming payment");
    } finally {
      setLoading(false);
    }
  }
}
