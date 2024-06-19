import 'package:flutter/material.dart';
import 'package:noviindus_test/config/routers/routers.dart';
import 'package:noviindus_test/features/auth/repository/local/auth_local_repo.dart';

import '../../../core/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    AuthLocalRepo().checkIsLogged().then((value) {
      if (value == true) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routers.homeScreen, (listen) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, Routers.signIn, (listen) => false);
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppConstants.splashBackground))),
      )),
    );
  }
}
