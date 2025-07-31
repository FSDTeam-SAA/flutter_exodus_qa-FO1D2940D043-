import 'package:flutter/foundation.dart';

class HourSelectorController extends ChangeNotifier {
  double _hours = 4.0;
  double baseAmount = 500.0;
  double extraPerHour = 75.0;
  double taxRate = 0.01;
  final double minHours = 4.0;
  final double maxHours = 12.0;
  final double step = 1.0;

  double get hours => _hours;

  double get subtotal {
    final extraHours = _hours - minHours;
    return baseAmount + (extraHours > 0 ? extraHours * extraPerHour : 0);
  }

  double get tax => subtotal * taxRate;

  double get total => subtotal + tax;

  void increase() {
    if (_hours + step <= maxHours) {
      _hours += step;
      notifyListeners();
    }
  }

  void decrease() {
    if (_hours - step >= minHours) {
      _hours -= step;
      notifyListeners();
    }
  }

  void resetHours() {
    _hours = minHours;
    notifyListeners();
  }

  void setHours(double value) {
    if (value >= minHours && value <= maxHours) {
      _hours = value;
      notifyListeners();
    }
  }

  bool get canIncrease => _hours < maxHours;
  bool get canDecrease => _hours > minHours;
}
