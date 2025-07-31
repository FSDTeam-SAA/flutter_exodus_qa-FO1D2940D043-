import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/user_profile_models/notification.dart';

import '../../repositories/notification_repository.dart';

class NotificationDataUsecase {
  final NotificationRepository _notificationRepository;

  NotificationDataUsecase(this._notificationRepository);

  Future<ApiResult<List<NotificationModel>>> call() async {
    return await _notificationRepository.getAllNotifications();
  }
}