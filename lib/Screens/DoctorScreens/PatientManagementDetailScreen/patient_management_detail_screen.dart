import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/LabReportScreen/lab_report_screen.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/ResultScreen/result_screen.dart';

import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/dotted_line.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/info_tile.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../ChatScreens/chat_screen.dart';
import '../../../Providers/chatProvider/chat_provider.dart';
import '../../../model/data/appointment_model.dart';
import '../EPrescriptionScreen/Components/prescription_container.dart';
import '../EmrDetailScreen/Components/medication_list_section.dart';
import '../EmrDetailScreen/emr_detail_screen.dart';
import '../PatientManagementData/patient_management_data_screen.dart';
import '../PatientsLabReportScreen/patient_lab_report_screen.dart';
import '../PrescribeMedicineScreen/prescribe_medicine_screen.dart';

class PatientManagementDetailScreen extends StatelessWidget {
   const PatientManagementDetailScreen({
    super.key,
    required this.appointmentId,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.userProblem,
    required this.patientEmail,
    required this.doctorEmail,
    required this.profilePic,
  });

  final String appointmentId;
  final String patientName;
  final String patientAge;
  final String patientGender;
  final String userProblem;
  final String patientEmail;
  final String doctorEmail;
  final String profilePic;


  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Patient Details"),
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
                    SizedBox(
                        width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrescriptionContainer(
                            text: "Check\nReport",
                            icon: AppIcons.managePatientIcon,
                            boxColor: const Color(0xff45D0EE),
                            onTap: () {
                              Get.to(()=>LabReportScreen(
                                date: convertTimeStamp(appointmentId),
                                appointmentId: appointmentId,
                                patientName: patientName,
                                patientAge: patientAge,
                                patientGender: patientGender,
                              ));
                            },
                          ),
                          SizedBox(width: 4.w,),
                          PrescriptionContainer(
                            text: "EMR",
                            icon: AppIcons.emrIcon,
                            boxColor: const Color(0xffF24C0F),
                            onTap: () {
                              Get.to(()=> EmrDetailScreen(
                                appointmentId: appointmentId,
                                patientAge: patientAge,
                                patientGender: patientGender,
                                patientName: patientName,
                                userProblem: userProblem,

                              ));
                            },
                          ),

                        ],
                      )
                    ),
                    SizedBox(height: 3.h,),
                    SizedBox(
                      width: 100.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PrescriptionContainer(
                            text: "Results",
                            icon: AppIcons.resultIcon,
                            boxColor: const Color(0xffDEBA05),
                            onTap: () {
                              Get.to(()=> ResultScreen(
                                  appointmentId: appointmentId,
                                  patientName: patientName,
                                  patientAge: patientAge,
                                  patientGender: patientGender,
                                  userProblem: userProblem));
                            },
                          ),
                          SizedBox(width: 4.w,),
                          PrescriptionContainer(
                            text: "E-prescription",
                            icon: AppIcons.prescriptionIcon,
                            boxColor: const Color(0xff0596DE),
                            onTap: () {
                              Get.to(()=> PrescribeMedicineScreen(
                                  appointmentId: appointmentId,
                                  isVisible: true
                              ));
                            },
                          ),

                        ],
                      )
                    ),
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
                    SubmitButton(
                      title: "Chat",
                      icon: CupertinoIcons.chat_bubble_2_fill,
                      bgColor: bgColor,
                      textColor: themeColor,
                      iconColor: themeColor,
                      press: () async{log('CLicked on chat button');


                      final chatRoomId = await context.read<ChatProvider>().createOrGetChatRoom(patientEmail.toString(),"");                        log("Chat room id is::{$chatRoomId}");
                      Provider.of<ChatProvider>(context,listen: false).updateMessageStatus(chatRoomId);
                      Get.to(ChatScreen(
                          chatRoomId: chatRoomId,
                          patientEmail: patientEmail.toString(),
                          patientName: patientName.toString(), profilePic: profilePic,
                        deviceToken: "",
                        ));
                      },),
                    SizedBox(height: height1,),
                    MedicationListSection(
                      appointmentId: appointmentId,
                    ),
                    // SizedBox(height: height1,),
                    // Container(
                    //   width: 100.w,
                    //   padding: const EdgeInsets.all(15),
                    //   decoration: BoxDecoration(
                    //     color: const Color(0xffE6F5FC),
                    //     borderRadius: BorderRadius.circular(20),
                    //     boxShadow: const [
                    //       BoxShadow(
                    //         color: greyColor,
                    //         blurRadius: 1,
                    //         spreadRadius: .5
                    //       )
                    //     ]
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       TextWidget(
                    //         text: "Resolved Medical Conditions", fontSize: 18.sp,
                    //         fontWeight: FontWeight.w600, isTextCenter: false,
                    //         textColor: textColor, fontFamily: AppFonts.semiBold,),
                    //       SizedBox(height: height1,),
                    //       const DottedLine(color: greyColor,),
                    //       SizedBox(height: height1,),
                    //       TextWidget(
                    //         text: "1. Diarrhea", fontSize: 18.sp,
                    //         fontWeight: FontWeight.w400, isTextCenter: false,
                    //         textColor: textColor, fontFamily: AppFonts.regular,),
                    //       TextWidget(
                    //         text: "2. Hypovolemia", fontSize: 18.sp,
                    //         fontWeight: FontWeight.w400, isTextCenter: false,
                    //         textColor: textColor, fontFamily: AppFonts.regular,),
                    //       TextWidget(
                    //         text: "3. Gastritis", fontSize: 18.sp,
                    //         fontWeight: FontWeight.w400, isTextCenter: false,
                    //         textColor: textColor, fontFamily: AppFonts.regular,),
                    //
                    //
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: height1,),
                    // TextWidget(
                    //   text: "Medication List", fontSize: 18.sp,
                    //   fontWeight: FontWeight.w600, isTextCenter: false,
                    //   textColor: textColor, fontFamily: AppFonts.semiBold,),
                    // SizedBox(height: height1,),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: bgColor,
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(color: greyColor)
                    //   ),
                    //   child: ListTile(
                    //     leading: SvgPicture.asset(AppIcons.radioOffIcon),
                    //     title: TextWidget(
                    //       text: "Tab Valsartan 80mg", fontSize: 16.sp,
                    //       fontWeight: FontWeight.w500, isTextCenter: false,
                    //       textColor: textColor, fontFamily: AppFonts.medium,),
                    //     subtitle: TextWidget(
                    //       text: "Dosage: 1 q.d - qAM", fontSize: 12.sp,
                    //       fontWeight: FontWeight.w400, isTextCenter: false,
                    //       textColor: textColor, fontFamily: AppFonts.regular,),
                    //   ),
                    // ),
                    // SizedBox(height: height1,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     TextWidget(
                    //       text: "Medication Reports", fontSize: 18.sp,
                    //       fontWeight: FontWeight.w600, isTextCenter: false,
                    //       textColor: textColor, fontFamily: AppFonts.semiBold,),
                    //     TextWidget(
                    //       text: "Donwload", fontSize: 14.sp,
                    //       fontWeight: FontWeight.w600, isTextCenter: false,
                    //       textColor: Color(0xff0596DE), fontFamily: AppFonts.semiBold,),
                    //   ],
                    // ),
                    // SizedBox(height: height1,),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: bgColor,
                    //       borderRadius: BorderRadius.circular(10),
                    //       border: Border.all(color: greyColor)
                    //   ),
                    //   child: ListTile(
                    //     title: TextWidget(
                    //       text: "Gastrectomy", fontSize: 16.sp,
                    //       fontWeight: FontWeight.w500, isTextCenter: false,
                    //       textColor: textColor, fontFamily: AppFonts.medium,),
                    //     subtitle: TextWidget(
                    //       text: "27 July 2024", fontSize: 12.sp,
                    //       fontWeight: FontWeight.w400, isTextCenter: false,
                    //       textColor: textColor, fontFamily: AppFonts.regular,),
                    //   ),
                    // ),
                    // SizedBox(height: height1,),
                    // SubmitButton(
                    //   title: "Check Reports",
                    //   press: () {
                    //
                    // },),
                    SizedBox(height: height1,),
                  ],
            )
            )]
            )
      )
        );
  }

  convertTimeStamp<String>(timestamp) {

    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));

    return DateFormat('dd MMM yyyy').format(date);

    // log(formattedDate);
  }




  // Function to create chat room
  Future<void> createChatRoom(String doctorEmail, String patientEmail) async {
    final chatRoomId = _getChatRoomId(doctorEmail, patientEmail);

    // Reference to Firestore
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    // Check if chat room already exists
    final roomSnapshot = await _firestore.collection('chatRooms').doc(chatRoomId).get();

    if (!roomSnapshot.exists) {
      // If the chat room doesn't exist, create a new one
      await _firestore.collection('chatRooms').doc(chatRoomId).set({
        'doctorEmail': doctorEmail,
        'patientEmail': patientEmail,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    // Optionally, add initial message or other details if necessary
  }

  // Function to generate unique chat room ID based on doctor and patient emails
  String _getChatRoomId(String doctorEmail, String patientEmail) {
    return "${doctorEmail}_${patientEmail}";
  }
}
