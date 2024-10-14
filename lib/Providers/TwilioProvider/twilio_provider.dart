import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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

  Future<void> sendSmsReminder(String toPhoneNumber, String message) async {
    try {
      await _twilioService.sendSmsReminder(toPhoneNumber, message);
      Get.off(()=> SuccessScreen(
          title: "Reminder Sent Successfully!",
          subTitle: "Reminder has been sent to"
              " the patient about his appointment with you."));      notifyListeners();
    } catch (e) {
      log('Error sending SMS: $e');
      ToastMsg().toastMsg("Something went wrong!",toastColor: redColor);
    }
  }
}
