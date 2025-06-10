import 'package:dio/dio.dart';
import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';

class PaymentService {
  final Dio _dio;

  PaymentService(this._dio);

  Future<ApiResult<String>> createPaymentIntent({
    required String userId,
    String? ticketId,
    String? reserveBusId,
    required double amount,
  }) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.createPayment}',
        data: {
          'userId': userId,
          'ticketId': ticketId,
          'ReserveBusId': reserveBusId,
          'amount': amount,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        final clientSecret = response.data['clientSecret'] as String;
        return ApiSuccess(clientSecret);
      } else {
        return ApiError(response.data['error'] ?? 'Failed to create payment intent');
      }
    } catch (e) {
      dPrint('Error creating payment intent: $e');
      return ApiError('An error occurred while processing your payment');
    }
  }

  Future<ApiResult<bool>> confirmPayment(String paymentIntentId) async {
    try {
      final response = await _dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.confirmPayment}',
        data: {
          'paymentIntentId': paymentIntentId,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return ApiSuccess(true);
      } else {
        return ApiError(response.data['error'] ?? 'Failed to confirm payment');
      }
    } catch (e) {
      dPrint('Error confirming payment: $e');
      return ApiError('An error occurred while confirming your payment');
    }
  }

  Future<ApiResult<PaymentIntent>> processPayment({
    required String clientSecret,
    required BuildContext context,
  }) async {
    try {
      // Confirm the payment with the Stripe SDK
      final paymentIntent = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      return ApiSuccess(paymentIntent);
    } on StripeException catch (e) {
      dPrint('Stripe error: ${e.error.localizedMessage}');
      return ApiError(e.error.localizedMessage ?? 'Payment failed');
    } catch (e) {
      dPrint('Error processing payment: $e');
      return ApiError('An error occurred while processing your payment');
    }
  }
}
