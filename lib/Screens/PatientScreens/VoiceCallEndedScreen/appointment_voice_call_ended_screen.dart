import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/PatientScreens/ReviewScreen/appointment_review_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/dotted_line.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

class AppointmentVoiceCallEndedScreen extends StatelessWidget {
  const AppointmentVoiceCallEndedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.sp,),
                const TextWidget(
                  text: "Voice Call Ended", fontSize: 16,
                  fontWeight: FontWeight.w500, isTextCenter: false,
                  textColor: redColor, fontFamily: AppFonts.medium,),
                const SizedBox(height: 10,),
                const TextWidget(
                  text: "24:00 Minutes", fontSize: 24,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: themeColor, fontFamily: AppFonts.medium,),
                const SizedBox(height: 10,),
                const TextWidget(
                  text: "Recording have been saved in history", fontSize: 14,
                  fontWeight: FontWeight.w400, isTextCenter: false,
                  textColor: textColor,),
                const SizedBox(height: 30,),
                const DottedLine(color: greyColor,),
                const SizedBox(height: 30,),
                Container(
                  height: 160,
                  width: 160,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 30,),
                const TextWidget(
                  text: "Dr. Dianne Johnson", fontSize: 20,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.medium,),
                const SizedBox(height: 10,),
                const TextWidget(
                  text: "Cardiologist", fontSize: 14,
                  fontWeight: FontWeight.w400, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.regular,),
                const SizedBox(height: 10,),
                const TextWidget(
                  text: "Cefixime New Hospital", fontSize: 12,
                  fontWeight: FontWeight.w400, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.regular,),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubmitButton(
                      width: 40.w,
                      title: "Back to Home",
                      bgColor: secondaryGreenColor,
                      textColor: themeColor,
                      press: () {

                      },),
                    SubmitButton(
                      width: 40.w,
                      title: "Leave a Review",
                      press: () {
                        Get.to(()=>AppointmentReviewScreen());
                      },),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
