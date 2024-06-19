import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:noviindus_test/core/api_constants/api_constants.dart';
import 'package:noviindus_test/core/internet/connection_checker.dart';
import 'package:noviindus_test/features/auth/model/login_response.dart';
import 'package:http/http.dart' as http;
import '../../../core/failure/failure.dart';

class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(
      {required String email, required String password}) async {
    try {
      if (!(await ConnectionChecker().isConnected)) {
        return Left(Failure(
            message: 'Internet is disconnected. Please check the internet!'));
      }

      final response = await http.post(
        Uri.parse(ApiConstants.loginUrl),
        body: {
          'username': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['status'] == true) {
          return Right(LoginResponse.fromJson(result));
        } else {
          return Left(Failure(message: result['message']));
        }
      } else {
        return Left(Failure(message: jsonDecode(response.body)['detail']));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}