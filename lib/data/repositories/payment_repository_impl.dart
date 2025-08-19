import 'package:dartz/dartz.dart';
import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/constants/app/app_colors.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/network/models/network_failure.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/payment/payment_response.dart';
import 'package:exodus/domain/repositories/payment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../core/network/network_result.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final ApiClient _apiClient;

  PaymentRepositoryImpl(this._apiClient);

  @override
  NetworkResult<PaymentResponse> createPaymentIntent({
    required String userId,
    String? ticketId,
    String? reserveBusId,
    required double amount,
  }) async {
    return await _apiClient.post<PaymentResponse>(
      ApiEndpoints.createPayment,
      data: {
        'userId': userId,
        'ticketId': ticketId,
        'ReserveBusId': reserveBusId,
        'amount': amount,
      },
      fromJsonT: (json) => PaymentResponse.fromJson(json),
    );
  }

  @override
  NetworkResult<bool> confirmPayment(String paymentIntentId) async {
    final response = await _apiClient.post<bool>(
      ApiEndpoints.confirmPayment,
      data: {'paymentIntentId': paymentIntentId},
      fromJsonT: (_) => true,
    );

    return response;
  }

  @override
  NetworkResult<PaymentIntent> processPayment({
    required String clientSecret,
  }) async {
    try {
      // Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Exodus Transport',
          style: ThemeMode.system,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(primary: AppColors.secondary),
          ),
        ),
      );

      // Present the payment sheet
      await Stripe.instance.presentPaymentSheet();

      // If we reach here, payment was successful
      // Retrieve the payment intent to get the details
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(
        clientSecret,
      );

      return Right(paymentIntent);
    } on StripeException catch (e) {
      dPrint('Stripe error: ${e.error.localizedMessage}');
      return Left(
        UnknownFailure(message: e.error.localizedMessage ?? 'Payment failed'),
      );
    } catch (e) {
      dPrint('Unexpected error processing payment: $e');
      return Left(
        UnknownFailure(
          message: 'An error occurred while processing your payment',
        ),
      );
    }
  }
}
