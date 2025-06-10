// // lib/core/services/local_notification_service.dart
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:exodus/core/utils/debug_logger.dart';

// class LocalNotificationService {
//   static final LocalNotificationService _instance = 
//       LocalNotificationService._internal();
  
//   factory LocalNotificationService() => _instance;
//   LocalNotificationService._internal();

//   final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initialize() async {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
    
//     const DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );
    
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
    
//     await _notificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (details) {
//         // Handle notification tap
//         dPrint('Notification tapped: ${details.payload}');
//       },
//     );
//   }

//   Future<void> showNotification({
//     required String title,
//     required String body,
//     Map<String, dynamic>? payload,
//   }) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your_channel_id',
//       'Your Channel Name',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: true,
//     );
    
//     const DarwinNotificationDetails iOSPlatformChannelSpecifics =
//         DarwinNotificationDetails();
    
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
    
//     await _notificationsPlugin.show(
//       0, // Notification ID
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: payload?.toString(),
//     );
//   }
// }