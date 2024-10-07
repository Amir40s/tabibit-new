import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';

import '../../../../model/res/widgets/text_widget.dart';

class DoctorAppointmentButton extends StatelessWidget {
  const DoctorAppointmentButton({
    super.key,
    required this.title,
    required this.icon,
    required this.buttonColor,
    this.onTap,
  });

  final String title;
  final String icon;
  final Color buttonColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? (){},
      child: Container(
        width: 100.w,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 10,),
            TextWidget(
                text: title, fontSize: 18.sp,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: bgColor)
          ],
        ),
      ),
    );
  }
}
