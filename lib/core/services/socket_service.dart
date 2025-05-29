import 'package:exodus/core/utils/debug_logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../constants/socket/socket_constants.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  IO.Socket? socket; // make it nullable
  String? userId;

  factory SocketService() => _instance;
  SocketService._internal();

  void initializeSocket(String serverUrl, String token) {
    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'auth': {'token': token},
    });

    socket!.connect();

    socket!.onConnect((_) {
      dPrint('Connected to socket server');
      if (userId != null) {
        joinUserRoom(userId!);
      }
    });

    socket!.onDisconnect((_) => dPrint('Disconnected from socket server'));
    socket!.onError((error) => dPrint('Socket error: $error'));
  }

  void joinUserRoom(String userId) {
    this.userId = userId;
    socket?.emit( SocketConstants.joinUserRoomEvent, userId);
  }

  void joinBusLive(String busId) {
    socket?.emit(SocketConstants.joinBusLiveEvent, busId);
  }

  void sendLiveLocation(String busId, double lat, double lng) {
    socket?.emit(SocketConstants.liveLocationEvent, {
      'busId': busId,
      'lat': lat,
      'lng': lng,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void listenToNotifications(Function(dynamic) callback) {
    socket?.on( SocketConstants.notificationEvent, callback);
  }

  void listenToLiveLocation(String busId, Function(dynamic) callback) {
    socket?.on(SocketConstants.liveLocationEvent, (data) {
      if (data['busId'] == busId) {
        callback(data);
      }
    });
  }

  void disconnect() {
    socket?.disconnect();
  }
}
