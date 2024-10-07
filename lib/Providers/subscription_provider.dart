import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tabibinet_project/Screens/StartScreens/PayWallScreens/paywall_screen.dart';

import '../constant.dart';
import '../model/res/widgets/custom_dialog_widget.dart';

class SubscriptionProvider with ChangeNotifier {

  Timer? _timer;

  String _days = "0";

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _usersCollection = 'users';
  bool _isTrialExpired = false;
  bool get isTrialExpired => _isTrialExpired;
  String get days => _days;


  SubscriptionProvider(){
    initialize();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  Future<void> initialize() async {
    if(auth.currentUser?.uid !=null){
      await _checkTrialStatus();
    }
  }

  Future<void> startInitializing() async{
    log("Message: Running initializing every 10 seconds");
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _checkTrialStatus();
    });
  }

  Future<void> startTrial(String uid,String membership) async {
    try {
      DateTime currentDate = DateTime.now();
      await FirebaseFirestore.instance.collection("users")
          .doc(uid).update({
        'trialStartDate': currentDate.toIso8601String(),
        'memberShip ': membership,
      });

      _isTrialExpired = false;
      notifyListeners();
    } catch (e) {
      log("Error starting trial: $e");
    }
  }

  Future<void> _checkTrialStatus() async {
    String uid = auth.currentUser?.uid.toString() ?? "";
    try {
      DocumentSnapshot userDoc = await _firestore.collection(_usersCollection).doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
        String? trialStartDateStr = data?['trialStartDate'];

        if (trialStartDateStr != null) {
          DateTime trialStartDate = DateTime.parse(trialStartDateStr);
          DateTime currentDate = DateTime.now();
          Duration difference = currentDate.difference(trialStartDate);

          log("Message:: Expire Days ${difference.inDays}");
          _days = difference.inDays.toString();
          if (difference.inDays >= 29) {
            _isTrialExpired = true;
            Get.dialog(
                barrierColor: Colors.transparent,
                barrierDismissible: false,
                CustomDialogWidget(
                  title: "Your trial has expired",
                  desc: "Renew the trial and try again",
                  btnText: "Renew Now",
                  press: (){
                    Get.to(PaywallScreen());
                  },
                ));
          } else {
            _isTrialExpired = false;
          }
        } else {
          _isTrialExpired = false;
        }
      } else {
        _isTrialExpired = false;
      }

      notifyListeners();
    } catch (e) {
      log("Error checking trial status: $e");
    }
  }
}