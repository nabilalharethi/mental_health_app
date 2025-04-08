import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../data/models/appointment_model.dart';
import '../../providers/appointment_provider.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() => _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _selectedCounselor = 'Dr. Sarah Johnson';

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() => _selectedTime = pickedTime);
    }
  }

  void _bookAppointment() {
    if (_formKey.currentState!.validate() && _selectedDate != null && _selectedTime != null) {
      final appointment = AppointmentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        dateTime: DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        ),
        counselorName: _selectedCounselor,
      );

      Provider.of<AppointmentProvider>(context, listen: false)
          .bookAppointment(appointment)
          .then((_) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Appointment booked successfully!')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Appointment Title',
                  prefixIcon: Icon(Feather.edit_3),
                ),
                validator: (value) => value!.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCounselor,
                items: const [
                  DropdownMenuItem(value: 'Dr. Sarah Johnson', child: Text('Dr. Sarah Johnson')),
                  DropdownMenuItem(value: 'Dr. Michael Chen', child: Text('Dr. Michael Chen')),
                ],
                onChanged: (value) => setState(() => _selectedCounselor = value!),
                decoration: const InputDecoration(
                  labelText: 'Counselor',
                  prefixIcon: Icon(Feather.user),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      icon: const Icon(Feather.calendar),
                      label: Text(
                        _selectedDate == null
                            ? 'Select Date'
                            : DateFormat('dd/MM/yyyy').format(_selectedDate!),
                      ),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton.icon(
                      icon: const Icon(Feather.clock),
                      label: Text(
                        _selectedTime == null
                            ? 'Select Time'
                            : _selectedTime!.format(context),
                      ),
                      onPressed: () => _selectTime(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _bookAppointment,
                icon: const Icon(Feather.calendar),
                label: const Text('Book Appointment'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}