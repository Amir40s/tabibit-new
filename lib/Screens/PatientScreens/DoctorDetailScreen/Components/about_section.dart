import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constant.dart';
import '../../../../../model/res/constant/app_fonts.dart';
import '../../../../../model/res/widgets/submit_button.dart';
import '../../../../../model/res/widgets/text_widget.dart';
import '../../AppointmentScheduleScreen/appointment_schedule_screen.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({
    super.key,
    required this.doctorDetail
  });

  final String doctorDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      height: 29.h,
      width: 100.w,
      decoration: const BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: "About Doctor", fontSize: 20.sp,
            fontWeight: FontWeight.w600, isTextCenter: false,
            textColor: textColor, fontFamily: AppFonts.semiBold,),
          SizedBox(
            height: 12.h,
            child: Scrollbar(
              radius: const Radius.circular(10),
              thumbVisibility: true,
              child: ListView(
                shrinkWrap: true,
                children: [
                  TextWidget(
                    text: doctorDetail,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400, isTextCenter: false,
                    textColor: textColor,maxLines: 10,)
                ] ,
              ),
            ),
          ),
          const Spacer(),
          SubmitButton(
            title: "Make an appointment",
            press: () {
              Get.to(()=>AppointmentScheduleScreen());
            },)
        ],
      ),
    );
  }
}
