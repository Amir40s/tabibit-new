import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../constant.dart';
import '../constant/app_fonts.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.title
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: themeColor)
      ),
      child: TextWidget(
        text: title, fontSize: 16.sp,maxLines: 5,
        fontWeight: FontWeight.w600, isTextCenter: false,
        textColor: textColor, fontFamily: AppFonts.semiBold,),
    );
  }
}
