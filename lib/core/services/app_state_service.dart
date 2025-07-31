import 'package:exodus/data/models/auth/user_data_response.dart';

class AppStateService {
  UserData? _currentUser;

  UserData? get currentUser => _currentUser;

  void setUser(UserData user) {
    _currentUser = user;
  }

  void clearUser() {
    _currentUser = null;
  }
}