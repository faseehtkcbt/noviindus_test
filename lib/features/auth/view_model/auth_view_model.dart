import 'package:flutter/material.dart';
import 'package:noviindus_test/features/auth/model/login_response.dart';
import 'package:noviindus_test/features/auth/repository/local/auth_local_repo.dart';
import 'package:noviindus_test/features/auth/repository/remote/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isLoaded = false;
  bool _isError = false;

  bool get isLoading => _isLoading;
  bool get isLoaded => _isLoaded;
  bool get isError => _isError;

  LoginResponse? _loginResponse;
  String? _error;

  LoginResponse? get loginResponse => _loginResponse;
  String? get error => _error;

  login({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();
    final response =
        await AuthRepository().login(email: email, password: password);
    var result;
    response.fold((l) => result = l.message, (r) => result = r);
    if (response.isRight()) {
      _isLoading = false;
      _isError = false;
      _isLoaded = true;
      await AuthLocalRepo().addData(result);
      _loginResponse = result;
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
