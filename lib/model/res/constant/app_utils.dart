import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/SignUp/sign_up_provider.dart';
import 'package:tabibinet_project/Screens/SuccessScreen/success_screen.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../../../Screens/StartScreens/OtpScreen/otp_screen.dart';
import '../../../global_provider.dart';

class AppUtils{

  final provider = GlobalProviderAccess.profilePro;
  String? getCurrentUserEmail(){

    String email = provider!.doctorEmail;
    return email;
  }

  int generateUniqueNumber() {
    // Generate a random 4-digit number
    int min = 1000,max  = 9999;

    Random random = Random();
    int randomNumber = random.nextInt(max - min + 1) + min;

    // Ensure uniqueness by checking against a list of used numbers
    List<int> usedNumbers = [];
    while (usedNumbers.contains(randomNumber)) {
      randomNumber = random.nextInt(max - min + 1) + min;
    }

    // Add the generated number to the used list
    usedNumbers.add(randomNumber);

    return randomNumber;
  }

  sendMail({
    required String recipientEmail,
    required String otpCode,
    required BuildContext context,
    String request = "",
  }) async {
    // change your email here
    String username = 'n9darsolutions@gmail.com';
    // change your password here
    String password = 'luie wdzf xkaz hrex';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Tabibi-Net')
      ..recipients.add(recipientEmail)
      ..subject = 'One-Time OTP Verification '
      ..text = "Your TabibiNet Verification Code is: $otpCode";

    try {
      await send(message, smtpServer);
      Get.snackbar("OTP SEND", "Email sent successfully");
      Get.to(()=>OtpScreen());
      // Get.to(()=>OtpScreen(otp: otpCode.toString(),));
      if(!context.mounted) return;
      // Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      // if(request == "resend"){
      // }else{
      //   Get.offAll(OtpScreen(otpCode: otpCode,email: recipientEmail));
      // }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  sendReminder({
    required String recipientEmail,
    required String messageText,
    required BuildContext context,
    String request = "",
  }) async {
    // change your email here
    String username = 'tabibinet82@gmail.com';
    // change your password here
    String password = 'wham ksgn qufv upla';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'TabibiNet')
      ..recipients.add(recipientEmail)
      ..subject = 'Appointment Reminder'
      ..text = messageText;

    try {
      await send(message, smtpServer);
      Get.snackbar("Reminder Send", "Reminder sent successfully");
      Get.off(()=> SuccessScreen(
          title: "Reminder Sent Successfully!",
          subTitle: "Reminder has been sent to"
              " the patient about his appointment with you."));

      if(!context.mounted) return;
      // Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      // if(request == "resend"){
      // }else{
      //   Get.offAll(OtpScreen(otpCode: otpCode,email: recipientEmail));
      // }

    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUppercase) {
      ToastMsg().toastMsg(
          toastColor: Colors.white,
          "Password must contain at least one uppercase letter"
      );
      return 'Password must contain at least one uppercase letter';
    }
    if (!hasLowercase) {
      ToastMsg().toastMsg(
          toastColor: Colors.white,
          "Password must contain at least one lowercase letter"
      );
      return 'Password must contain at least one lowercase letter';
    }
    if (!hasDigits) {
      ToastMsg().toastMsg(
          toastColor: Colors.white,
          "Password must contain at least one number"
      );
      return 'Password must contain at least one number';
    }
    if (!hasSpecialCharacters) {
      ToastMsg().toastMsg(
          toastColor: Colors.white,
          "Password must contain at least one special character"
      );
      return 'Password must contain at least one special character';
    }

    return null;
  }

  bool isTimestampDatePassed(int timestamp) {
    DateTime timestampDate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime currentDate = DateTime.now();
    print("object:: $timestamp Object:: ${currentDate.millisecondsSinceEpoch}");
    return timestampDate.isAfter(currentDate);
  }

  int? convertToTimestamp(String dateString) {
    try {
      DateFormat format = DateFormat("EEEE, MMMM d");
      DateTime dateTime = format.parse(dateString);
      return dateTime.millisecondsSinceEpoch;
    } catch (e) {
      return null;
    }
  }

}