import 'package:noviindus_test/features/auth/view_model/auth_view_model.dart';
import 'package:noviindus_test/features/home/view_model/home_view_model.dart';
import 'package:noviindus_test/features/patient/view_model/branch_view_model.dart';
import 'package:noviindus_test/features/patient/view_model/treatment_view_model.dart';
import 'package:provider/provider.dart';

import '../../features/patient/view_model/register_patient_view_model.dart';

class Providers {
  Providers._();

  static final prov = [
    ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
    ChangeNotifierProvider<BranchViewModel>(create: (_) => BranchViewModel()),
    ChangeNotifierProvider<TreatmentViewModel>(
        create: (_) => TreatmentViewModel()),
    ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel()),
    ChangeNotifierProvider<RegisterPatientViewModel>(
        create: (_) => RegisterPatientViewModel())
  ];
}
