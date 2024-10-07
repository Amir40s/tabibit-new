import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant.dart';
import '../constant/app_fonts.dart';
import 'curved_top_painter.dart';
import 'dotted_line.dart';
import 'submit_button.dart';
import 'text_widget.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.subTitle,
    required this.primaryButText,
    required this.secondaryButText,
    required this.primaryButTap,
  });

  final double height;
  final double width;
  final String title;
  final String subTitle;
  final String primaryButText;
  final String secondaryButText;
  final VoidCallback primaryButTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CustomPaint(
          size: Size(width, height),
          painter: CurvedTopPainter(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              TextWidget(
                text: title, fontSize: 24,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: redColor, fontFamily: AppFonts.medium,
              ),
              const SizedBox(
                height: 30,
              ),
              const DottedLine(
                color: greyColor,
              ),
              const SizedBox(
                height: 30,
              ),
              TextWidget(
                text: subTitle, fontSize: 16,
                fontWeight: FontWeight.w400, isTextCenter: true,
                textColor: textColor, maxLines: 2,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubmitButton(
                    width: 38.w,
                    height: 50,
                    title: secondaryButText,
                    textColor: themeColor,
                    bgColor: secondaryGreenColor,
                    bdRadius: 6,
                    press: () {
                      Get.back();
                    },
                  ),
                  SubmitButton(
                    width: 38.w,
                    height: 50,
                    title: primaryButText,
                    bdRadius: 6,
                    press: primaryButTap,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
