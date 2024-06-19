import 'package:flutter/material.dart';
import 'package:noviindus_test/features/home/model/patient_model.dart';
import 'package:noviindus_test/features/home/repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier{
  bool _isLoading = false;
  bool _isLoaded = false;
  bool _isError = false;

  bool get isLoaded => _isLoaded;
  bool get isLoading => _isLoading;
  bool get isError => _isError;

  List<Patient>? _patients;
  String? _error;

  List<Patient>? get patients => _patients;
  String? get error => _error;

  getPatients()async{
    _isLoading = true;
    notifyListeners();
    final response = await HomeRepository().getPatientList();
    var result ;
    response.fold((l)=>result = l.message, (r) => result =r);
    if(response.isRight()){
      _isLoading = false;
      _isError = false;
      _isLoaded = true;
      _patients = result;
      notifyListeners();
    }
    else{
      _isLoading = false;
      _isLoaded = false;
      _isError = true;
      _error = result;
      notifyListeners();
    }
  }
}