

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tabibinet_project/model/data/review_model.dart';

import '../../constant.dart';
import '../../model/data/report_model.dart';

class StreamDataProvider extends ChangeNotifier{

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<ReviewModel>> getDoctorReviews({int? limit,required String docId}) {
    Query query = firestore.collection("users")
    .doc(docId)
    .collection("reviews");
    if (limit != null) {
      query = query.limit(limit);
    }
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ReviewModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<ReportModel>> fetchReport({required String appointmentId}) {
    return fireStore.collection('appointment')
        .doc(appointmentId)
        .collection("report")
        .snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ReportModel.fromDocumentSnapshot(doc)).toList();
    });
  }


}