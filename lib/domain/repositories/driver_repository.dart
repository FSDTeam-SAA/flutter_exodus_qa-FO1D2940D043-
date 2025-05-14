import 'package:exodus/data/models/driver_model.dart';

abstract class DriverRepository {
  Future<Driver> createDriver({
    required String name,
    required String email,
    required String phone,
    required String password,
    String? avatarPath,
  });
  Future<List<Driver>> getAllDrivers();
  Future<Driver> updateDriver(String driverId, Driver driver);
  Future<void> deleteDriver(String driverId);
}