import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/payment/payment_response.dart';
import 'package:exodus/domain/repositories/payment_repository.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final ApiClient _apiClient;

  PaymentRepositoryImpl(this._apiClient);

  @override
  Future<ApiResult<PaymentResponse>> createPaymentIntent({
    required String userId,
    String? ticketId,
    String? reserveBusId,
    required double amount,
  }) async {
    try {
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


      // return response;
    } catch (e) {
      dPrint("Error creating payment intent: $e");
      return ApiError("An error occurred while creating payment intent");
    }
  }

  @override
  Future<ApiResult<bool>> confirmPayment(String paymentIntentId) async {
    try {
      final response = await _apiClient.post<bool>(
        ApiEndpoints.confirmPayment,
        data: {'paymentIntentId': paymentIntentId},
        fromJsonT: (_) => true,
      );

      return response;
    } catch (e) {
      dPrint("Error confirming payment: $e");
      return ApiError("An error occurred while confirming payment");
    }
  }

  @override
  Future<ApiResult<PaymentIntent>> processPayment({
    required String clientSecret,
  }) async {
    try {
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
      dPrint('Unexpected error processing payment: $e');
      return ApiError('An error occurred while processing your payment');
    }
  }
}
