import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel{
  final String id;
  final String title;
  final String subTitle;
  final String read;
  final String type;


  NotificationModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.read,
    required this.type,
  });

  // Factory method to create a UserModel from FireStore data
  factory NotificationModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: doc.id,
      title: data['title'] ?? '',
      subTitle: data['subTitle'] ?? '',
      read: data['read'] ?? '',
      type: data['type'] ?? '',
    );
  }
}