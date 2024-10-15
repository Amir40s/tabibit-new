import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentRemainderModel {
  final String appointmentDate;
  final String appointmentTime;
  final String deviceToken;
  final String id;
  final String location;
  final String patientAge;
  final String patientEmail;
  final String patientGender;
  final String patientName;
  final String patientPhone;
  final String patientProblem;
  final String status;
  final String userUid;

  AppointmentRemainderModel({
    required this.appointmentDate,
    required this.appointmentTime,
    required this.deviceToken,
    required this.id,
    required this.location,
    required this.patientAge,
    required this.patientEmail,
    required this.patientGender,
    required this.patientName,
    required this.patientPhone,
    required this.patientProblem,
    required this.status,
    required this.userUid,
  });

  // Factory method to create AppointmentRemainderModel from Firestore data
  factory AppointmentRemainderModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppointmentRemainderModel(
      appointmentDate: data['appointmentDate'] ?? '',
      appointmentTime: data['appointmentTime'] ?? '',
      deviceToken: data['deviceToken'] ?? '',
      id: doc.id,
      location: data['location'] ?? '',
      patientAge: data['patientAge'] ?? '',
      patientEmail: data['patientEmail'] ?? '',
      patientGender: data['patientGender'] ?? '',
      patientName: data['patientName'] ?? '',
      patientPhone: data['patientPhone'] ?? '',
      patientProblem: data['patientProblem'] ?? '',
      status: data['status'] ?? '',
      userUid: data['userUid'] ?? '',
    );
  }
}
