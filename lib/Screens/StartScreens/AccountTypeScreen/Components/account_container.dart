import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../constant.dart';
import '../../../../model/res/widgets/text_widget.dart';

class AccountContainer extends StatelessWidget {
  const AccountContainer({
    super.key,
    required this.title,
    required this.image,
    required this.isIcon,
    required this.cardColor,
    required this.textColor,
    required this.width,
    required this.onTap,

  });

  final String image;
  final String title;
  final Color cardColor;
  final Color textColor;
  final bool isIcon;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        // height: 25.h,
        width: 43.w,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: greyColor)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 20.h,
              width: 43.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(image),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isIcon? Container(
                  padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: bgColor,
                      shape: BoxShape.circle
                    ),
                    child: const Icon(Icons.done,size: 20,color: themeColor,))
                    : const SizedBox(),
                const SizedBox(width: 10,),
                SizedBox(
                  width: width,
                  child: TextWidget(
                      text: title, fontSize: 16,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: textColor,fontFamily: "Medium",),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
