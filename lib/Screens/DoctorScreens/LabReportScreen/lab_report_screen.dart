import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
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
  });

  final String date;
  final String appointmentId;
  final String patientName;
  final String patientAge;
  final String patientGender;

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
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
                          text: "Date: $date", fontSize: 16.sp,
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
                    InfoTile(title: patientName),
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
                          text: "Result", fontSize: 18.sp,
                          fontWeight: FontWeight.w500, isTextCenter: false,
                          textColor: themeColor, fontFamily: AppFonts.medium,),
                      ],
                    ),
                    SizedBox(height: height1,),
                    StreamBuilder<List<ReportModel>>(
                      stream: fetchReport(),
                      builder: (context, snapshot) {

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const NoFoundCard(subTitle: "",);
                        }

                        final reps = snapshot.data!;

                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: reps.length,
                          itemBuilder: (context, index) {
                            final rep = reps[index];
                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: greyColor)
                              ),
                              child: Row(
                                children: [
                                  Image.asset(AppIcons.pdfIcon,height: 30,),
                                  SizedBox(width: 1.w,),
                                  TextWidget(
                                    text: "PDF File", fontSize: 14.sp,
                                    fontWeight: FontWeight.w600, isTextCenter: false,
                                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                                  const Spacer(),
                                  SubmitButton(
                                    title: "view",
                                    width: 18.w,
                                    radius: 6,
                                    height: 30,
                                    press: () {
                                      _launchURL(rep.fileUrl);
                                    },)
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 10,),
                        );
                      },),
                    SizedBox(height: height1,),
                  ],
            ))
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SubmitButton(
            title: "Send Document to $patientName",
            press: () {
              Get.to(()=>UploadReportFileScreen(
                appointmentId: appointmentId,
              ));
            },),
        ),
      ),
    );
  }

  Stream<List<ReportModel>> fetchReport() {
    return fireStore.collection('appointment')
        .doc(appointmentId)
        .collection("report")
        .snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ReportModel.fromDocumentSnapshot(doc)).toList();
    });
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }


}


//const ReportTile(
//                         title: "TSH",
//                         subTitle: "Reference: 0.8-1.3 mg/dL",
//                         trailText: "26",
//                         trailColor: red1Color),
//                     const ReportTile(
//                         title: "Ammonia",
//                         subTitle: "40–70 μg/dL",
//                         trailText: "56",
//                         trailColor: green1Color),
//                     const ReportTile(
//                         title: "Blood Urea Nitrogen (BUN",
//                         subTitle: "8–20 mg/dL",
//                         trailText: "55",
//                         trailColor: red1Color),
//                     const ReportTile(
//                         title: "Ammonia",
//                         subTitle: "40–70 μg/dL",
//                         trailText: "56",
//                         trailColor: yellow1Color),
//SizedBox(height: height1,),
//                     const Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ColorIndicator(text: "Within Range", color: green1Color),
//                         ColorIndicator(text: "Borderline", color: yellow1Color),
//                         ColorIndicator(text: "Danger", color: red1Color),
//                       ],
//                     ),