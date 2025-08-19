import 'package:exodus/core/network/api_result.dart';

import '../../core/network/network_result.dart';

abstract class ListOfRoutesRepository {
  NetworkResult<List<String>> location();
}
