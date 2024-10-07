import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String id;
  final String fileUrl;


  ReportModel({
    required this.id,
    required this.fileUrl,
  });

  // Factory method to create a UserModel from FireStore data
  factory ReportModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ReportModel(
      id: doc.id,
      fileUrl: data['fileUrl'] ?? '',
    );
  }
}