import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
import 'package:exodus/core/network/api_client.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/auth/login_response.dart';
import 'package:exodus/data/models/auth/register_response.dart';
import 'package:exodus/data/models/auth/user_data_response.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';
import 'package:exodus/presentation/screens/auth/model/register_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<ApiResult<LoginResponse>> login(String email, String password) {
    dPrint("email : $email");
    return _apiClient.post<LoginResponse>(
      ApiEndpoints.login,
      data: {"email": email, "password": password},
      fromJsonT: (json) => LoginResponse.fromJson(json),
    );
  }

  @override
  Future<ApiResult<User>> register(RegisterRequest register) {
    return _apiClient.post(
      ApiEndpoints.register,
      fromJsonT: (json) => User.fromJson(json),
    );
  }

  @override
  Future<ApiResult<UserData>> getUserData() async {
    return _apiClient.get<UserData>(
      ApiEndpoints.getUserData,
      fromJsonT: (json) => UserData.fromJson(json),
    );
  }
}
