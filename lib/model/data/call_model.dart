import 'package:cloud_firestore/cloud_firestore.dart';

class CallModel{
  final String id;
  final String callId;
  final String doctorId;
  final String patientId;
  final String patientName;
  final String status;
  final bool isVideo;


  CallModel({
    required this.id,
    required this.callId,
    required this.doctorId,
    required this.patientId,
    required this.patientName,
    required this.status,
    required this.isVideo,
  });

  // Factory method to create a UserModel from FireStore data
  factory CallModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CallModel(
      id: doc.id,
      callId: data['callId'] ?? '',
      doctorId: data['doctorId'] ?? '',
      patientId: data['patientId'] ?? '',
      patientName: data['patientName'] ?? '',
      status: data['status'] ?? '',
      isVideo: data['isVideo'] ?? false,
    );
  }
}