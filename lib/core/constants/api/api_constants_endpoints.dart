class ApiEndpoints {
  // BaseURL
  // static const String baseUrl = 'https://exodus-backend-ke7n.onrender.com/api/v1';

  static const String baseDomain = 'http://192.168.40.213:5000';
  static const String baseUrl = '$baseDomain/api/v1';

  static const String refreshToken = '/auth/refresh-token';
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify';
  static const String forgetPassword = '/auth/forget';
  static const String resetPassword = '/auth/reset-password';
  static const String changePassword = '/auth/change-password';
  static const String getUserData = '/auth/user-data';

  /// [User]
  static const String getAllNotification = '/users/get-notfication';
  static const String makeAsAllRead = '/users/mark-as-read';

  /// [Ride]
  static const String getRouteList = '/users/get-bus-route';
  static const String getAvailableBus = "/bus/get-available-bus";


  /// [Profile]
  ///
  static const String getRideHistory = '/users/ride-history';

  // Bus
  static const String createBus = '/bus/';
  static const String updateBus = '/bus/'; // + {busId}
  static const String getAllBuses = '/bus/all-bus';
  static const String getAvailableBuses = '/bus/get-available-bus';
  static const String getBusDetails = '/bus/'; // + {busId}
  static const String deleteBus = '/bus/'; // + {busId}

  // Ticket
  static const String createTicket = '/ticket/create-ticket';
  static const String acceptStanding =
      '/ticket/accept-standing/'; // + {ticketId}
  static const String getAllTickets = '/ticket/all-ticket';
  static const String getAdminAllTickets = '/ticket/admin-all-ticket';
  static const String cancelTicket = '/ticket/cancle-ticket/'; // + {ticketId}
  static const String scanQr = '/ticket/scan-qr/'; // + {ticketId}

  // Schedule
  static const String createSchedule = '/add/schedule';

  // Driver
  static const String createDriver = '/api/v1/add/driver';
  static const String getAllDrivers = '/api/v1/all/drivers';
  static const String updateDriver = '/api/v1/drivers/'; // + {driverId}
  static const String deleteDriver = '/api/v1/drivers/'; // + {driverId}

  // Helper method for URL construction
  static String withId(String baseEndpoint, String id) => '$baseEndpoint$id';
}
