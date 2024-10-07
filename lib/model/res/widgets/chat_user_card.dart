import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/image_loader.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

class ChatUserCard extends StatelessWidget {
  const ChatUserCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.trailingText,
  });

  final String title;
  final String subTitle;
  final String trailingText;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: greyColor,
            shape: BoxShape.circle,
          ),
          child: const ImageLoaderWidget(
              imageUrl: "https://images.pexels.com/photos/12645893/pexels-photo-12645893"
                  ".jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
        ),
      ),
      title: TextWidget(
        text: title, fontSize: 16.sp,
        fontWeight: FontWeight.w600, isTextCenter: false,
        textColor: textColor, fontFamily: AppFonts.semiBold,),
      subtitle: TextWidget(
        text: subTitle, fontSize: 13.sp,
        fontWeight: FontWeight.w400, isTextCenter: false,
        textColor: Colors.grey, fontFamily: AppFonts.medium,),
      trailing: TextWidget(
        text: trailingText, fontSize: 13.sp,
        fontWeight: FontWeight.normal, isTextCenter: false,
        textColor: Colors.grey, fontFamily: AppFonts.medium,),
    );
  }
}
