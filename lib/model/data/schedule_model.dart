// model/schedule_item.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleItem {
  final String title;
  final String imageUrl;
  final String description;

  ScheduleItem({
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  // Factory method to create an instance from a Firestore document
  factory ScheduleItem.fromFirestore(Map<String, dynamic> data) {
    return ScheduleItem(
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ScheduleItem(title: $title, image: $imageUrl, subtitle: $description)';
  }
}
