import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constant.dart';
import '../../../../../model/res/constant/app_fonts.dart';
import '../../../../../model/res/widgets/submit_button.dart';
import '../../../../../model/res/widgets/text_widget.dart';
import '../../../../model/res/constant/app_icons.dart';

class FeeContainer extends StatelessWidget {
  const FeeContainer({
    super.key,
    required this.title,
    required this.subTitle,
    this.borderColor,
    this.fees,
    this.icon,
    this.onTap,
  });

  final String title;
  final String subTitle;
  final Color? borderColor;
  final String? fees;
  final String? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor ?? themeColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(icon ?? AppIcons.radioOnIcon,height: 17.sp,),
            const SizedBox(width: 20,),
            SizedBox(
              width: 40.w,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: title, fontSize: 16,
                    fontWeight: FontWeight.w500, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.medium,),
                  TextWidget(
                    text: subTitle, fontSize: 12,
                    fontWeight: FontWeight.w400, isTextCenter: false,
                    textColor: textColor,maxLines: 2,),
                ],
              ),
            ),
            const SizedBox(width: 20,),
            SubmitButton(
              title: "$fees MAD" ?? "120 MAD",
              bgColor: secondaryGreenColor,
              height: 50,
              width: 25.w,
              bdColor: secondaryGreenColor,
              textColor: themeColor,
              textSize: 16.sp,
              press: () {

              },)
          ],
        ),
      ),
    );
  }
}
