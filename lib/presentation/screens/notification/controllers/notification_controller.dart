import 'dart:async';

import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/services/socket_services.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/user_profile_models/notification.dart';
import 'package:exodus/domain/usecases/home/notification_data_usecase.dart';
import 'package:exodus/presentation/core/services/app_data_store.dart';

class NotificationController extends BaseController {
  // Add NotificationUsecase to the constructor
  final NotificationDataUsecase _notificationDataUsecase;

  // final _notificationsStreamController = StreamController<List<NotificationModel>>.broadcast();

  NotificationController(this._notificationDataUsecase,) {
    // _setupSocketListeners();
  }

  // Notification List
  List<NotificationModel> _currentNotifications = [];
  // Stream<List<NotificationModel>> get notificationsStream => _notificationsStreamController.stream;

  // void _setupSocketListeners() {
  //   _socketService.on('now_notification', (data) {
  //     try {
  //       final newNotification = NotificationModel.fromJson(data);
  //       final updated = [newNotification, ..._currentNotifications];
  //       AppDataStore().updateNotifications(updated);
  //       // AppDataStore..add(_currentNotifications);
  //     } catch (e) {
  //       dPrint("Error parsing notification data: $e");
  //     }
  //   });
  // }

  Future<void> getAllNotifications() async {
    try {
      final result = await _notificationDataUsecase.call();

      if (result is ApiSuccess<List<NotificationModel>>) {
        _currentNotifications = result.data;
        AppDataStore().updateNotifications(_currentNotifications);
        // this.notifications = notifications;
        dPrint("Notification -> ${_currentNotifications.length}");
      } else if (result is ApiError) {
        // Handle error case
        final message = (result as ApiError).message;
        // Show error message to the user

        dPrint("Notification -> $message");
      }
    } catch (e) {
      // Handle any unexpected errors
    }
  }


}
