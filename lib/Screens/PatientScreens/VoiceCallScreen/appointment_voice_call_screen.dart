import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/PatientScreens/VoiceCallEndedScreen/appointment_voice_call_ended_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

class AppointmentVoiceCallScreen extends StatelessWidget {
  const AppointmentVoiceCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 100.h,
          width: 100.w,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: AlignmentDirectional.bottomEnd,
                  colors: [
                    bgColor,
                    gradientGreenColor
                  ])
          ),
          child: Column(
            children: [
              const Header(text: ""),
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 20,),
              const TextWidget(
                text: "Dr. Dianne Johnson", fontSize: 20,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: textColor, fontFamily: AppFonts.medium,),
              const SizedBox(height: 10,),
              const TextWidget(
                text: "Ringing...", fontSize: 16,
                fontWeight: FontWeight.w400, isTextCenter: false,
                textColor: textColor, fontFamily: AppFonts.regular,),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(()=>AppointmentVoiceCallEndedScreen());
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                          color: redColor,
                          shape: BoxShape.circle
                      ),
                      child: Image.asset(AppIcons.declineCall),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Container(
                    height: 60,
                    width: 60,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: themeColor,
                        shape: BoxShape.circle
                    ),
                    child: Image.asset(AppIcons.activeCall),
                  )
                ],
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
