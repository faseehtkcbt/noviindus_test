import 'package:flutter/material.dart';
import 'package:noviindus_test/features/patient/model/treatment_model.dart';
import 'package:noviindus_test/features/patient/repository/treatment_repo.dart';

class TreatmentViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoaded = false;
  bool _isError = false;

  bool get isLoading => _isLoading;
  bool get isLoaded => _isLoaded;
  bool get isError => _isError;

  List<Treatment>? _treatments;
  String? _error;

  List<Treatment>? get treatments => _treatments;
  String? get error => _error;

  getTreatments() async {
    _isLoading = true;
    notifyListeners();
    final response = await TreatmentRepo().getTreatment();
    var result;
    response.fold((l) => result = l.message, (r) => result = r);
    if (response.isRight()) {
      _isLoading = false;
      _isError = false;
      _isLoaded = true;
      _treatments = result;
      notifyListeners();
    } else {
      _isLoading = false;
      _isLoaded = false;
      _isError = true;
      _error = result;
      notifyListeners();
    }
  }
}
