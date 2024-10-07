import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/SuccessScreen/success_screen.dart';
import 'package:tabibinet_project/model/res/widgets/info_tile.dart';

import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/input_field.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class PrescriptionCreationScreen extends StatelessWidget {
  PrescriptionCreationScreen({super.key});

  final medC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Prescription Creation"),
            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: height1,),
                    TextWidget(
                        text: "Tablet Name", fontSize: 16.sp,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor),
                    SizedBox(height: height2,),
                    InputField(
                      inputController: medC,
                      hintText: "medicine Name",
                    ),
                    SizedBox(height: height1,),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: themeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: const Icon(CupertinoIcons.add,color: themeColor,),
                      ),
                    ),
                    SizedBox(height: height1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: "Dosage", fontSize: 16.sp,
                                fontWeight: FontWeight.w600, isTextCenter: false,
                                textColor: textColor),
                            SizedBox(height: height2,),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: themeColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: const Icon(CupertinoIcons.minus,color: themeColor,),
                                ),
                                const SizedBox(width: 8,),
                                TextWidget(
                                  text: "1 Tablet", fontSize: 16.sp,
                                  fontWeight: FontWeight.w500, isTextCenter: false,
                                  textColor: textColor, fontFamily: AppFonts.medium,),
                                const SizedBox(width: 8,),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: themeColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: const Icon(CupertinoIcons.add,color: themeColor,),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: "Duration", fontSize: 16.sp,
                                fontWeight: FontWeight.w600, isTextCenter: false,
                                textColor: textColor),
                            SizedBox(height: height2,),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: themeColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: const Icon(CupertinoIcons.minus,color: themeColor,),
                                ),
                                const SizedBox(width: 8,),
                                TextWidget(
                                  text: "1 Week", fontSize: 16.sp,
                                  fontWeight: FontWeight.w500, isTextCenter: false,
                                  textColor: textColor, fontFamily: AppFonts.medium,),
                                const SizedBox(width: 8,),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: themeColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: const Icon(CupertinoIcons.add,color: themeColor,),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height1,),
                    TextWidget(
                        text: "Dosage Instructions", fontSize: 16.sp,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor),
                    SizedBox(height: height1,),
                    const InfoTile(title: "Take this medicine at morning before breakfast daily for 10 days."),
                    SizedBox(height: height1,),
                    const SizedBox(height: 30,),
                    SubmitButton(
                      title: "Send Prescription",
                      press: () {
                        Get.to(()=>const SuccessScreen(
                            title: "Prescription Sent Successfully!",
                            subTitle: "Prescription has been sent to the patient"
                        ));
                      },),
                    SizedBox(height: height1,),
                    SubmitButton(
                      title: "Send Via Email",
                      bgColor: bgColor,
                      textColor: themeColor,
                      press: () {

                      },),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
