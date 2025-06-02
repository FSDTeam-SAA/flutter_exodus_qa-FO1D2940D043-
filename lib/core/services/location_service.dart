import 'dart:async';
import 'package:permission_handler/permission_handler.dart';


class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();


  Future<void> init() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) return;

    // _startLocationUpdates(busId);
    _handlePermission();
  }

  Future<bool> _handlePermission() async {
    final status = await Permission.locationWhenInUse.status;
    if (status.isGranted) return true;

    final result = await Permission.locationWhenInUse.request();
    return result.isGranted;
  }

  // void _startLocationUpdates(String bus) {
  //   _positionStreamSubscription?.cancel(); // Avoid duplicates

  //   _positionStreamSubscription = Geolocator.getPositionStream(
  //     locationSettings: const LocationSettings(
  //       accuracy: LocationAccuracy.high,
  //       distanceFilter: 10,
  //     ),
  //   ).listen((position) {
  //     dPrint(position.latitude);
  //     dPrint(position.longitude);

  //     final busId = bus;
  //     SocketService().sendLiveLocation(
  //       busId,
  //       position.latitude,
  //       position.longitude,
  //     );
  //   });
  // }

  // void stopLocationUpdates() {
  //   _positionStreamSubscription?.cancel();
  // }
}
