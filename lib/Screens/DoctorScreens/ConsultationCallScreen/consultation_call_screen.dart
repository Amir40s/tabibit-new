import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../ConsultationCallEndScreen/consultation_call_end_screen.dart';

class ConsultationCallScreen extends StatelessWidget {
  const ConsultationCallScreen({super.key});

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
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 180,
                  width: 100,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: secondaryGreenColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: greyColor,
                            blurRadius: 2,
                            spreadRadius: .5
                        )
                      ]
                  ),
                  child: const Align(
                      alignment: Alignment.topLeft,
                      child: Icon(CupertinoIcons.camera_rotate,color: themeColor,size: 20,)),
                ),
              ),
              const Spacer(),
              const SizedBox(height: 20,),
              const TextWidget(
                text: "Dr. Jonny Smith", fontSize: 20,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: bgColor, fontFamily: AppFonts.medium,),
              const SizedBox(height: 10,),
              const TextWidget(
                text: "12:40 mins", fontSize: 16,
                fontWeight: FontWeight.w400, isTextCenter: false,
                textColor: bgColor, fontFamily: AppFonts.regular,),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(()=> ConsultationCallEndScreen());
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
                    child: SvgPicture.asset(AppIcons.micIcon),
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
                    child: SvgPicture.asset(AppIcons.speakerIcon),
                  ),
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
