import 'package:flutter/material.dart';
import 'package:noviindus_test/features/patient/model/branch_model.dart';
import 'package:noviindus_test/features/patient/repository/branch_repo.dart';

class BranchViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoaded = false;
  bool _isError = false;

  bool get isLoading => _isLoading;
  bool get isLoaded => _isLoaded;
  bool get isError => _isError;

  List<Branch>? _branches;
  String? _error;

  List<Branch>? get branches => _branches;
  String? get error => _error;

  getBranches() async {
    _isLoading = true;
    notifyListeners();
    final response = await BranchRepo().getBranches();
    var result;
    response.fold((l) => result = l.message, (r) => result = r);
    if (response.isRight()) {
      _isLoading = false;
      _isError = false;
      _isLoaded = true;
      _branches = result;
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
