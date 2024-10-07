import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/LabReportScreen/lab_report_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';

import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class PatientLabReportScreen extends StatelessWidget {
  const PatientLabReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header2(text: "Patient's Lab Reports"),
            Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    itemBuilder: (context, index) {
                      // final user = users[index];
                      return Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: greyColor
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: "Micheal Rickliff", fontSize: 16.sp,
                                  fontWeight: FontWeight.w600, isTextCenter: false,
                                  textColor: textColor, fontFamily: AppFonts.semiBold,),
                                const SizedBox(height: 10,),
                                TextWidget(
                                  text: "Report: CBC", fontSize: 14.sp,
                                  fontWeight: FontWeight.w400, isTextCenter: false,
                                  textColor: textColor, ),
                              ],
                            ),
                            SubmitButton(
                              width: 26.w,
                              height: 40,
                              title: "View Detail",
                              textColor: themeColor,
                              bgColor: themeColor.withOpacity(0.1),
                              press: () {
                                // Get.to(()=> const LabReportScreen(date: "",));
                              },)
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15,);
                    },
                    itemCount: 10
                )
            )
          ],
        ),
      ),
    );
  }
}
