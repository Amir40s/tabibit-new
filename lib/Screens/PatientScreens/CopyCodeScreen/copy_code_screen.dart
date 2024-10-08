import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../constant.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';
import '../BookingConfirmedScreen/booking_confirmed_screen.dart';

class CopyCodeScreen extends StatelessWidget {
  const CopyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Make Payment"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Container(
                    width: 100.w,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: secondaryGreenColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: greenColor)
                    ),
                    child: const TextWidget(
                      text: "#77826BCKKShx",
                      fontSize: 24,maxLines: 1,
                      fontWeight: FontWeight.w500, isTextCenter: true,
                      textColor: textColor, fontFamily: AppFonts.medium,),
                  ),
                  const SizedBox(height: 20,),
                  const TextWidget(
                      text: "This payment is still remaining",
                      fontSize: 12, fontWeight: FontWeight.w400,
                      isTextCenter: false, textColor: textColor
                  ),
                  const SizedBox(height: 30,),
                  SubmitButton(
                    title: "Confirm Booking",
                    bgColor: greyColor,
                    textColor: Colors.grey,
                    bdColor: greyColor,
                    press: () {
                      Get.to(()=>BookingConfirmedScreen());
                    },)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}