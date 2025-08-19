import 'dart:io';

import 'package:exodus/domain/repositories/user_profile_update_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/network/api_result.dart';
import '../../../core/network/network_result.dart';
import '../../../data/models/auth/profile_update_repository.dart';

class UserProfileUpdateUsecase {
  final UserProfileUpdateRepository repository;

  UserProfileUpdateUsecase(this.repository);

  NetworkResult<ProfileUpdateRepository> call(String id, XFile formData) {
    return repository.updateDriver(id: id, avatarFile: formData);
  }
}
