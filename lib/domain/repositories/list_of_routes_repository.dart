import 'package:exodus/core/network/api_result.dart';

abstract class ListOfRoutesRepository {
  Future<ApiResult<List<String>>> location();
}
