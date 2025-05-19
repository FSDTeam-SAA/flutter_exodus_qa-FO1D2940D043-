import 'package:exodus/core/constants/api/cache_constants.dart';
import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/network/models/hive_cache_model.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/routes/route_generator.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/utils/extensions/button_extensions.dart';
import 'package:exodus/core/utils/extensions/input_decoration_extensions.dart';
import 'package:exodus/core/theme/app_theme.dart';
import 'package:exodus/presentation/widgets/app_logo.dart';
import 'package:exodus/presentation/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

class CheckThemeScreen extends StatelessWidget {
  const CheckThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(height: 120),
            SizedBox(height: 20),

            AppLogo(height: 50),
            SizedBox(height: 20),

            ElevatedButton(
              // style: context.primaryButton,
              onPressed: () {},
              child: Text("Button"),
            ),

            SizedBox(height: 20),
            context.secondaryButton(onPressed: () {}, text: "Login Test"),

            // ElevatedButton(
            //   style: context.secondaryButton,
            //   onPressed: () {},
            //   child: Text(
            //     "Button body large",
            //     style: Theme.of(context).textTheme.bodyLarge,
            //   ),
            // ),
            SizedBox(height: 20),
            ElevatedButton(
              style: context.primaryOutline,
              onPressed: () {},
              child: Text("Button"),
            ),

            SizedBox(height: 20),

            // ElevatedButton(
            //   style: context.errorOutline,
            //   onPressed: () {},
            //   child: Text("Button"),
            // ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                // style: context.primaryButton,
                onPressed: () {},
                child: Text(
                  "Button 2",
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 20),
            TextFormField(
              onEditingComplete: () => NextFocusAction(),
              decoration: context.primaryInputDecoration.copyWith(
                hintText: "test",
              ),
            ),

            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: TextFormField(
                onEditingComplete: () => NextFocusAction(),
                decoration: context.primaryInputDecoration.copyWith(
                  hintText: "test",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
