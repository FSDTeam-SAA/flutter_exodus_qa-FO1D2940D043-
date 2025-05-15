import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/auth_response.dart';
import 'package:exodus/data/models/user_models.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<ApiResult<AuthResponse>> login(String email, String password) {
    dPrint("email : $email");
    return _apiClient.post<AuthResponse>(
      ApiEndpoints.login,
      data: {"email": email, "password": password},
      fromJsonT: (json) => AuthResponse.fromJson(json),
    );
  }

  // @override
  // Future<ApiResult<U
}
