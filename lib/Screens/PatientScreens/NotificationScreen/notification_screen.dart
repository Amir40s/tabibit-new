import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/PatientNotification/patient_notification_provider.dart';
import 'package:tabibinet_project/controller/notification_controller.dart';
import 'package:tabibinet_project/model/data/notification_model.dart';

import '../../../constant.dart';
import '../../../controller/translation_controller.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/dotted_line.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/text_widget.dart';
import 'Components/notification_container.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    final notificationP = Provider.of<PatientNotificationProvider>(context, listen: false);
    final NotificationController notificationController = Get.put(NotificationController(notificationP));
    final TranslationController translationController = Get.put(TranslationController());


    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header2(text: "Notification"),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                 const Row(
                    children: [
                       TextWidget(
                        text: "Latest Update", fontSize: 20,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.semiBold,),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  const DottedLine(
                    height: 2,
                    color: greyColor,
                    dotLength: 4,
                    spacing: 4,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(height: 20,),

                  Obx((){
                    if (notificationController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (notificationController.notificationModel.isEmpty) {
                      return const Center(child: Text('No notification found'));
                    }

                    final specs = notificationController.notificationModel;

                    // Translate the specialties only once when available
                    if (translationController.notificationTranslationList.isEmpty) {
                      translationController.translateNotification(
                        specs.map((e) => e.title).toList() +
                            specs.map((e) => e.subTitle).toList(),
                      );
                    }

                    return  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: specs.length,
                      itemBuilder: (context, index) {
                        final doc = specs[index];
                        final title = translationController.notificationTranslationList[doc.title] ?? doc.title;
                        final subtitle = translationController.notificationTranslationList[doc.subTitle] ?? doc.subTitle;

                        return NotificationContainer(
                            onTap: () {

                            },
                            title: title,
                            subTitle: subtitle,
                            image: AppIcons.calenderIcon,
                            iconColor: themeColor,
                            boxColor: secondaryGreenColor,
                            isButton: doc.read == "false"
                        );
                      },
                    );
                  }),


                  // StreamBuilder<List<NotificationModel>>(
                  //     stream: notificationP.fetchNotifications(),
                  //     builder: (context, snapshot) {
                  //
                  //       if (snapshot.connectionState == ConnectionState.waiting) {
                  //         return const Center(child: CircularProgressIndicator());
                  //       }
                  //       if (snapshot.hasError) {
                  //         return Center(child: Text('Error: ${snapshot.error}'));
                  //       }
                  //       if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  //         return const Center(child: Text('No Notification found'));
                  //       }
                  //
                  //       // List of users
                  //       final nots = snapshot.data!;
                  //
                  //       return ListView.builder(
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         shrinkWrap: true,
                  //         itemCount: nots.length,
                  //         itemBuilder: (context, index) {
                  //           final not = nots[index];
                  //           return NotificationContainer(
                  //               onTap: () {
                  //
                  //               },
                  //               title: not.title,
                  //               subTitle: not.subTitle,
                  //               image: AppIcons.calenderIcon,
                  //               iconColor: themeColor,
                  //               boxColor: secondaryGreenColor,
                  //               isButton: not.read == "false"
                  //           );
                  //         },);
                  //       },
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//TextWidget(
//                     text: "Yesterday, April 19-2022", fontSize: 14,
//                     fontWeight: FontWeight.w600, isTextCenter: false,
//                     textColor: textColor.withOpacity(0.5), fontFamily: AppFonts.semiBold,),
//                   const SizedBox(height: 10,),
//NotificationContainer(
//                       onTap: () {
//
//                       },
//                       title: "Appointment Cancel!",
//                       subTitle: "Never miss a medical appointment with"
//                           " our reliable appointment alarm system!",
//                       image: AppIcons.cancelIcon,
//                       iconColor: themeColor,
//                       boxColor: secondaryGreenColor,
//                       isButton: false),
//                   NotificationContainer(
//                       onTap: () {
//
//                       },
//                       title: "Schedule Changed",
//                       subTitle: "Schedule Updated! Please check for "
//                           "changes in your appointments.",
//                       image: AppIcons.calenderIcon,
//                       iconColor: bgColor,
//                       boxColor: themeColor,
//                       isButton: false),
//                   TextWidget(
//                     text: "Yesterday, April 19-2022", fontSize: 14,
//                     fontWeight: FontWeight.w600, isTextCenter: false,
//                     textColor: textColor.withOpacity(0.5), fontFamily: AppFonts.semiBold,),
//                   const SizedBox(height: 10,),
//                   NotificationContainer(
//                       onTap: () {
//
//                       },
//                       title: "Appointment Cancel!",
//                       subTitle: "Never miss a medical appointment with"
//                           " our reliable appointment alarm system!",
//                       image: AppIcons.calenderIcon,
//                       iconColor: themeColor,
//                       boxColor: secondaryGreenColor,
//                       isButton: false),
//                   NotificationContainer(
//                       onTap: () {
//
//                       },
//                       title: "Schedule Changed",
//                       subTitle: "Schedule Updated! Please check for "
//                           "changes in your appointments.",
//                       image: AppIcons.bellIcon,
//                       iconColor: themeColor,
//                       boxColor: secondaryGreenColor,
//                       isButton: false),
//                   TextWidget(
//                     text: "February 22-2022", fontSize: 14,
//                     fontWeight: FontWeight.w600, isTextCenter: false,
//                     textColor: textColor.withOpacity(0.5), fontFamily: AppFonts.semiBold,),
//                   const SizedBox(height: 10,),
//                   NotificationContainer(
//                       onTap: () {
//
//                       },
//                       title: "Appointment Cancel!",
//                       subTitle: "Never miss a medical appointment with"
//                           " our reliable appointment alarm system!",
//                       image: AppIcons.calenderIcon,
//                       iconColor: themeColor,
//                       boxColor: secondaryGreenColor,
//                       isButton: false),
//                   NotificationContainer(
//                       onTap: () {
//
//                       },
//                       title: "Schedule Changed",
//                       subTitle: "Schedule Updated! Please check for "
//                           "changes in your appointments.",
//                       image: AppIcons.bellIcon,
//                       iconColor: themeColor,
//                       boxColor: secondaryGreenColor,
//                       isButton: false),