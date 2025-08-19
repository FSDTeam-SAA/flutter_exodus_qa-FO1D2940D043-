import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/domain/repositories/list_of_routes_repository.dart';

import '../../../core/network/network_result.dart';

class ListOfRoutesUsecase {
  final ListOfRoutesRepository _listOfRoutesRepository;

  ListOfRoutesUsecase(this._listOfRoutesRepository);

  NetworkResult<List<String>> call() async {
    final data = await _listOfRoutesRepository.location();
    return data;
  }
}