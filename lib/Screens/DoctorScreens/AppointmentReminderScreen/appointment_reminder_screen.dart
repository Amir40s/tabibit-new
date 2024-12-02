import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/FindDoctor/find_doctor_provider.dart';
import 'package:tabibinet_project/Providers/Language/new/translation_new_provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/AppointmentReminderDetail/appointment_reminder_detail_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/data/appointment_remainder_model.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../model/res/constant/app_utils.dart';

class AppointmentReminderScreen extends StatelessWidget {
  const AppointmentReminderScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final doctorP = Provider.of<FindDoctorProvider>(context,listen: false);
    final transP = Provider.of<TranslationProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Appointment Reminders"),
            Expanded(
              child: Consumer<TranslationNewProvider>(
               builder: (context, provider, child){
                 return StreamBuilder<List<AppointmentRemainderModel>>(
                   stream: doctorP.fetchAppointmentRemainder(),
                   builder: (context, snapshot) {
                     if (snapshot.connectionState == ConnectionState.waiting) {
                       return const Center(child: CircularProgressIndicator());
                     } else if (snapshot.hasError) {
                       return Center(child: Text('Error: ${snapshot.error}'));
                     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                       return const Center(child: Text('No Appointment Remainder Found'));
                     }

                     final remainders  = snapshot.data!;


                     if (provider.appointmentRemainder.isEmpty) {
                       provider.translateAppointmentRemainder(
                         remainders.map((e) => e.patientName).toList() +
                             remainders.map((e) => e.patientEmail).toList() +
                             remainders.map((e) => e.patientGender).toList() +
                             remainders.map((e) => e.patientProblem).toList() +
                             remainders.map((e) => e.location).toList() +
                             remainders.map((e) => e.appointmentDate).toList(),
                       );
                     }



                     return ListView.separated(
                       shrinkWrap: true,
                       itemCount: snapshot.data!.length,
                       padding: const EdgeInsets.symmetric(horizontal: 20),
                       itemBuilder: (context, index) {
                         var reminder = remainders[index];
                         final patientName = provider.appointmentRemainder[reminder.patientName] ?? reminder.patientName;

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
                                     text: patientName, fontSize: 16.sp,
                                     fontWeight: FontWeight.w600, isTextCenter: false,
                                     textColor: textColor, fontFamily: AppFonts.semiBold,),
                                   const SizedBox(height: 10,),
                                   TextWidget(
                                     text: "${transP.translatedTexts["ID Number:"] ?? "ID Number:"} ${reminder.id}", fontSize: 14.sp,
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
                                     email: reminder.patientEmail ,
                                     name: reminder.patientName ,
                                     age: reminder.patientAge ,
                                     gender: reminder.patientGender ,
                                     location: reminder.location,
                                     time: reminder.id,
                                     phone: reminder.patientPhone,
                                     patientId: reminder.patientId,
                                     appointmentDate: reminder.appointmentDate,
                                     appointmentTime: reminder.appointmentTime,
                                     deviceToken: reminder.deviceToken ?? "",
                                   ));
                                   log(reminder.patientPhone);
                                 },
                               )
                             ],
                           ),
                         );
                       },
                       separatorBuilder: (context, index) {
                         return const SizedBox(height: 15,);
                       },
                     );
                   },);
               },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
