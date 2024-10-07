import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';
import '../../../Providers/TwilioProvider/twilio_provider.dart';
import '../../../Providers/actionProvider/actionProvider.dart';
import '../../../constant.dart';
import '../../../model/data/appointment_model.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/info_tile.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class SessionDetailScreen extends StatelessWidget {
  SessionDetailScreen({
    super.key,
    required this.status,
    required this.statusTextColor,
    required this.boxColor,
    required this.model,
  });

  final String status;
  final Color statusTextColor;
  final Color boxColor;
  final AppointmentModel model;


  final nameC = TextEditingController();
  final ageC = TextEditingController();
  final genderC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height1 = 20;
    double height2 = 10;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Session Details"),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: height1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: "Patient Details", fontSize: 18.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: textColor, fontFamily: AppFonts.semiBold,),
                        Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color: boxColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: TextWidget(
                            text: status, fontSize: 16,
                            fontWeight: FontWeight.w500, isTextCenter: false,
                            textColor: statusTextColor, fontFamily: AppFonts.medium,),
                        ),
                      ],
                    ),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Full Name", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                     InfoTile(title: model.patientName),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Age", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                     InfoTile(title: model.patientAge.toString()),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Gender", fontSize: 14.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height2,),
                     InfoTile(title: model.patientGender.toString()),
                    SizedBox(height: height1,),
                    TextWidget(
                      text: "Present Complaint ", fontSize: 16.sp,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.medium,),
                    SizedBox(height: height2,),
                    TextWidget(
                      text: model.patientProblem.toString(),
                      fontSize: 12.sp, fontWeight: FontWeight.w400,
                      isTextCenter: false, textColor: textColor,
                      fontFamily: AppFonts.regular, maxLines: 10,
                    ),
                    SizedBox(height: height1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubmitButton(
                          width: 40.w,
                          title: "Decline",
                          textColor: redColor,
                          bgColor: redColor.withOpacity(0.1),
                          bdColor: redColor,
                          press: () async{

                           await fireStore.collection("appointment")
                                .doc(model.id)
                                .update({
                                  "status": "cancel",
                                });

                           ToastMsg().toastMsg("Appointment Cancel successfully");
                        },),
                        SubmitButton(
                          width: 40.w,
                          title: "Remind",
                          textColor: const Color(0xff04AD01),
                          bgColor: const Color(0xff04AD01).withOpacity(0.1),
                          bdColor: const Color(0xff04AD01),
                          press: () {
                            ActionProvider.startLoading();
                            uploadReminder();
                            ToastMsg().toastMsg("Successfully added to reminders!");

                          },),
                      ],
                    ),
                    SizedBox(height: height1,),
                    // SubmitButton(
                    //   title: "View E-prescriptions",
                    //   press: () {
                    //     Get.to(()=>EPrescriptionScreen());
                    // },)

                  ],
                )
            )
          ],
        ),
      ),
    );
  }

  void uploadReminder() async {
    var timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    ActionProvider.startLoading();

    try {
      final docRef = FirebaseFirestore.instance.collection('appointmentReminder').doc(timeStamp);
      await docRef.set({
        'patientName': model.patientName,
        'patientAge': model.patientAge,
        'patientEmail': model.patientEmail,
        'patientGender': model.patientGender,
        'patientProblem': model.patientProblem,
        'patientPhone': model.patientPhone,
        'appointmentDate': model.appointmentDate,
        'appointmentTime': model.appointmentTime,
        'status': status,
        'id': timeStamp,
        'location': model.feesType,
        'userUid' : auth.currentUser?.uid.toString()
      }).whenComplete(() {
        ToastMsg().toastMsg("Patient Add to Reminder Screen");
      },);
      ActionProvider.stopLoading();
      log('Reminder uploaded successfully');
    } catch (e) {
      ActionProvider.stopLoading();
      log('Error uploading reminder: $e');
    }
  }

}
