import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class EmrScreen extends StatelessWidget {
  const EmrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(text: "Patient Management"),
            SizedBox(height: height1,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextWidget(
                text: "Personal Details", fontSize: 18.sp,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: textColor, fontFamily: AppFonts.semiBold,),
            ),
            SizedBox(height: height1,),
            Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) {
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
                              children: [
                                TextWidget(
                                  text: "Micheal Rickliff", fontSize: 16.sp,
                                  fontWeight: FontWeight.w600, isTextCenter: false,
                                  textColor: textColor, fontFamily: AppFonts.semiBold,),
                                const SizedBox(height: 10,),
                                TextWidget(
                                  text: "ID Number: #33883", fontSize: 14.sp,
                                  fontWeight: FontWeight.w400, isTextCenter: false,
                                  textColor: textColor, ),
                              ],
                            ),
                            SubmitButton(
                              width: 26.w,
                              height: 42,
                              title: "View Reports",
                              textColor: themeColor,
                              bgColor: themeColor.withOpacity(0.1),
                              press: () {
                                // Get.to(()=>const EmrDetailScreen());
                              },)
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15,);
                    },
                    itemCount: 2
                )
            ),
            SizedBox(height: height1,),
          ],
        ),
      ),
    );
  }}
