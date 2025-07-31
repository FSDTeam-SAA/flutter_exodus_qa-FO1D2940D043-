import 'package:dio/dio.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/domain/repositories/user_profile_update_repository.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/network/api_result.dart';
import '../models/auth/profile_update_repository.dart';

import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class UserProfileUpdateRepositoryImpl implements UserProfileUpdateRepository {
  final ApiClient _apiClient;

  UserProfileUpdateRepositoryImpl(this._apiClient);

  @override
  Future<ApiResult<ProfileUpdateRepository>> updateDriver({
    required String id,
    // String? name,
    // String? email,
    // String? phone,
    // String? username,
    XFile? avatarFile,
  }) async {
    // Create FormData for multipart request
    final formData = FormData.fromMap({
      'id': id,
      // if (name != null) 'name': name,
      // if (email != null) 'email': email,
      // if (phone != null) 'phone': phone,
      // if (username != null) 'username': username,
      if (avatarFile != null)
        'avatar': await MultipartFile.fromFile(
          avatarFile.path,
          contentType: MediaType.parse(
            lookupMimeType(avatarFile.path) ?? 'image/jpeg',
          ),

          // filename: 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
    });

    dPrint('FormData: ${formData.fields}, Files: ${formData.files}');

    return _apiClient.put(
      ApiEndpoints.updateUserProfile, // Make sure this matches your endpoint
      data: formData,
      fromJsonT: (json) => ProfileUpdateRepository.fromJson(json),
      options: Options(
        contentType: 'multipart/form-data', // Important for file uploads
      ),
    );
  }
}
