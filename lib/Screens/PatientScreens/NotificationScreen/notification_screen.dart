import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/Language/new/translation_new_provider.dart';
import 'package:tabibinet_project/Providers/PatientNotification/patient_notification_provider.dart';
import 'package:tabibinet_project/model/data/notification_model.dart';

import '../../../constant.dart';
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(text: "Notification"),
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

                  Consumer<TranslationNewProvider>(
                    builder: (context,provider,child){
                      return StreamBuilder<List<NotificationModel>>(
                          stream: notificationP.fetchNotifications(), // Assume this is the stream of specialties
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(child: Text('No Notification found'));
                            }

                            final specs = snapshot.data!;

                            // Translate the specialties only once when available
                            if (provider.notificationTranslationList.isEmpty) {
                              provider.translateNotification(
                                specs.map((e) => e.title).toList() +
                                    specs.map((e) => e.subtitle).toList(),
                              );
                            }

                            return  ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: specs.length,
                              itemBuilder: (context, index) {
                                final doc = specs[index];
                                final title = provider.notificationTranslationList[doc.title] ?? doc.title;
                                final subtitle = provider.notificationTranslationList[doc.subtitle] ?? doc.subtitle;

                                return NotificationContainer(
                                    onTap: () {

                                    },
                                    title: title,
                                    subTitle: subtitle,
                                    image: doc.title.contains("New Appointment")
                                    ?  AppIcons.calenderIcon  :  AppIcons.bellIcon,
                                    iconColor: themeColor,
                                    boxColor: secondaryGreenColor,
                                    isButton: doc.read == false,
                                    time: doc.date,
                                );
                              },
                            );
                          });
                    },
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
