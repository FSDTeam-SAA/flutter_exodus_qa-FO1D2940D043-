import 'package:exodus/core/routes/transitions/fade_route.dart';
import 'package:exodus/core/routes/transitions/slide_left.dart';
import 'package:exodus/presentation/screens/auth/screens/create_new_password.dart';
import 'package:exodus/presentation/screens/auth/screens/forgot_password.dart';
import 'package:exodus/presentation/screens/auth/screens/login_screen.dart';
import 'package:exodus/presentation/screens/auth/screens/security_code.dart';
import 'package:exodus/presentation/screens/auth/screens/signup_screen.dart';
import 'package:exodus/presentation/screens/book_a_ride/screens/book_a_ride_screen.dart';
import 'package:exodus/presentation/screens/book_a_ride/screens/reserve_bus_screen.dart';
import 'package:exodus/presentation/screens/bot/screens/bottom_navbar.dart';
import 'package:exodus/presentation/screens/home/screens/home_screen.dart';
import 'package:exodus/presentation/screens/home/screens/ride_details_screen.dart';
import 'package:exodus/presentation/screens/notification/screens/notification_screen.dart';
import 'package:exodus/presentation/screens/profile/screens/user_profile_screen.dart';
import 'package:exodus/presentation/screens/splash/screens/splash_screen.dart';
import 'package:exodus/presentation/screens/subscriptions/screens/subscriptions.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      /// [Authentication Screens]
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

      /// [App Bottom Navbar]
      case AppRoutes.bottomNavbar:
        return FadeRoute(page: BottomNavbar());

      /// [Home Screens]
      case AppRoutes.home:
        return FadeRoute(page: HomeScreen());
      case AppRoutes.rideDetails:
        return SlideLeftTransition(
          page: RideDetailsScreen(
            tickets:
                args != null ? (args as Map<String, dynamic>)['Tickets'] : null,
          ),
        );

      case AppRoutes.notification:
        return SlideLeftTransition(page: NotificationScreen());

      /// [Book a Ride]
      case AppRoutes.bookARide:
        return FadeRoute(page: BookARideScreen());
      case AppRoutes.reserveBus:
        return SlideLeftTransition(page: ReserveBusScreen());

      /// [Subscriptions]
      case AppRoutes.subscription:
        return FadeRoute(page: SubscriptionScreen());

      /// [User Profile]
      case AppRoutes.userProfile:
        return FadeRoute(page: UserProfileScreen());

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
