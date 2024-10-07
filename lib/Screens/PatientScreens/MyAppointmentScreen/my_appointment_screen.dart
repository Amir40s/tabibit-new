import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/Screens/PatientScreens/CancelAppointment/cancel_appointment_screen.dart';
import 'package:tabibinet_project/Screens/PatientScreens/CompletedAppointment/completed_appointment_screen.dart';
import 'package:tabibinet_project/Screens/PatientScreens/PendingAppointment/pending_appointment_screen.dart';
import 'package:tabibinet_project/Screens/PatientScreens/UpComingAppointment/upcoming_appointment_screen.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';

import '../../../Providers/MyAppointment/my_appointment_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/input_field.dart';

class MyAppointmentScreen extends StatelessWidget {
  MyAppointmentScreen({super.key});

  final searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final myAppP = Provider.of<MyAppointmentProvider>(context,listen: false);
    final languageP = Provider.of<TranslationProvider>(context);



    return SafeArea(
      child: DefaultTabController(
        length: 4, // Number of tabs
        child: Scaffold(
          backgroundColor: bgColor,
          body: Column(
            children: [
              const Header(text: "My Appointments"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 72.w,
                        height: 50,
                        child: InputField2(
                          inputController: searchC,
                          hintText: languageP.translatedTexts["Find here!"] ?? "Find here!",
                          prefixIcon: Icons.search,
                          onChanged: (value) {
                            myAppP.filterAppointment(value);
                          },
                        )),
                    Container(
                      padding: const EdgeInsets.all(15),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: SvgPicture.asset(AppIcons.menuIcon),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
               TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.semiBold
                ),
                // onTap: (value) {
                //   if(value == 0){
                //     myAppP.setAppointmentStatus("pending");
                //   }
                //   else if(value == 1){
                //     myAppP.setAppointmentStatus("upcoming");
                //   }
                //   else if(value == 2){
                //     myAppP.setAppointmentStatus("complete");
                //   }else{
                //     myAppP.setAppointmentStatus("cancel");
                //   }
                // },
                tabs: [
                  Tab(text: languageP.translatedTexts["Pending"] ?? "Pending",),
                  Tab(text: languageP.translatedTexts["Upcoming"] ?? "Upcoming",),
                  Tab(text: languageP.translatedTexts["Completed"] ?? "Completed",),
                  Tab(text: languageP.translatedTexts["canceled"] ?? "canceled",),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    PendingAppointmentScreen(),
                    UpComingAppointment(),
                    CompletedAppointmentScreen(),
                    CancelAppointmentScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



