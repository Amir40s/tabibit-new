import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../../constant.dart';
import '../../../model/res/constant/app_assets.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class CancelSuccessfulScreen extends StatelessWidget {
  const CancelSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height1 = 10.0;
    double height2 = 30.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(AppAssets.success,height: 25.h,),
              SizedBox(height: height2,),
              const Center(
                child: TextWidget(
                    text: "Cancel Successfully!", fontSize: 24,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor),
              ),
              SizedBox(height: height1,),
              const Center(
                child: TextWidget(
                  text: "Your password has been reset successfully."
                      " Please login with new credentials.", fontSize: 14,
                  fontWeight: FontWeight.w400, isTextCenter: true,
                  textColor: textColor,maxLines: 2,),
              ),
              SizedBox(height: height2,),
              const Spacer(),
              SubmitButton(
                title: "Okay!",
                press: () {
                  Get.back();
                },),
              SizedBox(height: height2,),
            ],
          ),
        ),
      ),
    );
  }
}
