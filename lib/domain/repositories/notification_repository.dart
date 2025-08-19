import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/user_profile_models/notification.dart';

import '../../core/network/network_result.dart';

abstract class NotificationRepository {
  NetworkResult<List<NotificationModel>> getAllNotifications();
  NetworkResult<NotificationModel> markAsRead();
}