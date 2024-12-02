class ReviewModel {
  final String id;
  final String appointmentId ;
  final String comment;
  final String name;
  final String rating;
  final String uid;


  ReviewModel({
    required this.id,
    required this.appointmentId,
    required this.comment,
    required this.name,
    required this.rating,
    required this.uid,
  });


  factory ReviewModel.fromMap(Map<String, dynamic> data) {
    return ReviewModel(
      id: data['id'] ?? '',
      appointmentId: data['appointmentId'] ?? '',
      comment: data['comment'] ?? '',
      name: data['name'] ?? '',
      rating: data['rating'] ?? '0.0',
      uid: data['uid'] ?? '',
    );
  }
}