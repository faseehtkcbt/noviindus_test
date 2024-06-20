import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:noviindus_test/core/api_constants/api_constants.dart';
import 'package:noviindus_test/features/patient/model/branch_model.dart';
import 'package:http/http.dart' as http;
import '../../../core/failure/failure.dart';
import '../../../core/internet/connection_checker.dart';
import '../../auth/repository/local/auth_local_repo.dart';

class RegisterPatient {
  Future<Either<Failure, String>> registerPatient(
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
    try {
      if (!(await ConnectionChecker().isConnected)) {
        return Left(Failure(
            message: 'Internet is disconnected. Please check the internet!'));
      }
      var body = {
        "name": name,
        "excecutive": executive,
        "payment": payment,
        "phone": phone,
        "address": address,
        "total_amount": totalAmount,
        "discount_amount": discountAmount,
        "advance_amount": advanceAmount,
        "balance_amount": balanceAmount,
        "date_nd_time": dateTime,
        "id": "",
        "male": male,
        "female": female,
        "treatments": treatments,
        "branch": branch
      };
      String token = await AuthLocalRepo().getToken();
      final response = await http
          .post(Uri.parse(ApiConstants.patientUpdateUrl), body: body, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['status'] == true) {
          return Right(result['message']);
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
