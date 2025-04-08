class AppointmentModel {
  final String id;
  final String title;
  final DateTime dateTime;
  final String counselorName;
  final String status; // "Pending", "Confirmed", "Cancelled"

  AppointmentModel({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.counselorName,
    this.status = "Pending",
  });
}