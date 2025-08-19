// class ApiConstants {
//   // BaseURL
//   // static const String baseDomain = 'http://10.10.5.95:5000';

//   static const String baseDomain = 'https://api.exodusqa.com/';
//   static const String baseUrl = '$baseDomain/api/v1';
//   // static const String baseUrl = 'https://exodus-backend-59hw.onrender.com';

//   static Map<String, String> get multipartHeaders => {
//     'Accept': 'application/json',
//     // Content-Type will be set automatically for multipart
//   };

//   static const String refreshToken = '$baseUrl/auth/refresh-token';
//   // Auth
//   static const String login = '$baseUrl/auth/login';
//   static const String register = '$baseUrl/auth/register';
//   static const String verifyOtp = '$baseUrl/auth/verify';
//   static const String forgetPassword = '$baseUrl/auth/forget';
//   static const String resetPassword = '$baseUrl/auth/reset-password';
//   static const String changePassword = '$baseUrl/auth/change-password';
//   static const String getUserData = '$baseUrl/auth/user-data';

//   /// [User]
//   static const String getAllNotification = '$baseUrl/users/get-notfication';
//   static const String makeAsAllRead = '$baseUrl/users/mark-as-read';

//   /// [Ride]
//   static const String getRouteList = '$baseUrl/users/get-bus-route';
//   static const String getAvailableBus = "$baseUrl/bus/get-available-bus";
//   static const String getSingleBus = '$baseUrl/bus/';
//   static const String createTicket = '$baseUrl/ticket/create-ticket';
//   static const String reserveBus = "$baseUrl/reserve-bus";

//   /// [Profile]
//   ///
//   static const String getRideHistory = '$baseUrl/users/ride-history';
//   static const String updateUserProfile = '$baseUrl/drivers';

//   // Bus
//   static const String createBus = '$baseUrl/bus/';
//   static const String updateBus = '$baseUrl/bus/'; // + {busId}
//   static const String getAllBuses = '$baseUrl/bus/all-bus';
//   static const String getAvailableBuses = '$baseUrl/bus/get-available-bus';
//   static const String getBusDetails = '$baseUrl/bus/'; // + {busId}
//   static const String deleteBus = '$baseUrl/bus/'; // + {busId}

//   // Ticket

//   static const String acceptStanding =
//       '$baseUrl/ticket/accept-standing/'; // + {ticketId}
//   static const String getAllTickets = '$baseUrl/ticket/all-ticket';
//   static const String getAdminAllTickets = '$baseUrl/ticket/admin-all-ticket';
//   static const String cancelTicket = '$baseUrl/ticket/cancle-ticket/'; // + {ticketId}
//   static const String scanQr = '$baseUrl/ticket/scan-qr/'; // + {ticketId}

//   // Schedule
//   static const String createSchedule = '$baseUrl/add/schedule';

//   // Payment endpoints
//   static const String createPayment = '$baseUrl/create-payment';
//   static const String confirmPayment = '$baseUrl/confirm-payment';

//   // // Driver
//   // static const String createDriver = '/api/v1/add/driver';
//   // static const String getAllDrivers = '/api/v1/all/drivers';
//   // static const String deleteDriver = '/api/v1/drivers/'; // + {driverId}

//   // Helper method for URL construction
//   static String withId(String baseEndpoint, String id) => '$baseEndpoint$id';
// }
