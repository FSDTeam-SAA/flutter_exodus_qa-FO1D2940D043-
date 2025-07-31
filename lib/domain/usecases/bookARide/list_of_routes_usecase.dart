import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/domain/repositories/list_of_routes_repository.dart';

class ListOfRoutesUsecase {
  final ListOfRoutesRepository _listOfRoutesRepository;

  ListOfRoutesUsecase(this._listOfRoutesRepository);

  Future<ApiResult<List<String>>> call() async {
    final data = await _listOfRoutesRepository.location();
    return data;
  }
}