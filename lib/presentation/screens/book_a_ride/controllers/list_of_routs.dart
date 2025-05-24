import 'package:exodus/core/controller/base_controller.dart';
import 'package:exodus/core/network/api_result.dart';
import 'package:exodus/core/utils/debug_logger.dart';
import 'package:exodus/data/models/bus/available_bus_response.dart';
import 'package:exodus/domain/usecases/bookARide/list_of_available_suttles_usecase.dart';
import 'package:exodus/domain/usecases/bookARide/list_of_routes_usecase.dart';
import 'package:exodus/presentation/core/services/app_data_store.dart';
import 'package:exodus/presentation/screens/book_a_ride/model/shuttle_query.dart';

class ListOfRouts extends BaseController {
  // use case for ListOfRoutsController
  final ListOfRoutesUsecase _listOfRoutesUsecase;
  final GetAvailableShuttlesUseCase _getAvailableShuttlesUseCase;

  ListOfRouts(this._listOfRoutesUsecase, this._getAvailableShuttlesUseCase);

   List<AvailableShuttle> availableShuttlesList = [];

  Future<void> getListOfRoutes() async {
    setLoading(true);
    final result = await _listOfRoutesUsecase.call();
    setLoading(false);
    if (result is ApiSuccess<List<String>>) {
      final data = result.data;
      dPrint("List of Routes: $data");

      AppDataStore().routesList = data;

      // return the data
      notifyListeners();
      // return data;
    } else {
      final message = (result as ApiError).message;
      setError(message);
      dPrint(" Controller login message print $message");
      notifyListeners();
      // return [];
    }
  }

  // Available Shuttles
  Future<List<AvailableShuttle>> getAvailableShuttles(String from, String to, DateTime date) async {
    setLoading(true);
    final query = ShuttleQuery(from: 'C', to: 'dhaka', date: '2025-05-28');
    final result = await _getAvailableShuttlesUseCase.call(query);
    setLoading(false);
    if (result is ApiSuccess<List<AvailableShuttle>>) {
      final data = result.data;
      dPrint("Available Shuttles: $data");

      availableShuttlesList = data;

      return availableShuttlesList;

      // return the data
      // notifyListeners();
      // return data;
    } else {
      final message = (result as ApiError).message;
      setError(message);
      dPrint(" Controller login message print $message");
      return [];
      // notifyListeners();
      // return [];
    }
  }
}
