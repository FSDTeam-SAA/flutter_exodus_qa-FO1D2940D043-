import '../api/api_constants_endpoints.dart';

class SocketConstants {
  static const String serverUrl = ApiEndpoints.baseDomain;
  static const String joinUserRoomEvent = 'joinUserRoom';
  static const String joinBusLiveEvent = 'joinBusLive';
  static const String liveLocationEvent = 'liveLocation';
  static const String notificationEvent = 'notification';
}