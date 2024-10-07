import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

import '../../../../constant.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.iconColor,
    required this.boxColor,
    required this.isButton,
    required this.onTap,
  });

  final String title;
  final String subTitle;
  final String image;
  final Color iconColor;
  final Color boxColor;
  final bool isButton;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? (){
        Get.back();
      },
      child: Container(
        padding: const EdgeInsets.all(15),
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
                  padding: const EdgeInsets.all(18),
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    color: boxColor,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(image,colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn) ,),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: title, fontSize: 16,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: 56.w,
                      child: TextWidget(
                        text: subTitle, fontSize: 12.sp,
                        fontWeight: FontWeight.w400, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.regular,maxLines: 4,),
                    ),
                    SizedBox(height: isButton ? 15 : 0,),
                    // isButton? SubmitButton(
                    //     width: 30.w,
                    //     height: 40,
                    //     title: "New",
                    //     icon: Icons.arrow_forward_rounded,
                    //     press: (){}
                    // ): SizedBox(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
