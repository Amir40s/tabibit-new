import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

class CustomDialogWidget extends StatelessWidget {
  String? title,desc,btnText;
  double? topHeight,descHeight,horizontalPadding,verticalPadding;
  VoidCallback? press;
  Color? bgColor;
  CustomDialogWidget({super.key,this.title,
    this.desc,
    this.btnText,
    this.press,
    this.topHeight,
    this.descHeight,
    this.horizontalPadding,
    this.verticalPadding,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 1.w,
          vertical: verticalPadding ?? 2.w),
      margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 35.h),
      decoration: BoxDecoration(
        color:bgColor ?? Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: topHeight ?? 2.w,),
          TextWidget(
            text: title ?? "Thank You for your purchase!",
            fontSize: 16.0,
            textColor: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: descHeight ?? 4.w,),
          TextWidget(
            text: desc ?? "Your payment of \$99.99 for the Annual Plan has been successfully processed.",
            fontSize: 13.0,
            textColor: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(height: 4.w,),
          SubmitButton(
            title: btnText ?? "continue",
            height: 40.0,
            width: 35.w,
            press: press ?? (){
              // Get.toNamed(RoutesName.freeTrialEndsScreen);
            },
          ),
          SizedBox(height: 2.w,),
        ],
      ),
    );
  }
}