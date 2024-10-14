import 'package:cloud_firestore/cloud_firestore.dart';

class WithdrawRequest {
  final String withdrawID;
  final String userUID;
  final String bankDetailId;
  final String status;
  final String amount;
  final String type;
  final String name;
  final String email;
  final String profile;
  final String speciality;
  final DateTime timestamp;

  WithdrawRequest({
    required this.withdrawID,
    required this.userUID,
    required this.bankDetailId,
    required this.status,
    required this.amount,
    required this.type,
    required this.name,
    required this.email,
    required this.profile,
    required this.speciality,
    required this.timestamp,
  });

  factory WithdrawRequest.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return WithdrawRequest(
      withdrawID: data['withdrawID'] ?? "",
      userUID: data['userUID'] ?? "",
      bankDetailId: data['bankDetailId'] ?? "",
      status: data['status'] ?? "",
      amount: data['amount'] ?? "",
      type: data['type'] ?? "",
      name: data['name'] ?? "",
      email: data['email'] ?? "",
      speciality: data['speciality'] ?? "",
      profile: data['profile'] ?? "",
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}