import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../constant.dart';
import '../constant/app_assets.dart';
import '../constant/app_fonts.dart';
import 'text_widget.dart';

class NoFoundCard extends StatelessWidget {
  const NoFoundCard({
    super.key,
    this.subTitle
  });

  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        SizedBox(height: 5.h,),
        SvgPicture.asset(AppAssets.noFoundImage),
        SizedBox(height: 5.h,),
        const TextWidget(
            text: "No Found", fontFamily: AppFonts.semiBold,
            fontSize: 14, fontWeight: FontWeight.w600,
            isTextCenter: false, textColor: textColor),
        SizedBox(height: .5.h,),
        TextWidget(
            text: subTitle ?? "You can now make multiple doctoral appointments at once",
            maxLines: 2,
            fontSize: 12, fontWeight: FontWeight.w500,
            isTextCenter: true, textColor: textColor),
      ],
    ));
  }
}
