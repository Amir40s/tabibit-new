import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/DoctorHome/doctor_home_provider.dart';
import 'package:tabibinet_project/Providers/Language/new/translation_new_provider.dart';
import 'package:tabibinet_project/Providers/subscription_provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/puahNotification/push_notification.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/constant/app_utils.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../Providers/DoctorAppointment/doctor_appointment_provider.dart';
import '../../../Providers/Profile/profile_provider.dart';
import '../../../model/data/appointment_model.dart';
import '../../../model/res/widgets/appointment_container.dart';
import '../../../model/res/widgets/no_found_card.dart';
import '../DoctorAppointmentSchedule/doctor_appointment_schedule_screen.dart';
import '../SessionDetailScreen/session_detail_screen.dart';
import 'Components/doctor_home_header.dart';
import 'Components/patient_detail_chart.dart';
import 'Components/quick_access_section.dart';

class DoctorHomeScreen extends StatelessWidget with WidgetsBindingObserver{
   const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context,listen: false).getSelfInfo();
    Provider.of<DoctorHomeProvider>(context,listen: false).setNumberOfPatients();
    Provider.of<DoctorHomeProvider>(context,listen: false).setNumberOfReminders();
    final languageP = Provider.of<TranslationProvider>(context);
    double height = 20;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const DoctorHomeHeader(),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: height,),
                    const PatientDetailChart(),
                    SizedBox(height: height,),
                    Consumer<SubscriptionProvider>(
                     builder: (context, provider, child){
                       provider.initialize();
                       return  TextWidget(
                         text: languageP.translatedTexts["Quick Access"] ?? "Quick Access", fontSize: 20,
                         fontWeight: FontWeight.w600, isTextCenter: false,
                         textColor: textColor,fontFamily: AppFonts.semiBold,);
                     },
                    ),
                    SizedBox(height: height,),
                    const QuickAccessSection(),
                    SizedBox(height: height,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         const TextWidget(
                          text: "Appointments", fontSize: 20,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: textColor,fontFamily: AppFonts.semiBold,),
                        InkWell(
                          onTap: () {
                            Get.to(()=>DoctorAppointmentSchedule());
                          },
                          child: TextWidget(
                            text: "View All", fontSize: 15.sp,
                            fontWeight: FontWeight.w600, isTextCenter: false,
                            textColor: themeColor,fontFamily: AppFonts.semiBold,),
                        ),

                      ],
                    ),
                    SizedBox(height: height,),
                    Consumer2<DoctorAppointmentProvider,TranslationNewProvider>(
                      builder: (context, provider,transP, child) {
                        return StreamBuilder<List<AppointmentModel>>(
                          stream:  provider.fetchAllPatients(limit: 3),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const NoFoundCard(
                                subTitle: "",
                              );
                            }

                            // List of users
                            final patients = snapshot.data!;
                            if (transP.doctorPatientList.isEmpty) {
                              transP.translateDoctorPatient(
                                patients.map((e) => e.name).toList() +
                                    patients.map((e) => e.patientGender).toList() +
                                    patients.map((e) => e.patientName).toList() +
                                    patients.map((e) => e.patientAge).toList() +
                                    patients.map((e) => e.patientPhone).toList() +
                                    patients.map((e) => e.appointmentDate).toList() +
                                    patients.map((e) => e.status).toList(),
                              );
                            }

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: patients.length,
                              itemBuilder: (context, index) {
                                final patient = patients[index];
                                final isPending = patient.status == "pending";
                                final patientName = transP.doctorPatientList[patient.name] ?? patient.name;
                                final patientGender = transP.doctorPatientList[patient.patientGender] ?? patient.patientGender;
                                final patientAge = transP.doctorPatientList[patient.patientAge] ?? patient.patientAge;
                                final patientPhone = transP.doctorPatientList[patient.patientPhone] ?? patient.patientPhone;
                                final status = transP.doctorPatientList[patient.status] ?? patient.status;
                                final appointmentDate = transP.doctorPatientList[patient.appointmentDate] ?? patient.appointmentDate;

                                final isDatePassed = AppUtils().isTimestampDatePassed(int.parse(patient.id));


                                return AppointmentContainer(
                                    onTap : () {
                                      Get.to(() =>
                                          SessionDetailScreen(
                                            status: patient.status,
                                            statusTextColor: themeColor,
                                            boxColor: secondaryGreenColor,
                                            model: patient,
                                          ));
                                    },
                                    statusTap: () {
                                      if(isPending){
                                        updateStatus(
                                            patient.id,
                                            patient.patientToken,
                                            patient.doctorName
                                        );
                                        log("Patient Notification: ${patient.patientToken}");
                                      }
                                    },
                                    patientName: patientName,
                                    patientGender: patientGender,
                                    patientAge: patientAge,
                                    patientPhone: patientPhone,
                                    statusText: isDatePassed ? "expire" :   isPending ? languageP.translatedTexts["Accept"] ?? "" : status,
                                    text1: "Appointment Date",
                                    text2: appointmentDate,
                                    statusTextColor: isPending ? bgColor : themeColor,
                                    boxColor: isPending ? themeColor : secondaryGreenColor
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 15,);
                              },);
                          },
                        );
                      },),
                    SizedBox(height: height,),

                  ],
            ))
          ],
        ),
      ),
    );
  }
   Future<void> updateStatus(id,deviceToken,doctorName,{String? status})async{
    final fcm = FCMService();
    String subTitle = "Dr $doctorName has changed your appointment status";
     fireStore.collection("appointment").doc(id).update({
       "status" : "upcoming"
     });
     if(status !=null){
       subTitle  = "Your Appointment has been expired";
     }
    fcm.sendNotification(deviceToken,
        "Your Appointment been updated",
         subTitle,
        auth.currentUser?.uid.toString() ?? ""
    );
   }
}
