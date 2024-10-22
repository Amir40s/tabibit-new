import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/data/appointment_model.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../global_provider.dart';

class CallDataProvider extends ChangeNotifier{


  List<AppointmentModel> _appointments = [];

  double _starsRating = 0.0;
   String _callDuration = "";
   bool _callType = false;

   bool _isLoading = false;

  // getter
  List<AppointmentModel> get appointments => _appointments;
  String get callDuration => _callDuration;
  bool get callType => _callType;
  double get starsRating => _starsRating;
  bool get isLoading => _isLoading;

  // setter
  void setAppointments(AppointmentModel model,bool type) {
    if(_appointments.isNotEmpty){
      _appointments.clear();
    }
    _appointments.add(model);
    _callType = type;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setCallData(String callDuration){
    _callDuration = callDuration;
    notifyListeners();
  }


  void updateCallStatus(String appointID) async{
   await fireStore.collection("appointment")
       .doc(appointID).update(
      {"status" : "complete"});

   final patientNotificationProvider = GlobalProviderAccess.patientNotificationPro;

   patientNotificationProvider!.storeNotification(
       title: "Appointment Completed",
       subTitle: "You have completed the appointment",
       type: "appointment");
  }

  void setStarsRating(double starsRating){
    _starsRating = starsRating;
    notifyListeners();
  }


  Future<void> saveRating({
    required String doctorId,
    required String appointID,
    required String comment
  })async{

    _isLoading = true;
    notifyListeners();

    double newRating = 0.0,totalRating = 0.0;
    int reviewsCount = 0;
    final data =   await fireStore.collection("users").doc(doctorId).get();

    final docData = data.data();
    if(docData!= null){
      final userRating = double.parse(docData["totalRating"] ?? 0.0);
       reviewsCount = int.parse(docData["reviews"] ?? 0);
       if(userRating != 0.0) {
         totalRating = userRating + _starsRating;
         newRating = totalRating / 2;
       } else{
         totalRating = _starsRating;
         newRating = _starsRating;
       }

      reviewsCount = reviewsCount +1;

      log("UserRating: $userRating and reviewsCount: $reviewsCount");
      log("UserRating Updated rating: $newRating");
    }

    await fireStore.collection("users").doc(doctorId).update(
      {
        "totalRating" : totalRating.toString(),
        "rating" : newRating.toString(),
        "reviews" : reviewsCount.toString(),
      });

    await fireStore.collection("users").doc(doctorId)
        .collection("reviews").add(
        {
          "rating" : _starsRating.toString(),
          "name" : _appointments[0].patientName,
          "uid" : _appointments[0].patientId,
          "appointmentId" : _appointments[0].id,
          "comment" : comment,
        });

    await fireStore.collection("users").doc(auth.currentUser?.uid.toString())
        .collection("reviews").add(
        {
          "rating" : _starsRating.toString(),
          "name" : _appointments[0].doctorName,
          "uid" : _appointments[0].patientId,
          "appointmentId" : _appointments[0].id,
          "comment" : comment,
        });

    final patientNotificationProvider = GlobalProviderAccess.patientNotificationPro;

    patientNotificationProvider!.storeNotification(
        title: "${_appointments[0].patientName} send feedback",
        subTitle: "You have one more feedback from client",
        type: "feedback");

    await fireStore.collection("appointment")
        .doc(_appointments[0].id).update({
      "isReview" : "true"
    });

    clear();
    ToastMsg().toastMsg("Thanks for your feedback");


  }



  void clear(){
    _appointments.clear();
    _starsRating = 0.0;
    _callDuration = "";
    _callType = false;
    _isLoading = false;
    notifyListeners();
  }


}