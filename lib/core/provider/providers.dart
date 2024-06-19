import 'package:noviindus_test/features/auth/view_model/auth_view_model.dart';
import 'package:noviindus_test/features/patient/view_model/branch_view_model.dart';
import 'package:provider/provider.dart';

class Providers {
  Providers._();

  static final prov = [
    ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
    ChangeNotifierProvider<BranchViewModel>(create: (_) => BranchViewModel())
  ];
}
