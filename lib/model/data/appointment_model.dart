import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String patientEmail;
  final String patientPhone;
  final String patientProblem;
  final String patientGender;
  final String patientAge;
  final String appointmentTime;
  final String appointmentDate;
  final String doctorId;
  final String doctorName;
  final String doctorEmail;
  final String doctorRating;
  final String doctorLocation;
  final String image;
  final String fees;
  final String feesId;
  final String feesTitle;
  final String feeSubTitle;
  final String feesType;
  final String name;
  final String phone;
  final String status;
  final String deviceToken;


  AppointmentModel( {
    required this.doctorEmail,
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorRating,
    required this.doctorLocation,
    required this.patientId,
    required this.patientName,
    required this.patientEmail,
    required this.patientPhone,
    required this.patientProblem,
    required this.patientGender,
    required this.patientAge,
    required this.appointmentTime,
    required this.appointmentDate,
    required this.image,
    required this.fees,
    required this.feesId,
    required this.feesTitle,
    required this.feeSubTitle,
    required this.feesType,
    required this.name,
    required this.phone,
    required this.status,
    required this.deviceToken,
  });

  // Factory method to create a UserModel from FireStore data
  factory AppointmentModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppointmentModel(
      doctorEmail: data['doctorEmail'] ?? '',
      id: doc.id,
      patientId: data['patientId'] ?? '',
      patientName: data['patientName'] ?? '',
      patientEmail: data['patientEmail'] ?? '',
      patientPhone: data['patientPhone'] ?? '',
      patientProblem: data['patientProblem'] ?? '',
      patientGender: data['patientGender'] ?? '',
      patientAge: data['patientAge'] ?? '',
      appointmentTime: data['appointmentTime'] ?? '',
      appointmentDate: data['appointmentDate'] ?? '',
      doctorId: data['doctorId'] ?? '',
      doctorName: data['doctorName'] ?? '',
      doctorRating: data['doctorRating'] ?? '',
      doctorLocation: data['doctorLocation'] ?? '',
      image: data['image'] ?? '',
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      status: data['status'] ?? '',
      fees: data['fees'] ?? '',
      feesId: data['feesId'] ?? '',
      feesTitle: data['feesTitle'] ?? '',
      feeSubTitle: data['feeSubTitle'] ?? '',
      feesType: data['feesType'] ?? '',
      deviceToken: data['deviceToken'] ?? '',
    );
  }
}