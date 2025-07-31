// import 'package:exodus/core/constants/api/api_constants_endpoints.dart';
// import 'package:exodus/core/utils/debug_logger.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;

// class SocketService {
//   io.Socket? _socket;
//   bool _isConnected = false;
//   String? _lastAuthToken;
//   bool _isManualDisconnect = false;
//   final List<Map<String, Function(dynamic)>> _eventListeners = [];

//   bool get isConnected => _isConnected;

//   // Initialize socket connection
//   Future<void> initializeSocket({required String authToken}) async {
//     try {
//       _lastAuthToken = authToken;
//       _isManualDisconnect = false;
      
//       // Disconnect existing socket if connected
//       _socket?.disconnect();
//       _socket = null;

//       _socket = io.io(
//         ApiEndpoints.baseDomain,
//         io.OptionBuilder()
//             .setTransports(['websocket'])
//             .enableAutoConnect()
//             .setExtraHeaders({'Authorization': 'Bearer $authToken'})
//             .build(),
//       );

//       _setupSocketListeners();
//       _socket!.connect();
//     } catch (e) {
//       dPrint('Socket initialization error: $e');
//       rethrow;
//     }
//   }

//   void _setupSocketListeners() {
//     _socket!
//       ..onConnect((_) {
//         _isConnected = true;
//         dPrint('Socket connected');
//         _reRegisterEventListeners();
//       })
//       ..onDisconnect((_) {
//         _isConnected = false;
//         dPrint('Socket disconnected');
//         if (!_isManualDisconnect) {
//           _attemptReconnect();
//         }
//       })
//       ..onError((error) {
//         dPrint('Socket error: $error');
//         if (!_isManualDisconnect) {
//           _attemptReconnect();
//         }
//       });
//   }

//   void _attemptReconnect() {
//     if (_isManualDisconnect || _lastAuthToken == null) return;
    
//     Future.delayed(const Duration(seconds: 2), () async {
//       if (!_isConnected && !_isManualDisconnect) {
//         dPrint('Attempting to reconnect...');
//         try {
//           await initializeSocket(authToken: _lastAuthToken!);
//         } catch (e) {
//           dPrint('Reconnection failed: $e');
//           _attemptReconnect(); // Retry
//         }
//       }
//     });
//   }

//   void _reRegisterEventListeners() {
//     for (final listener in _eventListeners) {
//       listener.forEach((event, callback) {
//         _socket!.on(event, callback);
//       });
//     }
//   }

//   // Emit events to the server
//   void emit(String event, dynamic data) {
//     if (_isConnected && _socket != null) {
//       try {
//         _socket!.emit(event, data);
//       } catch (e) {
//         dPrint('Error emitting event $event: $e');
//       }
//     }
//   }

//   // Listen to server events
//   void on(String event, Function(dynamic) callback) {
//     _eventListeners.add({event: callback});
//     _socket?.on(event, callback);
//   }

//   // Disconnect socket
//   void disconnect() {
//     _isManualDisconnect = true;
//     _socket?.disconnect();
//     _socket = null;
//     _isConnected = false;
//   }

//   // Clean up resources
//   void dispose() {
//     disconnect();
//     _eventListeners.clear();
//   }
// }