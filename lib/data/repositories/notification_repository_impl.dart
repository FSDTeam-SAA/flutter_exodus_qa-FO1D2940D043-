import 'package:exodus/data/models/user_profile_models/notification.dart';
import 'package:exodus/domain/repositories/notification_repository.dart';

import '../../core/constants/api/api_constants_endpoints.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_result.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiClient _apiClient;

  NotificationRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<ApiResult<List<NotificationModel>>> getAllNotifications() async {
    return _apiClient.get<List<NotificationModel>>(
      ApiEndpoints.getAllNotification,
      fromJsonT:
          (json) =>
              (json as List)
                  .map((item) => NotificationModel.fromJson(item))
                  .toList(),
    );
  }

  @override
  Future<ApiResult<NotificationModel>> markAsRead() async {
    return _apiClient.get<NotificationModel>(
      ApiEndpoints.makeAsAllRead,
      fromJsonT: (json) => NotificationModel.fromJson(json),
    );
  }
}
