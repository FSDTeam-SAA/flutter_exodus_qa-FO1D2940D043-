import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/domain/repositories/user_profile_update_repository.dart';
import 'package:exodus/presentation/screens/profile/model/user_profile_update_model.dart';

import '../../core/network/api_result.dart';

class UserProfileUpdateRepositoryImpl implements UserProfileUpdateRepository {
  final ApiClient _apiClient;

  UserProfileUpdateRepositoryImpl(this._apiClient);

  @override
  Future<ApiResult<UserProfileUpdateModel>> updateDriver(
    UserProfileUpdateModel driver,
  ) {
    return _apiClient.put(
      ApiEndpoints.updateUserProfile,
      data: driver.toJson(),
      fromJsonT: (json) => UserProfileUpdateModel.fromJson(json),
    );
  }
}
