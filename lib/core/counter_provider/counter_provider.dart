import 'package:flutter/cupertino.dart';

class CounterProvider extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increase(int value) {
    _count = value + 1;
    notifyListeners();
  }

  void decrease(int value) {
    if (value != 0) {
      _count = value - 1;
      notifyListeners();
    }
  }
}
