import 'package:cloud_firestore/cloud_firestore.dart';

class SpecializeModel {
  final String id;
  final String specialty;


  SpecializeModel({
    required this.id,
    required this.specialty,
  });

  // Factory method to create a UserModel from FireStore data
  factory SpecializeModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SpecializeModel(
      id: doc.id,
      specialty: data['specialty'] ?? '',
    );
  }
}