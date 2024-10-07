import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/input_field.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../Providers/MyAppointment/my_appointment_provider.dart';
import '../CancelScreen/cancel_successful_screen.dart';
import 'Components/cancel_reason_section.dart';

class CancelAppointmentReasonScreen extends StatelessWidget {
  CancelAppointmentReasonScreen({
    super.key,
    required this.appointmentId
  });

  final String appointmentId;

  final List<String> reasons = [
    "I want to change to another doctor",
    "I want to change package",
    "I don't want to consult",
    "I have recovered from the disease",
    "I have found a suitable medicine",
    "I just want to cancel",
    "I don't want to tell",
    "Others",
  ];

  final reasonC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final myAppointP = Provider.of<MyAppointmentProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Cancel Appointment"),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    TextWidget(
                      text: "Reason for Schedule Change", fontSize: 18.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    const SizedBox(height: 20,),
                    CancelReasonSection(),
                    const SizedBox(height: 20,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: "Type the reason", fontSize: 16,
                          fontWeight: FontWeight.w500, isTextCenter: false,
                          textColor: textColor, fontFamily: AppFonts.medium,),
                        TextWidget(
                          text: "Max 250 words", fontSize: 12,
                          fontWeight: FontWeight.w400, isTextCenter: false,
                          textColor: textColor),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    InputField(
                      inputController: reasonC,
                      hintText: "Tell doctor about your problem",
                      maxLines: 5,
                    ),
                    const SizedBox(height: 20,),
                    SubmitButton(
                      title: "Submit",
                      press: () {
                        myAppointP.cancelAppointment(appointmentId);
                        Get.to(()=>const CancelSuccessfulScreen());
                    },),
                    const SizedBox(height: 20,),
                    
                  ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
