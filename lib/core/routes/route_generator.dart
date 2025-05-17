import 'package:exodus/core/routes/transitions/fade_route.dart';
import 'package:exodus/core/routes/transitions/slide_left.dart';
import 'package:exodus/core/routes/transitions/slide_up.dart';
import 'package:exodus/presentation/screens/auth/screens/create_new_password.dart';
import 'package:exodus/presentation/screens/auth/screens/forgot_password.dart';
import 'package:exodus/presentation/screens/auth/screens/login_screen.dart';
import 'package:exodus/presentation/screens/auth/screens/security_code.dart';
import 'package:exodus/presentation/screens/auth/screens/signup_screen.dart';
import 'package:exodus/presentation/screens/home/screens/home_screen.dart';
import 'package:exodus/presentation/screens/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return SlideLeftTransition(page: SplashScreen());
      case AppRoutes.login:
        return SlideLeftTransition(page: LoginScreen());
      case AppRoutes.signup:
        return SlideLeftTransition(page: SignupScreen());
      case AppRoutes.forgatePassword:
        return SlideLeftTransition(page: ForgotPasswordScreen());
       case AppRoutes.codeVerify:
        return SlideLeftTransition(page: SecurityCodeScreen());
       case AppRoutes.createNewPassword:
        return SlideLeftTransition(page: CreateNewPasswordScreen());

      case AppRoutes.home:
        return FadeRoute(page: HomeScreen());
      
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(body: Center(child: Text('Route not found'))),
    );
  }
}
