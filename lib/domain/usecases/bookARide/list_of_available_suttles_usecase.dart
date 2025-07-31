import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/data/models/bus/available_bus_response.dart';
import 'package:exodus/domain/repositories/list_of_available_suttles_repository.dart';
import 'package:exodus/presentation/screens/book_a_ride/model/shuttle_query.dart';

class GetAvailableShuttlesUseCase {
  final ListOfAvailableShuttlesRepository repository;

  GetAvailableShuttlesUseCase({required this.repository});

  Future<ApiResult<List<AvailableShuttle>>> call(
    ShuttleQuery query
  ) async {
    return await repository.getAvailableShuttles(from: query.from, to: query.to, date: query.date);
  }
}
