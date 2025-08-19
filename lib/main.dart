import 'package:exodus/core/constants/api/cache_constants.dart';
import 'package:exodus/core/constants/stripe/stripe_key.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/network/models/hive_cache_model.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/routes/route_generator.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/theme/app_theme.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/init/app_initializer.dart';

void main() async {
  await AppInitializer.initializeApp();

  // WidgetsFlutterBinding.ensureInitialized();

  // // Initialize Hive
  // await Hive.initFlutter();

  // // Register Hive adapter (you'll need to generate this)
  // Hive.registerAdapter(HiveCacheModelAdapter());

  // setupServiceLocator();

  // // Open Hive boxes with the correct type
  // await Hive.openBox<HiveCacheModel>(ApiCacheConstants.userCacheKey);

  // // Initialize Stripe
  // Stripe.publishableKey = StripeKey.key;
  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';

  // try {
  //   await Stripe.instance.applySettings();
  // } catch (e) {
  //   dPrint(e);
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exodus',
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      // home: CheckThemeScreen(),
      navigatorKey: NavigationService().navigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorObservers: [RouteObserver<PageRoute>()],
    );
  }
}
