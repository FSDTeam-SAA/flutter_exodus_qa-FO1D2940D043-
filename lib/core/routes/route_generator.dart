import 'package:exodus/presentation/map/map_screen.dart';
import 'package:exodus/presentation/screens/app/about_app.dart';
import 'package:exodus/presentation/screens/app/privacy_policy.dart';
import 'package:exodus/presentation/screens/app/terms_condition.dart';
import 'package:exodus/presentation/screens/auth/screens/create_new_password.dart';
import 'package:exodus/presentation/screens/auth/screens/forgot_password.dart';
import 'package:exodus/presentation/screens/auth/screens/login_screen.dart';
import 'package:exodus/presentation/screens/auth/screens/security_code.dart';
import 'package:exodus/presentation/screens/auth/screens/signup_screen.dart';
import 'package:exodus/presentation/screens/book_a_ride/screens/book_a_ride_screen.dart';
import 'package:exodus/presentation/screens/book_a_ride/screens/booking_summary_screen.dart';
import 'package:exodus/presentation/screens/book_a_ride/screens/reserve_bus_screen.dart';
import 'package:exodus/presentation/screens/book_a_ride/screens/seats_screen.dart';
import 'package:exodus/presentation/screens/bot/screens/bottom_navbar.dart';
import 'package:exodus/presentation/screens/driver/home/screens/driver_home_screen.dart';
import 'package:exodus/presentation/screens/home/screens/home_screen.dart';
import 'package:exodus/presentation/screens/home/screens/ride_details_screen.dart';
import 'package:exodus/presentation/screens/notification/screens/notification_screen.dart';
import 'package:exodus/presentation/screens/profile/screens/change_password.dart';
import 'package:exodus/presentation/screens/profile/screens/edit_profile_screen.dart';
import 'package:exodus/presentation/screens/profile/screens/ride_history_screen.dart';
import 'package:exodus/presentation/screens/profile/screens/user_profile_screen.dart';
import 'package:exodus/presentation/screens/splash/screens/splash_screen.dart';
import 'package:exodus/presentation/screens/subscriptions/screens/subscriptions.dart';
import 'package:flutter/material.dart';
import 'package:flutx_core/flutx_core.dart';
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
        final args = settings.arguments as Map<String, dynamic>?;
        return SlideLeftTransition(
          page: SecurityCodeScreen(
            email: args?['email'],
            fromLogin: args?['fromLogin'] ?? false,
          ),
        );
      case AppRoutes.createNewPassword:
        final args = settings.arguments as Map<String, dynamic>?;
        return SlideLeftTransition(
          page: CreateNewPasswordScreen(otp: args?['otp_code']),
        );

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

      /// [Map Screen]
      case AppRoutes.map:
        return SlideLeftTransition(
          page: MapScreen(
            tickets:
                args != null ? (args as Map<String, dynamic>)['Tickets'] : null,
          ),
        );

      /// [Book a Ride]
      case AppRoutes.bookARide:
        return FadeRoute(page: BookARideScreen());
      case AppRoutes.reserveBus:
        return SlideLeftTransition(page: ReserveBusScreen());
      case AppRoutes.busSeats:
        return SlideLeftTransition(
          page: SeatsScreen(
            seates:
                args != null ? (args as Map<String, dynamic>)['Seates'] : null,
            source:
                args != null ? (args as Map<String, dynamic>)['source'] : null,
            destination:
                args != null
                    ? (args as Map<String, dynamic>)['destination']
                    : null,
            date: args != null ? (args as Map<String, dynamic>)['date'] : null,
            departureTime:
                args != null
                    ? (args as Map<String, dynamic>)['departureTime']
                    : null,
            arrivalTime:
                args != null
                    ? (args as Map<String, dynamic>)['arrivalTime']
                    : null,
          ),
        );

      case AppRoutes.bookingSummaryScreen:
        final bookingArgs = args as Map<String, dynamic>? ?? {};

        return SlideLeftTransition(
          page: BookingSummaryScreen(
            busName: bookingArgs['busName'] ?? '',
            seatNumber: bookingArgs['seatNumber'] ?? '',
            source: bookingArgs['source'] ?? '',
            destination: bookingArgs['destination'] ?? '',
            date: bookingArgs['date'] ?? '',
            departureTime: bookingArgs['departureTime'] ?? '',
            arrivalTime: bookingArgs['arrivalTime'] ?? '',
            subtotal: bookingArgs['subtotal'] ?? 0.0,
            tax: bookingArgs['tax'] ?? 0.0,
            total: bookingArgs['total'] ?? 0.0,
            ticketId: bookingArgs['ticketId'] ?? '',
            reserveBusId: bookingArgs['reserveBusId'] ?? '',
          ),
        );

      /// [Subscriptions]
      case AppRoutes.subscription:
        return FadeRoute(page: SubscriptionScreen());

      /// [User Profile]
      case AppRoutes.userProfile:
        return FadeRoute(page: UserProfileScreen());
      case AppRoutes.rideHistory:
        return SlideLeftTransition(page: RideHistoryScreen());
      case AppRoutes.changePassword:
        return SlideLeftTransition(page: ChangePasswordScreen());
      case AppRoutes.editUserProfile:
        return SlideLeftTransition(page: EditProfileScreen());

      /// [About], [Privacy], [Terms] screens
      case AppRoutes.aboutApp:
        return SlideLeftTransition(page: AboutApp());
      case AppRoutes.privacyPolicy:
        return SlideLeftTransition(page: PrivacyPolicy());
      case AppRoutes.termsAndCondition:
        return SlideLeftTransition(page: TermsCondition());

      /// [Driver Routes]
      ///
      case AppRoutes.driverHome:
        return SlideLeftTransition(page: DriverHomeScreen());

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
