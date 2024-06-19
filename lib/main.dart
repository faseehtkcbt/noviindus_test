import 'package:flutter/material.dart';
import 'package:noviindus_test/config/theme/app_theme.dart';
import 'package:noviindus_test/core/provider/providers.dart';
import 'package:noviindus_test/features/splash/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'config/routers/routers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.prov,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routers.routers,
        title: 'Noviindus Test',
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
