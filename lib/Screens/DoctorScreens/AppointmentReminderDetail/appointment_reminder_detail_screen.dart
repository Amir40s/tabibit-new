import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/ReminderScreen/reminder_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../Providers/TwilioProvider/twilio_provider.dart';
import '../../../model/res/constant/app_utils.dart';
import '../../../model/res/widgets/info_tile.dart';
import '../../../model/res/widgets/toast_msg.dart';

class AppointmentReminderDetailScreen extends StatelessWidget {
  AppointmentReminderDetailScreen({
    super.key,
    required this.email,
    required this.name,
    required this.age,
    required this.phone,
    required this.gender,
    required this.time,
    required this.location,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  final appUtils = AppUtils();

  final String name,age,gender,time,location,email,phone,appointmentDate,appointmentTime;

  @override
  Widget build(BuildContext context) {
    final twilioProvider = Provider.of<TwilioProvider>(context,listen: false);
    double height1 = 20;
    double height2 = 10;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Appointments Reminders"),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: "Patient Details", fontSize: 18.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: textColor, fontFamily: AppFonts.semiBold,),
                        // Container(
                        //   padding: const EdgeInsets.all(8),
                        //   decoration: BoxDecoration(
                        //     color: themeColor.withOpacity(0.1),
                        //     borderRadius: BorderRadius.circular(8)
                        //   ),
                        //   child: SvgPicture.asset(AppIcons.editIcon),
                        // )
                      ],
                    ),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Full Name", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    InfoTile(title: name.toString()),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Age", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    InfoTile(title: age.toString()),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Gender", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    InfoTile(title: gender.toString()),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Time of Appointment", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    InfoTile(title: time.toString(),),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Appointment Location", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    InfoTile(title: location.toString()  ),
                    const SizedBox(height: 30,),
                    SubmitButton(
                      title: "Send Reminder",
                      bgColor: const Color(0xff04AD01).withOpacity(0.1),
                      textColor: const Color(0xff04AD01),
                      bdColor: const Color(0xff04AD01),
                      press: () {
                        twilioProvider.sendSmsReminder(
                            phone,
                            "Reminder: You have an appointment scheduled on $appointmentDate, at $appointmentTime"
                        );
                        // appUtils.sendReminder(
                        //     recipientEmail: email,
                        //     messageText: "Hello, Your Time of Appointment"
                        //         " is mentions please be on time "
                        //         "for doctor appointment",
                        //     context: context);

                        // Get.to(()=> ReminderScreen(
                        //   appBarText: "Send Reminder",
                        //   email: email,
                        //   age: age,
                        //   gender: gender,
                        //   name: name,
                        //   time: time,
                        //   location: location,
                        // ));
                      },),
                    SizedBox(height: height1,),
                    SubmitButton(
                      title: "Cancel Appointment",
                      bgColor: const Color(0xffF23A00).withOpacity(0.1),
                      textColor: const Color(0xffF23A00),
                      bdColor: const Color(0xffF23A00),
                      press: () async{
                        await fireStore.collection("appointmentReminder")
                            .doc(time)
                            .update({
                          "status": "cancel",
                        });

                        ToastMsg().toastMsg("Appointment Cancel successfully");
                      },),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
