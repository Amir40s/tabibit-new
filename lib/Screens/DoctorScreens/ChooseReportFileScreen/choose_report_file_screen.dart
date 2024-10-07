import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/UploadReportFile/upload_report_file_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/input_field.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';

import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/text_widget.dart';

class ChooseReportFileScreen extends StatelessWidget {
  ChooseReportFileScreen({super.key});

  final fileC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Send Report"),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  SizedBox(height: height1,),
                  TextWidget(
                    text: "Choose Report", fontSize: 14.sp,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  InputField(
                    inputController: fileC,
                    hintText: "e.g. CBC",
                  ),
                  SizedBox(height: height1,),
                  Center(
                      child: TextWidget(
                        text: "OR", fontSize: 20.sp,
                        fontWeight: FontWeight.w500, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.medium,)),
                  SizedBox(height: height1,),
                  InkWell(
                    onTap: () {
                      // Get.to(()=>const UploadReportFileScreen());
                    },
                    child: Container(
                      width: 100.w,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: greyColor,
                              width: 1.5
                          )
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: themeColor,
                                shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.add_rounded,color: bgColor,),
                          ),
                          SizedBox(height: height2,),
                          TextWidget(
                              text: "Upload Document", fontSize: 14.sp,
                              fontWeight: FontWeight.w600, isTextCenter: false,
                              textColor: themeColor)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height1,),
                  SubmitButton(
                    title: "Send Document",
                    bgColor: greyColor,
                    textColor: Colors.grey,
                    bdColor: greyColor,
                    press: () {

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
