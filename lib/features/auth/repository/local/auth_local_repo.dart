import 'package:noviindus_test/features/auth/model/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalRepo {
  addData(LoginResponse response) async {
    final sharedpref = await SharedPreferences.getInstance();
    sharedpref.setBool('isLogged', true);
    sharedpref.setString('token', response.token);
    sharedpref.setString('username', response.userDetails.username);
    sharedpref.setString('email', response.userDetails.mail);
    print('addData');
  }

  Future<bool> checkIsLogged() async {
    final sharedpref = await SharedPreferences.getInstance();
    bool? value = sharedpref.getBool('isLogged');
    if (value == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> getToken() async {
    final sharedpref = await SharedPreferences.getInstance();
    String value = sharedpref.getString('token') ?? '';
    return value;
  }
}
