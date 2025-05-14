import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/user_models.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<ApiResult<User>> login(String email, String password) {
    return _apiClient.post(
      ApiEndpoints.login,
      data: {"email": email, "password": password},
      fromJsonT: (json) => User.fromJson(json),
    );
  }

  // @override
  // Future<ApiResult<U
}
