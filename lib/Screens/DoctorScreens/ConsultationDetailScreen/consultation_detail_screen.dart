import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/ConsultationCallScreen/consultation_call_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';

import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/info_tile.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class ConsultationDetailScreen extends StatelessWidget {
  const ConsultationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height1 = 20;
    double height2 = 10;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Consultation Detail"),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: "Patient Details", fontSize: 18.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: textColor, fontFamily: AppFonts.semiBold,),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: themeColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: SvgPicture.asset(AppIcons.editIcon),
                        )
                      ],
                    ),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Full Name", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    const InfoTile(title: "Micheal Rickliff"),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Age", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    const InfoTile(title: "22"),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Gender", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    const InfoTile(title: "Male"),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Time of Appointment", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    const InfoTile(title: "12:30 - 4 Aug"),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Consultation Type", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    const InfoTile(title: "Video"),
                    const SizedBox(height: 30,),
                    SubmitButton(
                      title: "Start Consultation",
                      bgColor: const Color(0xff04AD01).withOpacity(0.1),
                      textColor: const Color(0xff04AD01),
                      bdColor: const Color(0xff04AD01),
                      press: () {
                        Get.to(()=>const ConsultationCallScreen());
                      },),
                    SizedBox(height: height2,),
                    SubmitButton(
                      title: "Skip Consultation",
                      bgColor: const Color(0xffF23A00).withOpacity(0.1),
                      textColor: const Color(0xffF23A00),
                      bdColor: const Color(0xffF23A00),
                      press: () {

                      },),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
