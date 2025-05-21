import 'package:flutter/foundation.dart';

class HourSelectorController extends ChangeNotifier {
  double _hours = 4.0;
  double baseAmount = 500.0;
  double extraPerHour = 75.0;
  double taxRate = 0.01;

  double get hours => _hours;

  double get subtotal {
    final extraHours = _hours - 4.0;
    return baseAmount + (extraHours > 0 ? extraHours * extraPerHour : 0);
  }

  double get tax => subtotal * taxRate;

  double get total => subtotal + tax;

  void increase() {
    _hours += 1.0;
    notifyListeners();
  }

  void decrease() {
    if (_hours > 4.0) {
      _hours -= 1.0;
      notifyListeners();
    }
  }
}

