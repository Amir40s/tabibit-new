import 'package:cloud_firestore/cloud_firestore.dart';

class FaqModel{
  final String id;
  final String question;
  final String answer;


  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
  });

  // Factory method to create a UserModel from FireStore data
  factory FaqModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FaqModel(
      id: doc.id,
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
    );
  }
}