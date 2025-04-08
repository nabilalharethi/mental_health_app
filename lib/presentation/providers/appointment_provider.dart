import 'package:flutter/material.dart';
import '../../data/models/appointment_model.dart';

class AppointmentProvider with ChangeNotifier {
  List<AppointmentModel> _appointments = [];
  bool _isLoading = false;

  List<AppointmentModel> get appointments => _appointments;
  bool get isLoading => _isLoading;

  Future<void> loadAppointments() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Mock API call

    _appointments = [
      AppointmentModel(
        id: '1',
        title: 'Initial Consultation',
        dateTime: DateTime.now().add(const Duration(days: 2)),
        counselorName: 'Dr. Sarah Johnson',
      ),
      AppointmentModel(
        id: '2',
        title: 'Follow-up Session',
        dateTime: DateTime.now().add(const Duration(days: 5)),
        counselorName: 'Dr. Michael Chen',
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  Future<void> bookAppointment(AppointmentModel appointment) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Mock API call
    _appointments.add(appointment);

    _isLoading = false;
    notifyListeners();
  }
}