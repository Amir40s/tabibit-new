import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/Language/new/translation_new_provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';

import '../../../Providers/PatientNotification/patient_notification_provider.dart';
import '../../../constant.dart';
import '../../../model/data/notification_model.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/dotted_line.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../PatientScreens/NotificationScreen/Components/notification_container.dart';
import 'Components/doctor_notification_tile.dart';

class DoctorNotificationScreen extends StatelessWidget {
  DoctorNotificationScreen({super.key});

  String? _selectedItem;

  final List<String> _dropdownItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  @override
  Widget build(BuildContext context) {
    final notificationP = Provider.of<PatientNotificationProvider>(context, listen: false);
    double height = 20;
    final languageP = Provider.of<TranslationProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            Header(text: languageP.translatedTexts["Notification"] ?? "Notifications"),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Row(
                    children: [
                      TextWidget(
                        text: "Latest Update", fontSize: 20,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.semiBold,),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Consumer<TranslationNewProvider>(
                      builder: (context,provider,child){
                        return  StreamBuilder<List<NotificationModel>>(
                          stream: notificationP.fetchNotifications(),
                          builder: (context, snapshot) {

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(child: Text('No Notification found'));
                            }

                            // List of users
                            final nots = snapshot.data!;
                            // Translate the specialties only once when available
                            if (provider.notificationTranslationList.isEmpty) {
                              provider.translateNotification(
                                nots.map((e) => e.title).toList() +
                                    nots.map((e) => e.subTitle).toList(),
                              );
                            }


                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: nots.length,
                              itemBuilder: (context, index) {
                                final not = nots[index];
                                final title = provider.notificationTranslationList[not.title] ?? not.title;
                                final subtitle = provider.notificationTranslationList[not.subTitle] ?? not.subTitle;
                                return DoctorNotificationTile(
                                    title: title,
                                    subTitle: subtitle,
                                    timeText: "10 min ago",
                                    icon: AppIcons.upcomingEventIcon,
                                    iconBgColor: Color(0xffFFECCC));
                              },);
                          },
                        );
                      }

                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
