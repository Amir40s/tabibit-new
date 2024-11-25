import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/PatientNotification/patient_notification_provider.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/api_services/url/baseurl.dart';
import 'package:tabibinet_project/model/puahNotification/push_notification.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/dotted_line.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

class NotificationSettingScreen extends StatelessWidget {
  const NotificationSettingScreen({super.key});

  static const double _height1 = 20.0;
  static const double _height2 = 10.0;

  Future<void> _onNotificationToggle(bool value, PatientNotificationProvider provider) async {
    // final pref = await SharedPreferencesService.getInstance();
    // await pref.setBool("notification", value);
    // provider.setSound(value);
    final servies = FCMService();
    servies.toggleMuteStatus();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PatientNotificationProvider>(context,listen: false);
    provider.fetchSound();
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Notification"),
            const SizedBox(height: _height1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: secondaryGreenColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: themeColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        log("Click");
                        final services = FCMService();
                        services.sendNotification(
                            BaseUrl.testing_device_token,
                            "Your Appointment has been updated",
                            "body",
                            "senderId"
                        );
                      },
                      child: const TextWidget(
                        text: "Manage Notification",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        isTextCenter: false,
                        textColor: themeColor,
                        fontFamily: AppFonts.semiBold,
                      ),
                    ),
                    const SizedBox(height: _height1),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const TextWidget(
                        text: "Notification",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        isTextCenter: false,
                        textColor: textColor,
                        fontFamily: AppFonts.medium,
                      ),
                      trailing: Consumer<PatientNotificationProvider>(
                        builder: (context, provider, child) {
                          return CupertinoSwitch(
                            value: provider.isSound == true ? false : true,
                            activeColor: themeColor,
                            onChanged: (value) async{
                             await _onNotificationToggle(value, provider);
                              provider.fetchSound();
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: _height2),
                    const DottedLine(color: greyColor),
                    const SizedBox(height: _height2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
