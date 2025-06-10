import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/services/payment_service.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentController extends BaseController {
  final PaymentService _paymentService = sl<PaymentService>();

  Future<ApiResult<String>> createPaymentIntent({
    required String userId,
    String? ticketId,
    String? reserveBusId,
    required double amount,
  }) async {
    setLoading(true);
    try {
      final result = await _paymentService.createPaymentIntent(
        userId: userId,
        ticketId: ticketId,
        reserveBusId: reserveBusId,
        amount: amount,
      );
      
      dPrint("Create Payment Intent result: $result");
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
    required BuildContext context,
  }) async {
    setLoading(true);
    try {
      final result = await _paymentService.processPayment(
        clientSecret: clientSecret,
        context: context,
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
      final result = await _paymentService.confirmPayment(paymentIntentId);
      
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
