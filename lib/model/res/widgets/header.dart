import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/PatientScreens/PatientMessageScreen/patient_message_screen.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../Providers/TwilioProvider/twilio_provider.dart';
import '../../../constant.dart';
import '../constant/app_fonts.dart';
import 'image_loader.dart';


class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.text,
    this.iconColor,
    this.boxColor,
    this.isPadding = true,
  });

  final String text;
  final Color? iconColor;
  final Color? boxColor;
  final bool isPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: isPadding ? 20.0 : 0.0,vertical: isPadding ? 10 : 0),
      child: SizedBox(
        height: 8.h,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
                // Get.to(ChatListScreen());
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: boxColor ?? themeColor,
                    shape: BoxShape.circle
                ),
                child: Center(child: Icon(CupertinoIcons.back,color: iconColor ?? bgColor,size: 24,)),
              ),
            ),
            const SizedBox(width: 15,),
            Expanded(
              child: SizedBox(
                child: TextWidget(
                  text: text, fontSize: 19.sp,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor,fontFamily: AppFonts.semiBold,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header2 extends StatelessWidget {
  const Header2({super.key,required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
      child: SizedBox(
        height: 8.h,
        child: Row(
          children: [
            const SizedBox(width: 15,),
            TextWidget(
              text: text, fontSize: 19.sp,
              fontWeight: FontWeight.w600, isTextCenter: false,
              textColor: textColor,fontFamily: AppFonts.semiBold,),
          ],
        ),
      ),
    );
  }
}

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key, required this.name, required this.picture});
  final String name,picture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
      child: SizedBox(
        height: 72,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                    color: bgColor,
                    shape: BoxShape.circle
                ),
                child: const Center(child: Icon(CupertinoIcons.back,color: themeColor,size: 24,)),
              ),
            ),
            const SizedBox(width: 10,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                      color: skyBlueColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ImageLoaderWidget(imageUrl:
                  picture.isNotEmpty
                      ? picture
                      : "https://res.cloudinary.com/dz0mfu819/image/upload/v1725947218/profile_xfxlfl.pngs"
                  )
                // value.image != null ? Image.file(value.image!, fit: BoxFit.cover,)
                //     : const SizedBox(),
              ),
            ),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40.w,
                  child:  TextWidget(
                      text: name, fontSize: 20,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: bgColor),
                ),
                const TextWidget(
                    text: "", fontSize: 12,
                    fontWeight: FontWeight.w400, isTextCenter: false,
                    textColor: bgColor),

              ],
            ),
          ],
        ),
      ),
    );
  }
}