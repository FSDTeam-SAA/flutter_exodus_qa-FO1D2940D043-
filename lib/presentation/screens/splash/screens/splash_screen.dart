import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/domain/usecases/auth/check_auth_status_usecase.dart';
import 'package:exodus/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 2));

    // Check auth status and navigate
    final role = await sl<CheckAuthStatusUsecase>().call();

    if (mounted) {
      if (role == null) {
        // Navigate to login if token or role is invalid
        NavigationService().freshStartTo(AppRoutes.login);
      } else {
        // Navigate based on the role
        if (role == 'user') {
          NavigationService().freshStartTo(AppRoutes.bottomNavbar);

        } else {
          // Handle unknown roles
          NavigationService().freshStartTo(AppRoutes.login);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/pictures/background_pattern.png',
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AppLogo(width: 222.0, height: 162.0),
          ),
        ],
      ),
    );
  }
}
