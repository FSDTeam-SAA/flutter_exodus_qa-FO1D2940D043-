import 'package:exodus/core/utils/debug_logger.dart';

import '../constants/stripe/stripe_key.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeInitializer {
  static Future<void> intiStripe() async {
    Stripe.publishableKey = StripeKey.key;
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';

    try {
      await Stripe.instance.applySettings();
    } catch (e) {
      dPrint(e);
    }
  }
}
