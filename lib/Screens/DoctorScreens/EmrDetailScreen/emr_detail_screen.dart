import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/EmrDetailScreen/Components/medication_list_section.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/PrescribeMedicineScreen/prescribe_medicine_screen.dart';

import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/dotted_line.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/info_tile.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class EmrDetailScreen extends StatelessWidget {
  final String appointmentId;
  final String patientName;
  final String patientAge;
  final String patientGender;
  final String userProblem;
  const EmrDetailScreen({super.key,
    required this.appointmentId,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.userProblem});

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Electronic Medical Records"),
            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    TextWidget(
                      text: "Personal Details", fontSize: 18.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
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
                    SubmitButton(
                      title: "Chat",
                      icon: CupertinoIcons.chat_bubble_2_fill,
                      bgColor: bgColor,
                      textColor: themeColor,
                      iconColor: themeColor,
                      press: () {

                      },),
                    SizedBox(height: height1,),
                    Container(
                      width: 100.w,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: const Color(0xffE6F5FC),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: greyColor,
                                blurRadius: 1,
                                spreadRadius: .5
                            )
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: "Active Medical Conditions", fontSize: 18.sp,
                            fontWeight: FontWeight.w600, isTextCenter: false,
                            textColor: textColor, fontFamily: AppFonts.semiBold,),
                          SizedBox(height: height1,),
                          const DottedLine(color: greyColor,),
                          SizedBox(height: height1,),
                          TextWidget(
                            text: userProblem, fontSize: 18.sp,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: textColor, fontFamily: AppFonts.regular,),
                        ],
                      ),
                    ),
                    SizedBox(height: height1,),
                    MedicationListSection(appointmentId: appointmentId),
                    SizedBox(height: height1,),


                    SubmitButton(
                      title: "Write Prescription",
                      bgColor: bgColor,
                      textColor: themeColor,
                      press: () {
                        Get.to(()=>PrescribeMedicineScreen(
                            appointmentId: appointmentId,
                            isVisible: true));
                      },),
                    SizedBox(height: height1,),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
//Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextWidget(
//                           text: "Medication Reports", fontSize: 18.sp,
//                           fontWeight: FontWeight.w600, isTextCenter: false,
//                           textColor: textColor, fontFamily: AppFonts.semiBold,),
//                         TextWidget(
//                           text: "Download", fontSize: 14.sp,
//                           fontWeight: FontWeight.w500, isTextCenter: false,
//                           textColor: themeColor, fontFamily: AppFonts.regular,),
//                       ],
//                     ),
//                     SizedBox(height: height1,),
//Container(
//                       width: 100.w,
//                       padding: const EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                           color: const Color(0xffE6F5FC),
//                           borderRadius: BorderRadius.circular(20),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: greyColor,
//                                 blurRadius: 1,
//                                 spreadRadius: .5
//                             )
//                           ]
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 width: 65.w,
//                                 height: 60,
//                                 padding: const EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                   color: bgColor,
//                                   borderRadius: BorderRadius.circular(10)
//                                 ),
//                                 child: TextWidget(
//                                   text: "Stool for E.coli", fontSize: 18.sp,
//                                   fontWeight: FontWeight.w500, isTextCenter: false,
//                                   textColor: textColor, fontFamily: AppFonts.medium,),
//                               ),
//                               Container(
//                                 width: 14.w,
//                                 height: 60,
//                                 padding: const EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                   color: redColor.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(10)
//                                 ),
//                                 child: const Icon(CupertinoIcons.delete,color: redColor,size: 30,),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: height2,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 width: 65.w,
//                                 height: 60,
//                                 padding: const EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                   color: bgColor,
//                                   borderRadius: BorderRadius.circular(10)
//                                 ),
//                                 child: TextWidget(
//                                   text: "Lipid Profile", fontSize: 18.sp,
//                                   fontWeight: FontWeight.w500, isTextCenter: false,
//                                   textColor: textColor, fontFamily: AppFonts.medium,),
//                               ),
//                               Container(
//                                 width: 14.w,
//                                 height: 60,
//                                 padding: const EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                   color: redColor.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(10)
//                                 ),
//                                 child: const Icon(CupertinoIcons.delete,color: redColor,size: 30,),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: height2,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 width: 65.w,
//                                 height: 60,
//                                 padding: const EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                   color: bgColor,
//                                   borderRadius: BorderRadius.circular(10)
//                                 ),
//                                 child: TextWidget(
//                                   text: "Fasting Blood Glucose", fontSize: 18.sp,
//                                   fontWeight: FontWeight.w500, isTextCenter: false,
//                                   textColor: textColor, fontFamily: AppFonts.medium,),
//                               ),
//                               Container(
//                                 width: 14.w,
//                                 height: 60,
//                                 padding: const EdgeInsets.all(15),
//                                 decoration: BoxDecoration(
//                                   color: redColor.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(10)
//                                 ),
//                                 child: const Icon(CupertinoIcons.delete,color: redColor,size: 30,),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: height1,),