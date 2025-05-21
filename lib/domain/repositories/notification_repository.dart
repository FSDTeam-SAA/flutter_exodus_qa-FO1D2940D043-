import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/user_profile_models/notification.dart';

abstract class NotificationRepository {
  Future<ApiResult<List<NotificationModel>>> getAllNotifications();
  Future<ApiResult<NotificationModel>>markAsRead();
}