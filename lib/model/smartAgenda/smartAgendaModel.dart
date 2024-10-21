import 'package:cloud_firestore/cloud_firestore.dart';

class SmartAppointment {
  final String id;
  final String amount;
  final String amountReceived;
  final DateTime applyDate;
  final String appointmentDate;
  final String appointmentPayment;
  final String appointmentTime;
  final String clientSecret;
  final String deviceToken;
  final String doctorEmail;
  final String doctorId;
  final String doctorImage;
  final String doctorLocation;
  final String doctorName;
  final String doctorRating;
  final String documentFile;
  final String feeSubTitle;
  final String fees;
  final String feesId;
  final String feesType;
  final String name;
  final String patientAge;
  final String patientEmail;
  final String patientGender;
  final String patientId;
  final String patientName;
  final String patientPhone;
  final String patientProblem;
  final String paymentId;
  final String phone;
  final String status;

  SmartAppointment({
    required this.id,
    required this.amount,
    required this.amountReceived,
    required this.applyDate,
    required this.appointmentDate,
    required this.appointmentPayment,
    required this.appointmentTime,
    required this.clientSecret,
    required this.deviceToken,
    required this.doctorEmail,
    required this.doctorId,
    required this.doctorImage,
    required this.doctorLocation,
    required this.doctorName,
    required this.doctorRating,
    required this.documentFile,
    required this.feeSubTitle,
    required this.fees,
    required this.feesId,
    required this.feesType,
    required this.name,
    required this.patientAge,
    required this.patientEmail,
    required this.patientGender,
    required this.patientId,
    required this.patientName,
    required this.patientPhone,
    required this.patientProblem,
    required this.paymentId,
    required this.phone,
    required this.status,
  });

  factory SmartAppointment.fromFirestore(Map<String, dynamic> doc) {
    return SmartAppointment(
      id: doc['id'],
      amount: doc['amount'],
      amountReceived: doc['amountReceived'],
      applyDate: (doc['applyDate'] as Timestamp).toDate(),
      appointmentDate: doc['appointmentDate'],
      appointmentPayment: doc['appointmentPayment'],
      appointmentTime: doc['appointmentTime'],
      clientSecret: doc['clientSecret'],
      deviceToken: doc['deviceToken'],
      doctorEmail: doc['doctorEmail'],
      doctorId: doc['doctorId'],
      doctorImage: doc['doctorImage'],
      doctorLocation: doc['doctorLocation'],
      doctorName: doc['doctorName'],
      doctorRating: doc['doctorRating'],
      documentFile: doc['documentFile'],
      feeSubTitle: doc['feeSubTitle'],
      fees: doc['fees'],
      feesId: doc['feesId'],
      feesType: doc['feesType'],
      name: doc['name'],
      patientAge: doc['patientAge'],
      patientEmail: doc['patientEmail'],
      patientGender: doc['patientGender'],
      patientId: doc['patientId'],
      patientName: doc['patientName'],
      patientPhone: doc['patientPhone'],
      patientProblem: doc['patientProblem'],
      paymentId: doc['paymentId'],
      phone: doc['phone'],
      status: doc['status'],
    );
  }
}
