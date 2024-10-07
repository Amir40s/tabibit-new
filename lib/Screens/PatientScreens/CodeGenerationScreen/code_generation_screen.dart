import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';

import '../../../../constant.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';
import '../PaymentCodeScreen/payment_code_screen.dart';

class CodeGenerationScreen extends StatelessWidget {
  const CodeGenerationScreen({super.key});

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
                      text: "Click here to generate Code for Payment",
                      fontSize: 24,maxLines: 3,
                      fontWeight: FontWeight.w500, isTextCenter: true,
                      textColor: textColor, fontFamily: AppFonts.medium,),
                  ),
                  const SizedBox(height: 30,),
                  SubmitButton(
                    title: "Generate Code",
                    press: () {
                      Get.to(()=>PaymentCodeScreen());
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
