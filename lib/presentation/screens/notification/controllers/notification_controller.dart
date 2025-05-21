import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/user_profile_models/notification.dart';
import 'package:exodus/domain/usecases/home/notification_data_usecase.dart';

class NotificationController extends BaseController {

  // Add NotificationUsecase to the constructor
  final NotificationDataUsecase _notificationDataUsecase;

  NotificationController(this._notificationDataUsecase);

  // Notification List
  List<NotificationModel> notifications = [];

  Future<void> getAllNotifications() async {
    try {
      final result = await _notificationDataUsecase.call();

      if (result is ApiSuccess<List<NotificationModel>>) {
        final notifications = result.data;
        this.notifications = notifications;
        dPrint("Notification -> ${notifications.length}");
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