import 'package:flutter/material.dart';
import 'package:noviindus_test/features/patient/repository/register_patient.dart';

import '../model/branch_model.dart';
import '../model/treatment_data.dart';

class RegisterPatientViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoaded = false;
  bool _isError = false;

  bool get isLoading => _isLoading;
  bool get isLoaded => _isLoaded;
  bool get isError => _isError;

  List<TreatmentData> _selectedTreatment = [];
  List<TreatmentData> get selectedTreatment => _selectedTreatment;

  String? _messages;
  String? _error;

  String? get messages => _messages;
  String? get error => _error;

  void addSelectedTreatment(TreatmentData data) {
    _selectedTreatment.add(data);
    notifyListeners();
  }

  registerPatient(
      {required String name,
      required String executive,
      required String payment,
      required String phone,
      required String address,
      required double totalAmount,
      required double discountAmount,
      required double advanceAmount,
      required double balanceAmount,
      required String dateTime,
      required List<int> male,
      required List<int> female,
      required List<int> treatments,
      required Branch branch}) async {
    _isLoading = true;
    notifyListeners();
    final response = await RegisterPatient().registerPatient(
        name: name,
        executive: executive,
        payment: payment,
        phone: phone,
        address: address,
        totalAmount: totalAmount,
        discountAmount: discountAmount,
        advanceAmount: advanceAmount,
        balanceAmount: balanceAmount,
        dateTime: dateTime,
        male: male,
        female: female,
        treatments: treatments,
        branch: branch);
    var result;
    response.fold((l) => result = l.message, (r) => result = r);
    if (response.isRight()) {
      _isLoading = false;
      _isError = false;
      _isLoaded = true;
      _messages = result;
      notifyListeners();
    } else {
      _isLoading = false;
      _isLoaded = false;
      _isError = true;
      _error = result;
      notifyListeners();
    }
  }

  void removeSelectedTreatment(TreatmentData data) {
    _selectedTreatment
        .removeWhere((e) => e.treatment.name == data.treatment.name);
    notifyListeners();
  }
}
