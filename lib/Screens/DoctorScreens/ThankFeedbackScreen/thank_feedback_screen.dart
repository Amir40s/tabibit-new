import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/DoctorHomeScreen/doctor_home_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_assets.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

class ThankFeedbackScreen extends StatelessWidget {
  const ThankFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            SvgPicture.asset(AppAssets.partyPopImage),
            SvgPicture.asset(AppIcons.doneIcon),
            const SizedBox(height: 20,),
            TextWidget(
                text: "Thank you for the feedback!",
                fontSize: 18.sp, fontWeight: FontWeight.w600,
                isTextCenter: false, textColor: textColor, fontFamily: AppFonts.semiBold,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextWidget(
                  text: "Lorem Ipsum Lorem Ipsum Lorem Ipsum",
                  fontSize: 16.sp, fontWeight: FontWeight.w400, maxLines: 2,
                  isTextCenter: true, textColor: textColor),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SubmitButton(
            title: "Go to Dashboard",
            press: () {
              Get.offAll(()=> DoctorHomeScreen());
            },),
        ),
      ),
    );
  }
}
