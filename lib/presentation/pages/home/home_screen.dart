import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../auth/login_screen.dart';
import '../../../core/constants/route_constants.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../presentation/pages/appointments/appointments_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardView(),
    const PlaceholderWidget(title: 'Resources'),
    const AppointmentsScreen(),
    const PlaceholderWidget(title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MindWell'),
        actions: [
          IconButton(
            icon: const Icon(Feather.log_out),
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, RouteConstants.login);
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Feather.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.book),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.home),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.user),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Welcome to MindWell Dashboard'),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;
  const PlaceholderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}