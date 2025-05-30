import 'package:exodus/core/di/service_locator.dart';
import 'package:exodus/data/repositories/auth_repository_impl.dart';
import 'package:exodus/data/repositories/create_ticket_repository_impl.dart';
import 'package:exodus/data/repositories/list_of_available_suttles_impl.dart';
import 'package:exodus/data/repositories/list_of_routes_impl.dart';
import 'package:exodus/data/repositories/notification_repository_impl.dart';
import 'package:exodus/data/repositories/ride_history_impl.dart';
import 'package:exodus/data/repositories/single_bust_repository_impl.dart';
import 'package:exodus/data/repositories/user_profile_update_repository_impl.dart';
import 'package:exodus/domain/repositories/auth_repository.dart';
import 'package:exodus/domain/repositories/create_ticket_repository.dart';
import 'package:exodus/domain/repositories/list_of_available_suttles_repository.dart';
import 'package:exodus/domain/repositories/list_of_routes_repository.dart';
import 'package:exodus/domain/repositories/notification_repository.dart';
import 'package:exodus/domain/repositories/ride_history_repository.dart';
import 'package:exodus/domain/repositories/single_bus_repository.dart';
import 'package:exodus/domain/repositories/user_profile_update_repository.dart';

void setupRepository() {
  sl.registerCachedFactory<AuthRepository>(
    () => AuthRepositoryImpl(apiClient: sl()),
  );

  sl.registerCachedFactory<NotificationRepository>(
    () => NotificationRepositoryImpl(apiClient: sl()),
  );

  // Profile Repository
  sl.registerCachedFactory<RideHistoryRepository>(
    () => RideHistoryImpl(apiClient: sl()),
  );
  sl.registerCachedFactory<UserProfileUpdateRepository>(
    () => UserProfileUpdateRepositoryImpl(sl()),
  );

  // Book A Ride Repository
  sl.registerCachedFactory<ListOfRoutesRepository>(
    () => ListOfRoutesImpl(apiClient: sl()),
  );
  sl.registerCachedFactory<ListOfAvailableShuttlesRepository>(
    () => ListOfAvailableSuttlesImpl(apiClient: sl()),
  );
  sl.registerCachedFactory<GetSingleBusRepository>(
    () => GetSingleBustRepositoryImpl(apiClient: sl()),
  );
  sl.registerCachedFactory<CreateTicketRepository>(
    () => CreateTicketRepositoryImpl(apiClient: sl()),
  );
}
