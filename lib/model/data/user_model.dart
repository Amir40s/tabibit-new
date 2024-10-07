import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userUid;
  final String name;
  final String email;
  final String userType;
  final String phoneNumber;
  final String country;
  final String birthDate;
  final String speciality;
  final String specialityId;
  final String availabilityFrom;
  final String availabilityTo;
  final String specialityDetail;
  final String appointmentFee;
  final String memberShip;
  final String experience;
  final String patients;
  final String reviews;
  final Timestamp creationDate;
  final String profileUrl;
  final String rating;
  final bool isOnline;
  final String location;
  final String latitude;
  final String longitude;
  final String accountType;
  final String deviceToken;
  final bool isFav;

  UserModel({
    required this.userUid,
    required this.name,
    required this.email,
    required this.userType,
    required this.phoneNumber,
    required this.country,
    required this.birthDate,
    required this.speciality,
    required this.specialityId,
    required this.availabilityFrom,
    required this.availabilityTo,
    required this.specialityDetail,
    required this.appointmentFee,
    required this.memberShip,
    required this.experience,
    required this.patients,
    required this.reviews,
    required this.creationDate,
    required this.profileUrl,
    required this.rating,
    required this.isOnline,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.accountType,
    required this.deviceToken,
    required this.isFav,
  });

  // Factory method to create a UserModel from FireStore data
  factory UserModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      userUid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      userType: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      country: data['country'] ?? '',
      birthDate: data['birthDate'] ?? '',
      speciality: data['speciality'] ?? '',
      specialityId: data['specialityId'] ?? '',
      availabilityFrom: data['availabilityFrom'] ?? '',
      availabilityTo: data['availabilityTo'] ?? '',
      specialityDetail: data['specialityDetail'] ?? '',
      appointmentFee: data['appointmentFee'] ?? '',
      memberShip: data['memberShip'] ?? '',
      experience: data['experience'] ?? '',
      patients: data['patients'] ?? '',
      reviews: data['reviews'] ?? '',
      creationDate: data['creationDate'] ?? '',
      profileUrl: data['profileUrl'] ?? '',
      rating: data['rating'] ?? '',
      isOnline: data['isOnline'] ?? false,
      location: data['location'] ?? '',
      latitude: data['latitude'] ?? '',
      longitude: data['longitude'] ?? '',
      accountType: data['accountType'] ?? '',
      deviceToken: data['deviceToken'] ?? '',
      isFav: data['isFav'] ?? false,
    );
  }
}

