import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';

import '../../../../constant.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';
import '../../../model/res/constant/app_assets.dart';
import '../CopyCodeScreen/copy_code_screen.dart';

class PaymentCodeScreen extends StatelessWidget {
  const PaymentCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
           const Header(text: "Payment Code"),
           Expanded(
               child: ListView(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 children: [
                   SizedBox(height: height1,),
                   const TextWidget(
                     text: "Go to your preferred bank branch or"
                         " use their online/mobile banking platform"
                         " to pay through this code",
                     fontSize: 20, fontWeight: FontWeight.w500,
                     isTextCenter: true, textColor: textColor,maxLines: 4,
                   ),
                   const SizedBox(height: 30,),
                   Container(
                     width: 100.w,
                     padding: const EdgeInsets.symmetric(vertical: 20),
                     decoration: BoxDecoration(
                         color: secondaryGreenColor,
                         borderRadius: BorderRadius.circular(12),
                         border: Border.all(color: greenColor)
                     ),
                     child: Column(
                       children: [
                         SvgPicture.asset(AppAssets.qrImage),
                         SizedBox(height: height1,),
                         const TextWidget(
                             text: "#77826BCKKShx",
                             fontSize: 24, fontWeight: FontWeight.w600,
                             isTextCenter: false, textColor: textColor),
                       ],
                     ),
                   ),
                   SizedBox(height: height1,),
                   const TextWidget(
                     text: "Take this code to any bank to pay for your booking",
                     fontSize: 16, fontWeight: FontWeight.w400,
                     isTextCenter: false, textColor: textColor,maxLines: 2,
                   ),
                   SizedBox(height: height1,),
                   SubmitButton(
                     title: "Copy this code",
                     press: () {
                       Get.to(()=>CopyCodeScreen());
                   },),
                   SizedBox(height: height1,),
                   const TextWidget(
                     text: "Code will expires within 3 days",
                     fontSize: 24, fontWeight: FontWeight.w500, fontFamily: AppFonts.medium,
                     isTextCenter: true, textColor: textColor,maxLines: 2,
                   ),
                   SizedBox(height: height1,),
                 ],
           ))
          ],
        ),
      ),
    );
  }
}
