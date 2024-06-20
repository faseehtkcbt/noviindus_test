import 'package:flutter/material.dart';

import '../model/treatment_data.dart';

class RegisterPatientViewModel extends ChangeNotifier {
  List<TreatmentData> _selectedTreatment = [];

  List<TreatmentData> get selectedTreatment => _selectedTreatment;

  void addSelectedTreatment(TreatmentData data) {
    _selectedTreatment.add(data);
    notifyListeners();
  }

  void removeSelectedTreatment(TreatmentData data) {
    _selectedTreatment
        .removeWhere((e) => e.treatment.name == data.treatment.name);
    notifyListeners();
  }
}
