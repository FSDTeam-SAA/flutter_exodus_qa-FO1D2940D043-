// lib/core/network/services/connectivity_service.dart

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityService {
  static ConnectivityService? _instance;
  static ConnectivityService get instance => _instance ??= ConnectivityService._internal();
  
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  
  // Current connectivity status
  bool _isConnected = true;
  bool get isConnected => _isConnected;
  
  // Stream controller for connectivity changes
  final StreamController<bool> _connectivityController = StreamController<bool>.broadcast();
  Stream<bool> get connectivityStream => _connectivityController.stream;

  /// Initialize connectivity monitoring
  Future<void> initialize() async {
    // Check initial connectivity
    await _checkConnectivity();
    
    // Listen for connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
      onError: (error) {
        if (kDebugMode) print('Connectivity error: $error');
      },
    );
  }

  /// Check current connectivity status
  Future<bool> checkConnectivity() async {
    try {
      final List<ConnectivityResult> connectivityResults = await _connectivity.checkConnectivity();
      return _hasInternetConnection(connectivityResults);
    } catch (e) {
      if (kDebugMode) print('Error checking connectivity: $e');
      return false;
    }
  }

  /// Private method to check connectivity and update status
  Future<void> _checkConnectivity() async {
    final bool wasConnected = _isConnected;
    _isConnected = await checkConnectivity();
    
    if (wasConnected != _isConnected) {
      _connectivityController.add(_isConnected);
      if (kDebugMode) {
        print('Connectivity changed: ${_isConnected ? 'Connected' : 'Disconnected'}');
      }
    }
  }

  /// Handle connectivity changes
  void _onConnectivityChanged(List<ConnectivityResult> results) {
    final bool wasConnected = _isConnected;
    _isConnected = _hasInternetConnection(results);
    
    if (wasConnected != _isConnected) {
      _connectivityController.add(_isConnected);
      if (kDebugMode) {
        print('Connectivity changed: ${_isConnected ? 'Connected' : 'Disconnected'}');
      }
    }
  }

  /// Check if any of the connectivity results indicate internet connection
  bool _hasInternetConnection(List<ConnectivityResult> results) {
    return results.any((result) => 
      result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi ||
      result == ConnectivityResult.ethernet ||
      result == ConnectivityResult.vpn
    );
  }

  /// Wait for internet connection (useful for retry mechanisms)
  Future<void> waitForConnection({Duration? timeout}) async {
    if (_isConnected) return;
    
    final completer = Completer<void>();
    late StreamSubscription<bool> subscription;
    
    subscription = connectivityStream.listen((isConnected) {
      if (isConnected) {
        subscription.cancel();
        if (!completer.isCompleted) {
          completer.complete();
        }
      }
    });
    
    if (timeout != null) {
      Timer(timeout, () {
        subscription.cancel();
        if (!completer.isCompleted) {
          completer.completeError(TimeoutException('Connection timeout', timeout));
        }
      });
    }
    
    return completer.future;
  }

  /// Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivityController.close();
  }
}
