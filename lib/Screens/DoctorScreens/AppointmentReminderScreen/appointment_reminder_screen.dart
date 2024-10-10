import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/AppointmentReminderDetail/appointment_reminder_detail_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../model/res/constant/app_utils.dart';

class AppointmentReminderScreen extends StatelessWidget {
  const AppointmentReminderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Appointment Reminders"),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('appointmentReminder')
                    .where("userUid" , isEqualTo: auth.currentUser!.uid.toString())
                    .where("status", isEqualTo: "upcoming")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No Appointment Remainder Found'));
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
                      var reminder = snapshot.data!.docs[index];

                      return Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: greyColor
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: reminder["patientName"], fontSize: 16.sp,
                                  fontWeight: FontWeight.w600, isTextCenter: false,
                                  textColor: textColor, fontFamily: AppFonts.semiBold,),
                                const SizedBox(height: 10,),
                                TextWidget(
                                  text: "ID Number: ${reminder['id']}", fontSize: 14.sp,
                                  fontWeight: FontWeight.w400, isTextCenter: false,
                                  textColor: textColor, ),

                              ],
                            ),
                            SubmitButton(
                              width: 26.w,
                              height: 40,
                              title: "View Detail",
                              textColor: themeColor,
                              bgColor: themeColor.withOpacity(0.1),
                              press: () {
                                Get.to(()=> AppointmentReminderDetailScreen(
                                  email: reminder['patientEmail'] ,
                                  name: reminder['patientName'] ,
                                  age: reminder['patientAge'] ,
                                  gender: reminder['patientGender'] ,
                                  location: reminder['location'],
                                  time: reminder['id'],
                                  phone: reminder['patientPhone'],
                                  appointmentDate: reminder['appointmentDate'],
                                  appointmentTime: reminder['appointmentTime'],
                                  deviceToken: reminder['deviceToken'] ?? "",
                                ));
                                log(reminder['patientPhone']);
                              },)
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15,);
                    },
                  );
                },),
            ),
          ],
        ),
      ),
    );
  }
}
