import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../constant.dart';
import '../constant/app_fonts.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  final String title;
  final String icon;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minTileHeight: 70,
      title: TextWidget(
        text: title, fontSize: 18,
        fontWeight: FontWeight.w600, isTextCenter: false,
        textColor: textColor, fontFamily: AppFonts.semiBold,),
      leading: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle
        ),
        child: SvgPicture.asset(icon,colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),),
      ),
      trailing: const Icon(CupertinoIcons.forward,color: textColor,),
    );
  }
}
