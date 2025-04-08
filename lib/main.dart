import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presentation/pages/auth/login_screen.dart';
import '../presentation/providers/auth_provider.dart';
import '../presentation/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/route_constants.dart';
import 'presentation/pages/auth/register_screen.dart';
import 'presentation/pages/home/home_screen.dart';
import 'presentation/pages/resources/resources_screen.dart';
import 'presentation/providers/resource_provider.dart';
import 'presentation/pages/appointments/appointments_screen.dart';
import 'presentation/providers/appointment_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ResourceProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
      ],
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
        RouteConstants.register: (context) =>  RegisterScreen(),
        RouteConstants.home: (context) => const HomeScreen(),
        '/resources': (context) => const ResourcesScreen(),
        '/appointments': (context) => const AppointmentsScreen(),
      },
    );
  }
}
