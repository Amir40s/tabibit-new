import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/schedule_model.dart';
import '../../data/user_model.dart';

class FireStoreServices{

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<UserModel>> getSchedules() {
    return _db.collection('bannerAds').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromDocumentSnapshot(doc);
      }
      ).toList();
    });
  }

}