import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/routes/app_routes.dart';
import 'package:exodus/core/services/navigation_service.dart';
import 'package:exodus/core/services/secure_store_services.dart';
import 'package:exodus/domain/usecases/home/get_home_data.dart';
import 'package:exodus/domain/usecases/userProfile/user_profile_update_usecase.dart';
import 'package:exodus/presentation/screens/profile/model/user_profile_update_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/api/cache_constants.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/network/models/hive_cache_model.dart';
import '../../../../core/services/app_state_service.dart';
import '../../../../core/utils/debug_logger.dart';
import '../../../../data/models/auth/user_data_response.dart';

class ProfileController extends BaseController {
  final SecureStoreServices _secureStoreServices;
  final UserProfileUpdateUsecase _userProfileUpdateUsecase;
  final GetHomeDataUsecase _getHomeDataUsecase;
  final AppStateService _appStateService;

  ProfileController(
    this._secureStoreServices,
    this._userProfileUpdateUsecase,
    this._getHomeDataUsecase,
    this._appStateService,
  );

  final ValueNotifier<UserData?> userDataNotifier = ValueNotifier(null);

  Future<void> logout() async {
    await _secureStoreServices.deleteAllData();

    // Clear Hive cache box explicitly
    final cacheBox = Hive.box<HiveCacheModel>(ApiCacheConstants.userCacheKey);
    await cacheBox.clear();

    // Clear any user-specific state in other services
    sl<AppStateService>().clearUser();
    NavigationService().freshStartTo(AppRoutes.login);
  }

  Future<void> updateUserProfile(
    UserProfileUpdateModel model, {
    XFile? avatarFile,
  }) async {
    try {
      if (avatarFile != null) {
        final response = await _userProfileUpdateUsecase.call(
          model.id,
          avatarFile,
        );
        if (response is ApiSuccess<Map<String, dynamic>>) {
          dPrint("Profile updated successfully");
          // Update local user data with the response
          // await _appStateService.setUser(response.data.entries);
        }
        // else if (response is ApiFailure) {
        //   dPrint("Error updating profile: ${response.error}");
        // }
      } else {
        dPrint(
          "avatarFile is null. Cannot update profile without an avatar file.",
        );
      }
    } catch (e) {
      dPrint("Exception in updateUserProfile: $e");
      // Handle error appropriately
    }
  }

  Future<UserData?> getUserData() async {
    setLoading(true);

    try {
      final result = await _getHomeDataUsecase.call();

      if (result is ApiSuccess<UserData>) {
        final data = result.data;
        userDataNotifier.value = result.data;
        _appStateService.setUser(result.data);
        dPrint("User Data Print -> ${data.user.email}");

        return data;
      }
    } finally {
      setLoading(false);
    }
    return null;
  }
}
