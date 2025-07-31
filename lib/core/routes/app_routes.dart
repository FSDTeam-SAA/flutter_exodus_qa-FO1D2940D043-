import 'package:exodus/presentation/screens/book_a_ride/screens/booking_summary_screen.dart';

abstract class AppRoutes {
  static const splash = '/';

  /// [Authentication screens Routes]
  static const login = '/login';
  static const signup = '/signup';

  static const forgatePassword = '/forgate-password';
  static const codeVerify = '/code-verify';
  static const createNewPassword = '/create-New-Password';

  /// [App Bottom Navbar]
  static const bottomNavbar = '/bottom-navbar';

  /// [Home screens routes]
  static const home = '/home';
  static const rideDetails = '/ride-details';
  static const notification = '/notification';

  /// [Book a Ride]
  static const bookARide = 'book-a-ride';
  static const reserveBus = 'reserve-bus';
  static const busSeats = 'bus-seats';

  /// [Subscriptions]
  static const subscription = 'subscription';

  /// [User Profile]
  static const userProfile = 'user-profile';
  static const rideHistory = 'ride-history';
  static const aboutApp = 'about-app';
  static const privacyPolicy = 'privacy-policy';
  static const termsAndCondition = 'terms-and-condition';
  static const changePassword = 'change-password';
  static const editUserProfile = 'edit-user-profile';

  /// [Map Screen]
  static const map = 'map';


  /// [Driver Routes]
  static const driverHome = '/driver-home';

  /// [Booking Summary Screen]
  static const bookingSummaryScreen = '/booking-summary-screen';
  
}
