import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/pages/auth/login_screen.dart';
import '../presentation/providers/auth_provider.dart';
import '../presentation/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/route_constants.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      initialRoute: RouteConstants.login,
      routes: {
        RouteConstants.login: (context) => LoginScreen(),
      },
    );
  }
}
