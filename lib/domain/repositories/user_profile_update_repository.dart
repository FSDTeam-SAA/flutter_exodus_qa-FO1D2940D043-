import 'package:exodus/presentation/screens/profile/model/user_profile_update_model.dart';

import '../../core/network/api_result.dart';

abstract class UserProfileUpdateRepository {
  Future<ApiResult<UserProfileUpdateModel>> updateDriver(UserProfileUpdateModel driver);
}
