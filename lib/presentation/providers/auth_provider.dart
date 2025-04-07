// lib/presentation/providers/auth_provider.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // Add this import
import '../../../core/constants/route_constants.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _isLoggedIn = false;
  
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(String email, String password, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Mock login process
      await Future.delayed(const Duration(seconds: 2));
      
      // Successful login
      _isLoggedIn = true;
      notifyListeners();
      
      // Navigate to home
      Navigator.of(context).pushReplacementNamed(RouteConstants.home);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register(String email, String password, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Mock registration process
      await Future.delayed(const Duration(seconds: 2));
      
      // Successful registration
      _isLoggedIn = true;
      notifyListeners();
      
      // Navigate to home
      Navigator.of(context).pushReplacementNamed(RouteConstants.home);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}