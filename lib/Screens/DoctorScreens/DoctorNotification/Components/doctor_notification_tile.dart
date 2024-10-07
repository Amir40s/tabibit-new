import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../constant.dart';
import '../../../../model/res/widgets/text_widget.dart';

class DoctorNotificationTile extends StatelessWidget {
  const DoctorNotificationTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.timeText,
    required this.icon,
    required this.iconBgColor,
  });

  final String title;
  final String subTitle;
  final String timeText;
  final String icon;
  final Color iconBgColor;

  @override
  Widget build(BuildContext context) {
    double height = 20.0;
    return SizedBox(
      width: 100.w,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle
                ),
                child: SvgPicture.asset(icon,height: 3.h,),
              ),
              SizedBox(width: height,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 70.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                            text: title, fontSize: 16.sp,
                            fontWeight: FontWeight.w500, isTextCenter: false,
                            textColor: textColor),
                        TextWidget(
                            text: timeText, fontSize: 14.sp,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: greyColor),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 70.w,
                    child: TextWidget(
                      text: subTitle,
                      fontSize: 14.sp, fontWeight: FontWeight.w400,
                      isTextCenter: false, textColor: textColor, maxLines: 1,),
                  ),

                ],
              )
            ],
          ),
          const SizedBox(height: 10,),
          const Divider(color: greyColor,),
        ],
      ),
    );
  }
}
