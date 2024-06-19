import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:noviindus_test/core/api_constants/api_constants.dart';
import 'package:noviindus_test/core/internet/connection_checker.dart';
import 'package:noviindus_test/features/home/model/patient_model.dart';
import 'package:http/http.dart' as http;
import '../../../core/failure/failure.dart';
import '../../auth/repository/local/auth_local_repo.dart';

class HomeRepository {
  Future<Either<Failure, List<Patient>>> getPatientList() async {
    try {
      if (!(await ConnectionChecker().isConnected)) {
        return Left(Failure(
            message: 'Internet is disconnected. Please check the internet!'));
      }
      String token = await AuthLocalRepo().getToken();
      final response = await http.get(
        Uri.parse(ApiConstants.patientUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body)['patient'];
        List<Patient> patients = [];
        for (var i in result) {
          patients.add(Patient.fromJson(i));
        }
        return Right(patients);
      } else {
        return Left(Failure(message: jsonDecode(response.body)['detail']));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
