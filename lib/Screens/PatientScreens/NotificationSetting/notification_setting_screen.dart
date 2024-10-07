import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/PatientNotification/patient_notification_provider.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/dotted_line.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';
import 'package:tabibinet_project/model/services/SharedPreference/shared_preference.dart';

class NotificationSettingScreen extends StatelessWidget {
  const NotificationSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height1 = 20;
    double height2 = 10;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Notification"),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: secondaryGreenColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: themeColor)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: "Manage Notification", fontSize: 16,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: themeColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height1,),
                  ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const TextWidget(
                      text: "Notification", fontSize: 16,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.medium,),
                    trailing: Consumer<PatientNotificationProvider>(
                      builder: (context, provider, child) {
                      return CupertinoSwitch(
                        value: provider.isSound,
                        activeColor: themeColor,
                        onChanged: (value) async{
                          final pref  = await SharedPreferencesService.getInstance();
                          pref.setBool("notification", value);
                          provider.setSound(value);
                        },);
                    },),
                  ),
                  SizedBox(height: height2,),
                  const DottedLine(color: greyColor,),
                  SizedBox(height: height2,),
                  // ListTile(
                  //   contentPadding: const EdgeInsets.all(0),
                  //   title: const TextWidget(
                  //     text: "Vibrate", fontSize: 16,
                  //     fontWeight: FontWeight.w500, isTextCenter: false,
                  //     textColor: textColor, fontFamily: AppFonts.medium,),
                  //   trailing: Consumer<PatientNotificationProvider>(
                  //     builder: (context, provider, child) {
                  //       return CupertinoSwitch(
                  //         value: provider.isVibrate,
                  //         activeColor: themeColor,
                  //         onChanged: (value) {
                  //           provider.setVibration(value);
                  //         },);
                  //     },),
                  // ),
                  // SizedBox(height: height2,),
                  // const DottedLine(color: greyColor,),
                  // SizedBox(height: height1,),
                  // const DottedLine(color: greyColor,),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
