import 'package:flutter/material.dart';
import 'package:noviindus_test/features/auth/view/sign_in.dart';
import 'package:noviindus_test/features/home/view/homescreen.dart';
import 'package:noviindus_test/features/patient/view/add_patient_screen.dart';

class Routers {
  Routers._();
  static const String homeScreen = '/homescreen';
  static const String signIn = '/sign_in';
  static const String addPatientScreen = '/add_patient_screen';

  static final dynamic routers = <String, WidgetBuilder>{
    homeScreen: (BuildContext context) => const Homescreen(),
    signIn: (BuildContext context) => const SignIn(),
    addPatientScreen: (BuildContext context) => const AddPatientScreen()
  };
}
