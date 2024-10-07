import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/info_tile.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../SuccessScreen/success_screen.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({
    super.key,
    required this.appBarText,
    required this.email,
    required this.name,
    required this.age,
    required this.gender,
    required this.time,
    required this.location,
  });

  final String appBarText,name,age,gender,time,location,email;


  @override
  Widget build(BuildContext context) {
    double height1 = 20;
    double height2 = 10;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            Header(text: appBarText),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Patient Phone Number", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    const InfoTile(title: "+3874874992838"),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Appointment Date", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    const InfoTile(title: " 4 August"),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Appointment Time", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    const InfoTile(title: "12:00"),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Custom Message", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    const InfoTile(
                        title: "Hello, Your Time of Appointment is"
                        " mentions please be on time for doctor appointment"),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Consultation Type", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    const InfoTile(title: "Video"),
                    SizedBox(height: height1,),
                    SubmitButton(
                      title: "Send Reminder",
                      press: () {
                        Get.to(()=>const SuccessScreen(
                            title: "Reminder Sent Successfully!",
                            subTitle: "Reminder has been sent to the patient"
                                " about his appointment with you."
                        ));
                      },)
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
