import 'package:flutter/material.dart';

class RadioProvider extends ChangeNotifier {
  String? _value = 'Cash';

  String? get value => _value;

  void changeRadion(String uvalue) {
    _value = uvalue;
    notifyListeners();
  }
}
