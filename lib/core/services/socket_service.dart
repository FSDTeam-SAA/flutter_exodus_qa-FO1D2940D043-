import 'package:exodus/core/utils/debug_logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../constants/socket/socket_constants.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  IO.Socket? socket;
  String? userId;
  bool _isConnecting = false;
  bool _isDisposed = false;

  factory SocketService() => _instance;
  SocketService._internal();

  void initializeSocket(String serverUrl, String token) {
    if (_isDisposed) {
      dPrint('SocketService has been disposed and cannot be reused');
      return;
    }

    if (socket != null && socket!.connected) {
      dPrint('Socket is already connected');
      return;
    }

    if (_isConnecting) {
      dPrint('Socket connection already in progress');
      return;
    }

    _isConnecting = true;

    try {
      socket = IO.io(serverUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'auth': {'token': 'Bearer $token'},
        'reconnection': true,
        'reconnectionAttempts': 5,
        'reconnectionDelay': 1000,
        'timeout': 20000,
      });

      // Setup error handler before connecting
      socket!.onConnectError((error) {
        _isConnecting = false;
        dPrint('Socket connection error: $error');
      });

      socket!.connect();

      socket!.onConnect((_) {
        _isConnecting = false;
        dPrint('Connected to socket server');
        if (userId != null) {
          try {
            joinUserRoom(userId!);
          } catch (e) {
            dPrint('Error joining user room after connect: $e');
          }
        }
      });

      socket!.onDisconnect((_) {
        dPrint('Disconnected from socket server');
      });

      socket!.onError((error) {
        dPrint('Socket error: $error');
      });
    } catch (e) {
      _isConnecting = false;
      dPrint('Socket initialization error: $e');
      // Consider adding a retry mechanism or notifying listeners
    }
  }

  void joinUserRoom(String userId) {
    try {
      this.userId = userId;
      if (socket?.connected ?? false) {
        socket?.emit(SocketConstants.joinUserRoomEvent, userId);
      } else {
        dPrint('Cannot join room - socket not connected');
        // Optionally queue this action for when connection is established
      }
    } catch (e) {
      dPrint('Error joining user room: $e');
      rethrow; // Or handle it as per your application needs
    }
  }

  void joinBusLive(String busId) {
    try {
      if (socket?.connected ?? false) {
        socket?.emit(SocketConstants.joinBusLiveEvent, busId);
      } else {
        dPrint('Cannot join bus live - socket not connected');
      }
    } catch (e) {
      dPrint('Error joining bus live: $e');
    }
  }

  void sendLiveLocation(String busId, double lat, double lng) {
    try {
      if (socket?.connected ?? false) {
        socket?.emit(SocketConstants.liveLocationEvent, {
          'busId': busId,
          'lat': lat,
          'lng': lng,
          'timestamp': DateTime.now().toIso8601String(),
        });
      } else {
        dPrint('Cannot send location - socket not connected');
        // Consider queuing the location data to send when reconnected
      }
    } catch (e) {
      dPrint('Error sending live location: $e');
    }
  }

  void listenToNotifications(Function(dynamic) callback) {
    try {
      socket?.off(
        SocketConstants.notificationEvent,
      ); // Remove previous listener
      socket?.on(SocketConstants.notificationEvent, (data) {
        try {
          callback(data);
        } catch (e) {
          dPrint('Error in notification callback: $e');
        }
      });
    } catch (e) {
      dPrint('Error setting up notification listener: $e');
    }
  }

  void listenToLiveLocation(String busId, Function(dynamic) callback) {
    try {
      socket?.off(
        SocketConstants.liveLocationEvent,
      ); // Remove previous listener
      socket?.on(SocketConstants.liveLocationEvent, (data) {
        try {
          if (data is Map && data['busId'] == busId) {
            callback(data);
          }
        } catch (e) {
          dPrint('Error in live location callback: $e');
        }
      });
    } catch (e) {
      dPrint('Error setting up live location listener: $e');
    }
  }

  void disconnect() {
    try {
      socket?.disconnect();
      socket?.clearListeners();
    } catch (e) {
      dPrint('Error disconnecting socket: $e');
    }
  }

  void dispose() {
    if (_isDisposed) return;

    try {
      disconnect();
      socket?.dispose();
      _isDisposed = true;
    } catch (e) {
      dPrint('Error disposing socket: $e');
    }
  }
}
