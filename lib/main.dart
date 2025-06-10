import 'package:exodus/core/constants/api/cache_constants.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/network/models/hive_cache_model.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/routes/route_generator.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Stripe
  Stripe.publishableKey = 'sk_test_51RLzmKCctG7Qj84qUuHfTQkx16eK33EzS585wy4jO9k6jwBFne2VlQCuOuH5k56yO4a0kEV0HbMGY2COkCVpge6q00x97HBQk3';
  await Stripe.instance.applySettings();

  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive adapter (you'll need to generate this)
  Hive.registerAdapter(HiveCacheModelAdapter());

  setupServiceLocator();

  // Open Hive boxes with the correct type
  await Hive.openBox<HiveCacheModel>(ApiCacheConstants.userCacheKey);

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
      // home: CheckThemeScreen(),
      navigatorKey: NavigationService().navigatorKey,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorObservers: [RouteObserver<PageRoute>()],
    );
  }
}
