import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../constant.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/widgets/dotted_line.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';

class MyAppointmentContainer extends StatelessWidget {
  const MyAppointmentContainer({
    super.key,
    required this.onTap,
    required this.rightButtonTap,
    required this.leftButtonTap,
    required this.doctorName,
    required this.image,
    required this.rightButtonText,
    required this.leftButtonText,
    required this.appointmentStatusText,
    required this.chatStatusText,
    required this.appointmentTimeText,
    required this.ratingText,
    required this.appointmentIcon,
    required this.statusTextColor,
    required this.statusBoxColor,
    this.isPrimaryButtons = true,
  });

  final VoidCallback onTap;
  final VoidCallback leftButtonTap;
  final VoidCallback rightButtonTap;
  final String doctorName;
  final String image;
  final String rightButtonText;
  final String leftButtonText;
  final String appointmentStatusText;
  final String chatStatusText;
  final String appointmentTimeText;
  final String ratingText;
  final String appointmentIcon;
  final Color statusBoxColor;
  final Color statusTextColor;
  final bool? isPrimaryButtons;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: greyColor,
                width: 1.5
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(13),
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(image)),
                    color: skyBlueColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 35.w,
                      child: TextWidget(
                        text: doctorName, fontSize: 16,
                        fontWeight: FontWeight.w600, isTextCenter: false,maxLines: 2,
                        textColor: textColor, fontFamily: AppFonts.semiBold,),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20.w,
                          child: TextWidget(
                            text: "$chatStatusText - ", fontSize: 14,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: textColor, fontFamily: AppFonts.regular,),
                        ),
                        const SizedBox(width: 5,),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: statusBoxColor,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: TextWidget(
                            text: appointmentStatusText, fontSize: 12,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: statusTextColor, fontFamily: AppFonts.regular,),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Icon(Icons.star,color: Colors.yellow,size: 20,),
                        TextWidget(
                          text: ratingText, fontSize: 12,
                          fontWeight: FontWeight.w400, isTextCenter: false,
                          textColor: textColor, fontFamily: AppFonts.regular,),
                        const SizedBox(width: 5,),
                        const Icon(Icons.circle,color: textColor,size: 5,),
                        const SizedBox(width: 5,),
                        const Icon(Icons.access_time_filled_rounded,color: themeColor, size: 20,),
                        const SizedBox(width: 5,),
                        SizedBox(
                          width: 26.w,
                          child: TextWidget(
                            text: appointmentTimeText, fontSize: 12.sp,
                            fontWeight: FontWeight.w400, isTextCenter: false,maxLines: 2,
                            textColor: themeColor, fontFamily: AppFonts.regular,),
                        ),

                      ],
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  height: 35,
                  width: 35,
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.circular(6),
                  ),
                  child: SvgPicture.asset(appointmentIcon),
                )
              ],
            ),
            const SizedBox(height: 20,),
            Visibility(
              visible: isPrimaryButtons!,
              child: DottedLine(
                color: greyColor,),
            ),
            const SizedBox(height: 20,),
            Visibility(
              visible: isPrimaryButtons!,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubmitButton(
                      width: 35.w,
                      height: 40,
                      title: leftButtonText,
                      textColor: themeColor,
                      bgColor: bgColor,
                      bdRadius: 6,
                      press: leftButtonTap
                  ),
                  SubmitButton(
                      width: 35.w,
                      height: 40,
                      title: rightButtonText,
                      bdRadius: 6,
                      press: rightButtonTap
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}