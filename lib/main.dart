import 'package:flutter/material.dart';
import 'package:noviindus_test/config/theme/app_theme.dart';
import 'package:noviindus_test/features/auth/view/sign_in.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noviindus Test',
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      home: const SignIn(),
    );
  }
}

