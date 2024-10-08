import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/AppointmentReminderScreen/appointment_reminder_screen.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/ConsultationScreen/consultation_screen.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/DoctorHomeScreen/Components/quick_access_container.dart';
import 'package:tabibinet_project/chart_screen.dart';

import '../../../../call_screen.dart';
import '../../../../constant.dart';
import '../../../../model/res/constant/app_icons.dart';

class QuickAccessSection extends StatelessWidget {
  const QuickAccessSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        QuickAccessContainer(
          onTap: (){
            Get.to(()=> AppointmentReminderScreen());
          },
          text: 'Appointment\nReminders',
          boxColor: purpleColor,
          icon: AppIcons.docIcon,
        ),
        SizedBox(width: 15.w,),
        QuickAccessContainer(
          onTap: (){
           Get.to(()=>CallScreen());
            // Get.to(()=>ConsultationScreen());
          },
          text: 'Appointments Call',
          boxColor: lightRedColor,
          icon: AppIcons.phone,
        ),


        // QuickAccessContainer(
        //   onTap: (){
        //
        //   },
        //   text: 'DocShare',
        //   boxColor: themeColor,
        //   icon: AppIcons.docShareIcon,
        // ),
      ],
    );
  }
}