import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:noviindus_test/core/api_constants/api_constants.dart';
import 'package:noviindus_test/core/failure/failure.dart';
import 'package:noviindus_test/features/auth/repository/local/auth_local_repo.dart';
import 'package:http/http.dart' as http;
import 'package:noviindus_test/features/patient/model/treatment_model.dart';
import '../../../core/internet/connection_checker.dart';

class TreatmentRepo {
  Future<Either<Failure, List<Treatment>>> getTreatment() async {
    try {
      if (!(await ConnectionChecker().isConnected)) {
        return Left(Failure(
            message: 'Internet is disconnected. Please check the internet!'));
      }
      String token = await AuthLocalRepo().getToken();
      final response = await http.get(
        Uri.parse(ApiConstants.treatmentUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body)['treatments'];
        final List<Treatment> treatments = [];
        for (var i in result) {
          treatments.add(Treatment.fromJson(i));
        }
        return Right(treatments);
      } else {
        return Left(Failure(message: jsonDecode(response.body)['detail']));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
