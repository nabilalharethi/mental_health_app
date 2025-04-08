import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import '../../../data/models/appointment_model.dart';
import '../../providers/appointment_provider.dart';
import 'appointment_booking_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppointmentProvider>(context, listen: false).loadAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
        actions: [
          IconButton(
            icon: const Icon(Feather.plus),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AppointmentBookingScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: appointmentProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildAppointmentsList(appointmentProvider.appointments),
    );
  }

  Widget _buildAppointmentsList(List<AppointmentModel> appointments) {
    if (appointments.isEmpty) {
      return const Center(child: Text('No appointments booked yet.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Feather.calendar),
            title: Text(appointment.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('With ${appointment.counselorName}'),
                Text(
                  '${appointment.dateTime.day}/${appointment.dateTime.month}/${appointment.dateTime.year} · ${appointment.dateTime.hour}:${appointment.dateTime.minute.toString().padLeft(2, '0')}',
                ),
              ],
            ),
            trailing: Chip(
              label: Text(appointment.status),
              backgroundColor: appointment.status == "Confirmed"
                  ? Colors.green[100]
                  : Colors.orange[100],
            ),
          ),
        );
      },
    );
  }
}