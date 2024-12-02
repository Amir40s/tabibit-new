import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tabibinet_project/Providers/actionProvider/actionProvider.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../../Screens/SuccessScreen/success_screen.dart';
import '../../model/api_services/twillo_services.dart';

class TwilioProvider with ChangeNotifier {
  final TwilioService _twilioService;

  TwilioProvider({
    required String accountSid,
    required String authToken,
    required String twilioPhoneNumber,
  }) : _twilioService = TwilioService(
    accountSid: accountSid,
    authToken: authToken,
    twilioPhoneNumber: twilioPhoneNumber,
  );

  Future<bool> checkPhoneNumberExists(String phoneNumber) async {
    try {
      var userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();
      return userSnapshot.docs.isNotEmpty;
    } catch (e) {
      log("Error checking phone number: $e");
      return false;
    }
  }


  Future<void> sendSmsReminder(String toPhoneNumber, String message,{String type = "other"}) async {
    try {
      await _twilioService.sendSmsReminder(toPhoneNumber, message);
      if(type == "remainder"){
        ActionProvider().stopLoading();
        Get.off(()=> SuccessScreen(
            title: "Reminder Sent Successfully!",
            subTitle: "Reminder has been sent to"
                " the patient about his appointment with you."));
      }
      notifyListeners();
    } catch (e) {
      log('Error sending SMS: $e');
      ToastMsg().toastMsg("Something went wrong!",toastColor: redColor);
    }
  }
}
