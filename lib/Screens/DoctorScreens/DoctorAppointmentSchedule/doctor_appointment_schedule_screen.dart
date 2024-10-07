import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/no_found_card.dart';

import '../../../Providers/DoctorAppointment/doctor_appointment_provider.dart';
import '../../../Providers/PatientAppointment/patient_appointment_provider.dart';
import '../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../model/data/appointment_model.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/appointment_container.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../PatientScreens/FilterScreen/Components/calender_section.dart';
import '../../PatientScreens/FindDoctorScreen/Components/suggestion_container.dart';
import '../ReminderScreen/reminder_screen.dart';
import '../SessionDetailScreen/session_detail_screen.dart';
import 'Components/doctor_appointment_button.dart';

class DoctorAppointmentSchedule extends StatelessWidget {
  DoctorAppointmentSchedule({super.key});

  final List<Map<String,String>> suggestion = [
    {
      "text1": "All",
      "text2": "All"
    },
    {
      "text1": "Pending",
      "text2": "pending"
    },
    {
      "text1": "Upcoming",
      "text2": "upcoming"
    },
    {
      "text1": "Completed",
      "text2": "complete"
    },
    {
      "text1": "Cancelled",
      "text2": "cancel"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final doctorAppointmentP = Provider.of<DoctorAppointmentProvider>(context,listen: false);
    double height = 20.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header2(text: "Appointment"),
            Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Consumer<DateProvider>(
                        builder: (context, dateProvider, child) {
                          DateTime currentMonth = dateProvider.selectedDate;
                          return Row(
                            children: [
                              const TextWidget(
                                text: "Schedules", fontSize: 20,
                                fontWeight: FontWeight.w600, isTextCenter: false,
                                textColor: textColor, fontFamily: AppFonts.semiBold,),
                              const Spacer(),
                              InkWell(
                                onTap:  () async {
                                  DateTime? selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: currentMonth,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (selectedDate != null) {
                                    dateProvider.updateSelectedDate(selectedDate);
                                    doctorAppointmentP.selDate(selectedDate);
                                  }
                                },
                                child: Row(
                                  children: [
                                    TextWidget(
                                        text: DateFormat('MMMM-yyyy').format(currentMonth), fontSize: 12,
                                        fontWeight: FontWeight.w400, isTextCenter: false,
                                        textColor: textColor),
                                    const SizedBox(width: 8,),
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: const BoxDecoration(
                                          color: bgColor,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 1.2
                                            )
                                          ]
                                      ),
                                      child: const Icon(CupertinoIcons.forward,color: themeColor,size: 20,),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },),
                    ),
                    SizedBox(height: height,),
                    Consumer<DateProvider>(
                      builder: (context, dateProvider, child) {
                        return CalendarSection(
                          month: dateProvider.selectedDate,
                          firstDate: DateTime.now(),
                        );
                      },),
                    SizedBox(height: height,),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              TextWidget(
                                text: "Appointments ", fontSize: 20,
                                fontWeight: FontWeight.w600, isTextCenter: false,
                                textColor: textColor,fontFamily: AppFonts.semiBold,),
                              TextWidget(
                                text: "", fontSize: 16,
                                fontWeight: FontWeight.w600, isTextCenter: false,
                                textColor: Colors.grey,fontFamily: AppFonts.semiBold,)
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height,),
                    SizedBox(
                        height: 40,
                        width: 100.w,
                        child: Consumer<DoctorAppointmentProvider>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(left: 20),
                              scrollDirection: Axis.horizontal,
                              itemCount: suggestion.length,
                              itemBuilder: (context, index) {
                                final isSelected = provider.selectedIndex == index;
                                return GestureDetector(
                                  onTap: () {
                                    provider.selectButton(index,suggestion[index]["text2"]!);
                                  },
                                  child: SuggestionContainer(
                                      text: suggestion[index]["text1"]!,
                                      boxColor: isSelected ? themeColor : bgColor,
                                      textColor: isSelected ? bgColor : themeColor),
                                );
                              },);
                          },)
                    ),
                    SizedBox(height: height,),
                    Consumer<DoctorAppointmentProvider>(
                      builder: (context, provider, child) {
                        return StreamBuilder<List<AppointmentModel>>(
                          stream: provider.selectedAppointmentStatus != "All"
                              ? provider.fetchPatients()
                              : provider.fetchAllPatients(),
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

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: patients.length,
                              itemBuilder: (context, index) {
                                final patient = patients[index];
                                final isPending = patient.status == "pending";
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
                                        updateStatus(patient.id);
                                      }
                                    },
                                    patientName: patient.patientName,
                                    patientGender: patient.patientGender,
                                    patientAge: patient.patientAge,
                                    patientPhone: patient.patientPhone,
                                    statusText: isPending ? "Accept" : patient.status,
                                    text1: "Appointment Date",
                                    text2: patient.appointmentDate,
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
                )
            )
          ],
        ),
      ),
    );
  }
  Future<void> updateStatus(id)async{
    fireStore.collection("appointment").doc(id).update({
      "status" : "upcoming"
    });
  }
}

//const DoctorAppointmentButton(
//                               title: "Smart Agenda",
//                               icon: AppIcons.agendaIcon,
//                               buttonColor: Color(0xff45D0EE)
//                           ),
//                           SizedBox(height: height,),
//                           DoctorAppointmentButton(
//                               onTap: () {
//                                 Get.to(()=>const ReminderScreen(
//                                   appBarText: "SMS Reminder",
//                                   email: "email",
//                                   age: "age",
//                                   gender: "gender",
//                                   name: "name",
//                                   time: "time",
//                                   location: "location",
//                                 ));
//                               },
//                               title: "SMS Reminder",
//                               icon: AppIcons.smsIcon,
//                               buttonColor: const Color(0xffF24C0F)
//                           ),
//                           SizedBox(height: height,),