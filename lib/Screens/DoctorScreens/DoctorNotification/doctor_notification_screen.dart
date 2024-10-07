import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Notifications"),
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
                  StreamBuilder<List<NotificationModel>>(
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

                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: nots.length,
                        itemBuilder: (context, index) {
                          final not = nots[index];
                          return DoctorNotificationTile(
                              title: not.title,
                              subTitle: not.subTitle,
                              timeText: "10 min ago",
                              icon: AppIcons.upcomingEventIcon,
                              iconBgColor: Color(0xffFFECCC));
                          },);
                    },
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

//SizedBox(height: height,),
//                   const DoctorNotificationTile(
//                       title: "Upcoming Event",
//                       subTitle: "Tabibinet is organizing an event for all medicine practitioners",
//                       timeText: "10 min ago",
//                       icon: AppIcons.upcomingEventIcon,
//                       iconBgColor: Color(0xffFFECCC)
//                   ),
//                   SizedBox(height: height,),
//                   const DoctorNotificationTile(
//                       title: "Upcoming Appointment",
//                       subTitle: "You have a patient to attend in half an hour",
//                       timeText: "10 min ago",
//                       icon: AppIcons.upcomingAppointmentIcon,
//                       iconBgColor: Color(0xffF3EAFF)
//                   ),
//                   SizedBox(height: height,),
//                   const DoctorNotificationTile(
//                       title: "New Message",
//                       subTitle: "You have a unread message from Mike Brown",
//                       timeText: "1hr ago",
//                       icon: AppIcons.newMessageIcon,
//                       iconBgColor: Color(0xffE2F8E3)
//                   ),
//                   SizedBox(height: height,),
//                   const DoctorNotificationTile(
//                       title: "Add your availability",
//                       subTitle: "It seems like you have not added your availability yet.",
//                       timeText: "5hrs ago",
//                       icon: AppIcons.availabilityIcon,
//                       iconBgColor: Color(0xffE1F3FF)
//                   ),




//const Spacer(),
//                       const TextWidget(
//                         text: "Short By :", fontSize: 12,
//                         fontWeight: FontWeight.w400, isTextCenter: false,
//                         textColor: textColor, fontFamily: AppFonts.regular,),
//                       const SizedBox(width: 10,),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8),
//                         decoration: BoxDecoration(
//                             color: bgColor,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(
//                                 color: greyColor
//                             )
//                         ),
//                         child: DropdownButton<String>(
//                           dropdownColor: bgColor,
//                           icon: const Icon(CupertinoIcons.chevron_down,size: 15,),
//                           borderRadius: BorderRadius.circular(8),
//                           underline: const SizedBox(),
//                           hint: const TextWidget(
//                             text: "All", fontSize: 12,
//                             fontWeight: FontWeight.w400, isTextCenter: false,
//                             textColor: textColor,fontFamily: AppFonts.regular,),
//                           style: const TextStyle(
//                               fontSize: 12,
//                               fontFamily: AppFonts.regular,
//                               fontWeight: FontWeight.w400,
//                               color: textColor
//                           ),
//                           value: _selectedItem,
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               _selectedItem = newValue!;
//                             });
//                           },
//                           items: _dropdownItems.map((String item) {
//                             return DropdownMenuItem<String>(
//                               value: item,
//                               child: Text(item),
//                             );
//                           }).toList(),
//                         ),
//                       )