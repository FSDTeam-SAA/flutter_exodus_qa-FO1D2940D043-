import 'package:exodus/core/di/setup_controller.dart';
import 'package:exodus/core/di/setup_core.dart';
import 'package:exodus/core/di/setup_repository.dart';
import 'package:exodus/core/di/setup_use_case.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Core Service
  setupCore();

  // Usecase
  setupUseCase();

  // Repositories
  setupRepository();

  // Controllers
  setupController();
}
