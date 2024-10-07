class UserchatModel {
  final String id;
  final String name;
  final String email;
  final String profileUrl;
  final String userUid;
  final String deviceToken;

  UserchatModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileUrl,
    required this.userUid,
    required this.deviceToken,
  });

  factory UserchatModel.fromMap(Map<String, dynamic> map) {
    return UserchatModel(
      id: map['userId'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      profileUrl: map['profileUrl'] ?? "https://res.cloudinary.com/dz0mfu819/image/upload/v1725947218/profile_xfxlfl.pngs",
      userUid: map['userUID'] ?? "",
      deviceToken: map['deviceToken'] ?? "",
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, image: $profileUrl}';
  }
}