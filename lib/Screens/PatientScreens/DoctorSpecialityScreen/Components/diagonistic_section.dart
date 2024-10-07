import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constant.dart';
import '../../../../../model/res/constant/app_fonts.dart';
import '../../../../../model/res/widgets/text_widget.dart';
import '../../../../model/res/constant/app_icons.dart';

class DiagnosticSection extends StatelessWidget {
  const DiagnosticSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 160,
      child: GridView.builder(
        shrinkWrap:true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisExtent: 190,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: greyColor
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(13),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: greenColor)
                  ),
                  child: SvgPicture.asset(AppIcons.neurologistIcon),
                ),
                const SizedBox(height: 5,),
                const TextWidget(
                  text: "Cellular & chemical", fontSize: 12,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.semiBold,),
                const SizedBox(height: 5,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                        text: "140 doctors", fontSize: 12,
                        fontWeight: FontWeight.w400, isTextCenter: false,
                        textColor: textColor),
                    SizedBox(width: 5,),
                    Icon(Icons.arrow_forward_outlined,color: textColor,size: 14,)
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
