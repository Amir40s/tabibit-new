import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../constant.dart';
import '../constant/app_fonts.dart';

class AppointmentContainer extends StatelessWidget {
  const AppointmentContainer({
    super.key,
    required this.patientName,
    required this.patientPhone,
    required this.patientAge,
    required this.patientGender,
    required this.statusText,
    required this.text1,
    required this.text2,
    required this.statusTextColor,
    required this.boxColor,
    this.onTap,
    this.statusTap,
  });

  final String patientName;
  final String patientPhone;
  final String patientAge;
  final String patientGender;
  final String statusText;
  final String text1;
  final String text2;
  final Color boxColor;
  final Color statusTextColor;
  final VoidCallback? onTap;
  final VoidCallback? statusTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? (){},
      child: Container(
        width: 100.w,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: greyColor
            )
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: patientName, fontSize: 16.sp,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.semiBold,),
                TextWidget(
                  text: "Phone Number:\n $patientPhone", fontSize: 12.sp,
                  fontWeight: FontWeight.w400, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.regular,),
                TextWidget(
                  text: "Age: $patientAge", fontSize: 12.sp,
                  fontWeight: FontWeight.w400, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.regular,),
                TextWidget(
                  text: "Gender: $patientGender", fontSize: 12.sp,
                  fontWeight: FontWeight.w400, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.regular,),
                TextWidget(
                  text: "Complaint: Heart Burn", fontSize: 12.sp,
                  fontWeight: FontWeight.w400, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.regular,),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: text1, fontSize: 12.sp,
                  fontWeight: FontWeight.w400, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.regular,),
                SizedBox(
                  width: 28.w,
                  child: TextWidget(
                    text: text2, fontSize: 10.sp, maxLines: 2,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                ),
                SizedBox(height: .5.h,),

                InkWell(
                  onTap: statusTap,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: boxColor,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: TextWidget(
                      text: statusText, fontSize: 16,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: statusTextColor,
                      fontFamily: AppFonts.medium,),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
