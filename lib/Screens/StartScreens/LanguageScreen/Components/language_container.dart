import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../../../constant.dart';
import '../../../../model/res/widgets/text_widget.dart';

class LanguageContainer extends StatelessWidget {
  const LanguageContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.boxColor,
    required this.textColor,
    required this.boundaryColor,
    required this.borderColor,
  });

  final Color boxColor;
  final Color textColor;
  final Color borderColor;
  final Color boundaryColor;
  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: boundaryColor
        ),
        color: boxColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(14),
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: bgColor,
              border: Border.all(
                color: borderColor
              )
            ),
            child: Center(child: SvgPicture.asset(image,fit: BoxFit.cover,)),
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                  text: title, fontSize: 24,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor),
              TextWidget(
                  text: subTitle, fontSize: 12,
                  fontWeight: FontWeight.w400, isTextCenter: false,
                  textColor: textColor),
            ],
          )
        ],
      ),
    );
  }
}
