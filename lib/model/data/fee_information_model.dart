import 'package:cloud_firestore/cloud_firestore.dart';

class FeeInformationModel {
  final String id;
  final String fees;
  final String subTitle;
  final String type;


  FeeInformationModel({
    required this.id,
    required this.fees,
    required this.subTitle,
    required this.type,
  });

  // Factory method to create a UserModel from FireStore data
  factory FeeInformationModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FeeInformationModel(
      id: doc.id,
      fees: data['fees'] ?? '',
      subTitle: data['subTitle'] ?? '',
      type: data['type'] ?? '',
    );
  }
}
