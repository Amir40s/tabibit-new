import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constant.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/widgets/text_widget.dart';

class DoctorSpecialityContainer extends StatelessWidget {
  const DoctorSpecialityContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.boxColor,
  });

  final String title;
  final String subTitle;
  final String icon;
  final Color boxColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: greenColor)
      ),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(13),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: BorderRadius.circular(8), 
                  border: Border.all(color: greenColor.withOpacity(0.3))
              ),
              child: SvgPicture.asset(icon)),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextWidget(
                text: title, fontSize: 12,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: textColor, fontFamily: AppFonts.semiBold,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextWidget(
                    text: subTitle, fontSize: 12,
                    fontWeight: FontWeight.w400, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.regular,),
                  const SizedBox(width: 5,),
                  const Visibility(
                      visible: false,
                      child: Icon(Icons.arrow_forward_outlined,color: textColor,size: 18,))
                ],
              ),
            ],
          ),
          const SizedBox(width: 30,),
        ],
      ),
    );
  }
}
