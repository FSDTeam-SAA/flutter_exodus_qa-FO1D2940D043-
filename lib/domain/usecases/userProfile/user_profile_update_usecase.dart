import 'package:exodus/domain/repositories/user_profile_update_repository.dart';
import 'package:exodus/presentation/screens/profile/model/user_profile_update_model.dart';

import '../../../core/network/api_result.dart';

class UserProfileUpdateUsecase {
  final UserProfileUpdateRepository repository;

  UserProfileUpdateUsecase(this.repository);

  Future<ApiResult<UserProfileUpdateModel>> call(UserProfileUpdateModel driver) {
    return repository.updateDriver(driver);
  }
}
