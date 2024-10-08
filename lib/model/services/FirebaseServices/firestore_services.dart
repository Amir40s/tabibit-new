import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/schedule_model.dart';

class FireStoreServices{

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<ScheduleItem>> getSchedules() {
    return _db.collection('bannerAds').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ScheduleItem.fromFirestore(doc.data());
      }).toList();
    });
  }

}