import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../FindDoctorScreen/Components/suggestion_container.dart';

class PatientMedicationScreen extends StatelessWidget {
  PatientMedicationScreen({
    super.key,
    required this.doctorName,
    required this.medicineName,
    required this.dose,
    required this.duration,
    required this.repeat,
    required this.timeOfDay,
    required this.taken,
  });

  final String doctorName;
  final String medicineName;
  final String dose;
  final String duration;
  final List<String> repeat;
  final List<String> timeOfDay;
  final List<String> taken;

  final timeC = TextEditingController();


  @override
  Widget build(BuildContext context) {

    double height1 = 20;
    double height2 = 10;

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Prescription"),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  SizedBox(height: height1,),
                  Center(
                      child: SvgPicture.asset(AppIcons.notificationIcon)
                  ),
                  SizedBox(height: height1,),
                  TextWidget(
                    text: "You have received the prescription From DR $doctorName",
                    fontSize: 20,
                    fontWeight: FontWeight.w600, isTextCenter: true, maxLines: 3,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  const SizedBox(height: 40,),
                  const TextWidget(
                    text: "Prescription Information", fontSize: 20,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "Medicine Name", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  Container(
                    width: 100.w,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: themeColor
                        )
                    ),
                    child: TextWidget(
                      text: medicineName, fontSize: 16,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                  ),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "Dose", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  Container(
                    width: 100.w,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: themeColor
                        )
                    ),
                    child: TextWidget(
                      text: dose, fontSize: 16,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                  ),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "Duration", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  Container(
                    width: 100.w,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: themeColor
                        )
                    ),
                    child: TextWidget(
                      text: duration, fontSize: 16,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                  ),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "Repeat", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  SizedBox(
                      height: 40,
                      width: 100.w,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: repeat.length,
                        itemBuilder: (context, index) {
                          // final item = repeat[index];
                          return SuggestionContainer(
                              text: repeat[index],
                              boxColor: themeColor,
                              textColor: bgColor
                          );
                        },)
                  ),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "Time of Day", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  SizedBox(
                      height: 40,
                      width: 100.w,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: timeOfDay.length,
                        itemBuilder: (context, index) {
                          // final item = repeat[index];
                          return SuggestionContainer(
                              text: timeOfDay[index],
                              boxColor: themeColor,
                              textColor: bgColor
                          );
                        },)
                  ),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "To be taken", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  SizedBox(
                      height: 40,
                      width: 100.w,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: taken.length,
                        itemBuilder: (context, index) {
                          // final item = repeat[index];
                          return SuggestionContainer(
                              text: taken[index],
                              boxColor: themeColor,
                              textColor: bgColor
                          );
                        },)
                  ),
                  SizedBox(height: height1,),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SubmitButton(
            title: "Continue",
            press: () {
              // Get.to(()=> const AppointmentVoiceCallScreen());
            },),
        ),
      ),
    );
  }
}
