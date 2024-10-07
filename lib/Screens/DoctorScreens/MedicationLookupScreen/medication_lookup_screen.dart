import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/DosageCalculatorScreen/dosage_calculator_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_assets.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';

import '../../../model/res/widgets/text_widget.dart';

class MedicationLookupScreen extends StatelessWidget {
  const MedicationLookupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    // double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor,
        body: Column(
          children: [
            const Header(
              text: "Medication Lookup",
              iconColor: themeColor,
              boxColor: bgColor,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: 100.w,
                decoration: const BoxDecoration(
                  color: secondaryGreenColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Image.asset(AppAssets.medicineImage,height: 25.h,)),
                    SizedBox(height: height1,),
                    TextWidget(
                        text: "Omeprazol", fontSize: 18.sp,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor),
                    SizedBox(height: height1,),
                    TextWidget(
                        text: "Omeprazole is a proton pump inhibitor (PPI)"
                            " used to reduce the amount of acid produced in"
                            " the stomach. It's primarily used to treat conditions"
                            " like heartburn, ulcers, and acid reflux. Side effects"
                            " include Headache, Stomach ache, Diarrhea and Nausea.",
                      fontSize: 12.sp,  fontWeight: FontWeight.w400,
                      isTextCenter: false,textColor: textColor,maxLines: 10,),
                    SizedBox(height: height1,),
                    SubmitButton2(
                      title: "Check Interaction",
                      icon: AppIcons.checkInteractionIcon,
                      press: () {

                    },),
                    SizedBox(height: height1,),
                    SubmitButton2(
                      title: "Calculate Dosage",
                      icon: AppIcons.calculateDosageIcon,
                      iconColor: themeColor,
                      textColor: themeColor,
                      bgColor: secondaryGreenColor,
                      press: () {
                        Get.to(()=>DosageCalculatorScreen());
                      },),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
