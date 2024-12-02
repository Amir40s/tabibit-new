class NotificationModel {
  final String date ;
  final bool read;
  final String title;
  final String subtitle;
  final String type;

  NotificationModel({
    required this.date ,
    required this.read,
    required this.title,
    required this.subtitle,
    required this.type,
  });


  factory NotificationModel.fromMap(Map<String, dynamic> data) {
    return NotificationModel(
      date : data['date'] ?? '',
      read: data['read'] ?? false,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      type: data['type'] ?? '',
    );
  }
}