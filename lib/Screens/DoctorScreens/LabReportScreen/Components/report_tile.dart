import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../constant.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/widgets/text_widget.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.trailText,
    required this.trailColor,
  });

  final String title;
  final String subTitle;
  final String trailText;
  final Color trailColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: TextWidget(
        text: title, fontSize: 18.sp,
        fontWeight: FontWeight.w600, isTextCenter: false,
        textColor: textColor, fontFamily: AppFonts.semiBold,),
      subtitle: TextWidget(
        text: subTitle, fontSize: 14.sp,
        fontWeight: FontWeight.w500, isTextCenter: false,
        textColor: textColor, fontFamily: AppFonts.regular,),
      trailing: TextWidget(
        text: trailText, fontSize: 18.sp,
        fontWeight: FontWeight.w600, isTextCenter: false,
        textColor: trailColor, fontFamily: AppFonts.regular,),
    );
  }
}
