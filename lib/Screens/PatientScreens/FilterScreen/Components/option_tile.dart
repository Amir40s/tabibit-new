import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constant.dart';
import '../../../../../model/res/constant/app_fonts.dart';
import '../../../../../model/res/widgets/text_widget.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  final String title;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minTileHeight: 60,
      title: TextWidget(
        text: title, fontSize: 16,
        fontWeight: FontWeight.w500, isTextCenter: false,
        textColor: textColor,fontFamily: AppFonts.medium,),
      trailing: SvgPicture.asset(image),
    );
  }
}
