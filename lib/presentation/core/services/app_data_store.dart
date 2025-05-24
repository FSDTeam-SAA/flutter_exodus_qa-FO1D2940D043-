import 'dart:async';

import 'package:exodus/data/models/ticket/ticket_model.dart';

import '../../../core/utils/debug_logger.dart';
import '../../../data/models/user_profile_models/notification.dart';

class AppDataStore {
  // Singleton pattern
  static final AppDataStore _instance = AppDataStore._internal();

  factory AppDataStore() => _instance;

  AppDataStore._internal();

  /// [Notification]
  /// store the notification
  ///
  final _notificationsStreamController =
      StreamController<List<NotificationModel>>.broadcast();
  Stream<List<NotificationModel>> get notificationsStream =>
      _notificationsStreamController.stream;
  void updateNotifications(List<NotificationModel> notifications) {
    _notificationsStreamController.add(notifications);
  }

  /// `Close` the notification stream
  void notificationClose() {
    _notificationsStreamController.close();
  }

  /// [Ride History]
  /// store the ride history
  ///
  final _rideHistoryStreamController =
      StreamController<List<TicketModel>>.broadcast();
  Stream<List<TicketModel>> get rideHistoryStream =>
      _rideHistoryStreamController.stream;
  void updateRideHistory(List<TicketModel> rideHistory) {
    dPrint("Updating ride history with ${rideHistory.length} items");
    _rideHistoryStreamController.add(rideHistory);
  }

  /// `Close` the ride history stream
  void rideHistoryClose() {
    _rideHistoryStreamController.close();
  }

  /// [Routes]
  /// store the list of routes
  List<String> routesList = [];


}
