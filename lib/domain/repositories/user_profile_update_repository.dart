
import 'package:exodus/data/models/auth/profile_update_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/network/api_result.dart';
import '../../core/network/network_result.dart';

abstract class UserProfileUpdateRepository {
  NetworkResult<ProfileUpdateRepository> updateDriver({
    required String id,
    XFile? avatarFile,
  });
}
