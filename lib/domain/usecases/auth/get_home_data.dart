import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/auth/user_data_response.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';

class GetHomeDataUsecase {
  final AuthRepository _repository;

  GetHomeDataUsecase(this._repository);

  Future<ApiResult<UserData>> call() async {
    return await _repository.getUserData();
  }
}
