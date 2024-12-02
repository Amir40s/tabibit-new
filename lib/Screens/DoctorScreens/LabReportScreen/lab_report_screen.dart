import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/Language/new/translation_new_provider.dart';
import 'package:tabibinet_project/Providers/stream/stream_data_provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/LabReportScreen/Components/lap_report_list_widget.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/data/report_model.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/info_tile.dart';
import '../../../model/res/widgets/no_found_card.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../ChooseReportFileScreen/choose_report_file_screen.dart';
import '../UploadReportFile/upload_report_file_screen.dart';
import 'Components/color_indicator.dart';
import 'Components/report_tile.dart';

class LabReportScreen extends StatelessWidget {
  const LabReportScreen({
    super.key,
    required this.date,
    required this.appointmentId,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.patientId,
    required this.deviceToken,
    required this.doctorName,
  });

  final String date;
  final String appointmentId;
  final String patientName;
  final String patientAge;
  final String patientGender;
  final String patientId;
  final String deviceToken;
  final String doctorName;




  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    final languageP = Provider.of<TranslationNewProvider>(context);
    final provider = Provider.of<TranslationProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Lab Report"),
            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: "Personal Details", fontSize: 18.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: textColor, fontFamily: AppFonts.semiBold,),
                        TextWidget(
                          text: "${provider.translatedTexts["Date"] ?? "Date"}: ${languageP.appointmentList[date] ?? date}", fontSize: 16.sp,
                          fontWeight: FontWeight.w500, isTextCenter: false,
                          textColor: textColor, fontFamily: AppFonts.medium,),
                      ],
                    ),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Full Name", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    InfoTile(title: languageP.appointmentList[patientName] ?? patientName),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Age", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    InfoTile(title: patientAge),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Gender", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                    InfoTile(title: patientGender),
                    SizedBox(height: height1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: "Recent Tests", fontSize: 18.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: textColor, fontFamily: AppFonts.semiBold,),
                        TextWidget(
                          text: "", fontSize: 18.sp,
                          fontWeight: FontWeight.w500, isTextCenter: false,
                          textColor: themeColor, fontFamily: AppFonts.medium,),
                      ],
                    ),
                    SizedBox(height: height1,),
                    LapReportListWidget(appointmentId: appointmentId),
                    SizedBox(height: height1,),
                  ],
            ))
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SubmitButton(
            title: "${provider.translatedTexts["Send Document to"] ?? "Send Document to"} ${languageP.appointmentList[patientName] ?? patientName}",
            press: () {
              Get.to(()=>UploadReportFileScreen(
                appointmentId: appointmentId,
                deviceToken: deviceToken,
                doctorName: doctorName,
                patientId: patientId,
                patientName: patientName
              ));
            },),
        ),
      ),
    );
  }





}