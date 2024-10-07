import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/AppointmentReminderScreen/appointment_reminder_screen.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/PatientsLabReportScreen/patient_lab_report_screen.dart';
import 'package:tabibinet_project/Screens/PatientScreens/PatientMessageScreen/patient_message_screen.dart';
import 'package:tabibinet_project/constant.dart';

import '../../../Providers/BottomNav/bottom_navbar_provider.dart';
import '../../../model/res/widgets/bottom_nav_bar.dart';
import '../DoctorAppointmentSchedule/doctor_appointment_schedule_screen.dart';
import '../DoctorHomeScreen/doctor_home_screen.dart';
import '../PatientManagementData/patient_management_data_screen.dart';
import '../PatientManagementScreen/patient_management_screen.dart';

class DoctorBottomNavbar extends StatelessWidget {
  const DoctorBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    // final bottomP = Provider.of<BottomNavBarProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Consumer<BottomNavBarProvider>(
          builder: (context, value, child) {
            return IndexedStack(
              index: value.currentIndex,
              children: [
                DoctorHomeScreen(),
                DoctorAppointmentSchedule(),
                PatientManagementDataScreen(),
                //const PatientManagementScreen(),
                const ChatListScreen()
              ],
            );
          },),
        bottomNavigationBar: const CustomBottomNavBar2(),
      ),
    );
  }
}
