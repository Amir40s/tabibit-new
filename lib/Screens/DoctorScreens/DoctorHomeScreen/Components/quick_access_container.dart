import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../constant.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/widgets/text_widget.dart';

class QuickAccessContainer extends StatelessWidget {
  const QuickAccessContainer({
    super.key,
    required this.text,
    required this.boxColor,
    required this.icon,
    required this.onTap
  });

  final Color boxColor;
  final String text;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: boxColor,
                shape: BoxShape.circle
            ),
            child: SvgPicture.asset(icon,height: 5.h,),
          ),
          const SizedBox(height: 10,),
          TextWidget(
            text: text, fontSize: 12,
            fontWeight: FontWeight.w600, isTextCenter: true, maxLines: 2,
            textColor: textColor,fontFamily: AppFonts.semiBold,),
        ],
      ),
    );
  }
}
