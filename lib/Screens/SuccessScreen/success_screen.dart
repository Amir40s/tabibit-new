import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/StartScreens/PayWallScreens/paywall_screen.dart';

import '../../../constant.dart';
import '../../../model/res/constant/app_assets.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.title,
    required this.subTitle,
    this.title3,
  });

  final String title;
  final String subTitle;
  final String? title3;

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
              Center(
                child: TextWidget(
                    text: title, fontSize: 24,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor),
              ),
              SizedBox(height: height1,),
              Center(
                child: TextWidget(
                  text: subTitle, fontSize: 14,
                  fontWeight: FontWeight.w400, isTextCenter: true,
                  textColor: textColor,maxLines: 5,),
              ),
              SizedBox(height: height1,),
              Center(
                child: TextWidget(
                    text: title3 ?? "", fontSize: 24,
                    fontWeight: FontWeight.w600, isTextCenter: true,
                    textColor: textColor),
              ),
              SizedBox(height: height2,),
              const Spacer(),
              SubmitButton(
                title: "Okay!",
                press: () {
                  if(title == "Reset Successfully!"){
                    Get.to(()=>PaywallScreen());
                  }else {
                    Get.back();
                  }
                },),
              SizedBox(height: height2,),
            ],
          ),
        ),
      ),
    );
  }
}
