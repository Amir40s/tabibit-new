import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_assets.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/input_field.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../ThankFeedbackScreen/thank_feedback_screen.dart';

class ConsultationCallEndScreen extends StatelessWidget {
  ConsultationCallEndScreen({super.key});

  final feedBackC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = 20.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
                Stack(
                  alignment: Alignment.topRight,
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      width: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.asset(AppAssets.image_1,fit: BoxFit.cover,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.asset(AppAssets.image_2,fit: BoxFit.cover,),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height,),
                TextWidget(
                  text: "Your session with Micheal is complete! 🎉",
                  fontSize:  19.sp, fontWeight: FontWeight.w600,
                  isTextCenter: true, textColor: textColor, maxLines: 2,),
                SizedBox(height: height,),
                Container(
                  width: 100.w,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "Sarah Kevin", fontSize: 18.sp,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: bgColor, fontFamily: AppFonts.medium,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: "Heart Burn", fontSize: 16.sp,
                            fontWeight: FontWeight.w600, isTextCenter: false,
                            textColor: bgColor, fontFamily: AppFonts.medium,),
                          SubmitButton(
                            width: 30.w,
                            height: 40,
                            title: "Completed",
                            bgColor: Colors.green,
                            press: () {

                            },)
                        ],
                      ),
                      TextWidget(
                        text: "09:00 AM - 09:30 AM", fontSize: 12.sp,
                        fontWeight: FontWeight.w400, isTextCenter: false,
                        textColor: bgColor, fontFamily: AppFonts.regular,),
                      const SizedBox(height: 5,),
                      TextWidget(
                        text: "Teleconsultation", fontSize: 12.sp,
                        fontWeight: FontWeight.w400, isTextCenter: false,
                        textColor: bgColor, fontFamily: AppFonts.regular,),
                      const SizedBox(height: 10,),
                      SubmitButton(
                        height: 40,
                        title: "View Details",
                        bdColor: bgColor,
                        press: () {

                        },),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
                SizedBox(height: height,),
                Container(
                  width: 100.w,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: greyColor,
                            blurRadius: 1.5
                        )
                      ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "We would love to hear from you", fontSize: 16.sp,
                        fontWeight: FontWeight.w500, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.medium,),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(CupertinoIcons.heart_fill,color: themeColor,size: 24.sp,),
                          Icon(CupertinoIcons.heart_fill,color: themeColor,size: 24.sp,),
                          Icon(CupertinoIcons.heart_fill,color: themeColor,size: 24.sp,),
                          Icon(CupertinoIcons.heart_fill,color: themeColor,size: 24.sp,),
                          Icon(CupertinoIcons.heart_fill,color: themeColor,size: 24.sp,),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      InputField3(
                        inputController: feedBackC,
                        labelText: "Feedback",
                        hintText: "Write your feedback here",
                        maxLines: 5,
                      ),
                      const SizedBox(height: 10,),
                      SubmitButton(
                        title: "Submit",
                        press: () {
                          Get.to(()=>const ThankFeedbackScreen());
                        },),
                      const SizedBox(height: 10,),
                      Center(
                        child: TextWidget(
                          text: "Skip & Go to Dashboard", fontSize: 16.sp,
                          fontWeight: FontWeight.w400, isTextCenter: false,
                          textColor: themeColor, fontFamily: AppFonts.semiBold,),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
