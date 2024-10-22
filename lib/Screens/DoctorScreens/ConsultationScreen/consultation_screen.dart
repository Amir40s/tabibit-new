import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/smartAgenda/smartAgendaProvider.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../Providers/translation/translation_provider.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../../model/smartAgenda/smartAgendaModel.dart';
import 'Components/at_clinic_section.dart';
import 'Components/home_visit_section.dart';
import 'Components/in_office_section.dart';
import 'Components/video_consultation_section.dart';

class ConsultationScreen extends StatefulWidget {
  ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  DateTime _selectedDate = DateTime.now();  // Keep track of the selected date

  final List<String> suggestion = [
    "All",
    "Pending",
    "Upcoming",
    "Completed",
    "Cancelled",
  ];

  @override
  Widget build(BuildContext context) {
    final smart = Provider.of<SmartAgendaProvider>(context);
    final transP = Provider.of<TranslationProvider>(context);
    double height = 20.0;
    List<PieChartSectionData>   pieSections = _showingSections(smart.feesTypeCounts);
    String inOfficeCount = smart.feesTypeCounts['In Office']?.toString() ?? "0";
    String homeVisitCount = smart.feesTypeCounts['Home Visit Consultation']?.toString() ?? "0";
    String teleconsultCount = smart.feesTypeCounts['Video Consultation']?.toString() ?? "0";

    // Get times from the provider
    String inOfficeTime = smart.feesTypeTimes['In Office'] ?? "Not Available";
    String homeVisitTime = smart.feesTypeTimes['Home Visit Consultation'] ?? "Not Available";
    String teleconsultTime = smart.feesTypeTimes['Video Consultation'] ?? "Not Available";


    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Header(text: "Smart Agenda"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: themeColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: transP.translatedTexts["Upcoming Appointments"] ?? "Upcoming Appointments",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        isTextCenter: false,
                        textColor: bgColor,
                      ),
                      SizedBox(height: height),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Pie Chart
                          SizedBox(
                            height: 100,
                            width: 30.w,
                            child: PieChart(
                              PieChartData(
                                sections: pieSections,
                                centerSpaceRadius: 40,
                                sectionsSpace: 4,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Details
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: smart.feesTypeCounts.keys.map((feesType) {
                              return buildDetailItem(
                                context,
                                _getColorForFeesType(feesType),
                                feesType,
                                smart.feesTypeCounts[feesType].toString(),
                              );
                            }).toList(),
                          ),

                        ],
                      ),
                      SizedBox(height: height),
                    ],
                  ),
                )
              ),
              SizedBox(height: height),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScheduleCard(
                      title: transP.translatedTexts["In Office"] ?? "In Office",
                      totalAppointments:  inOfficeCount,
                      time: inOfficeTime,
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                    SizedBox(height: 16),
                    ScheduleCard(
                      title: transP.translatedTexts["Clinic/Home Visit"] ?? "Clinic/Home Visit",
                      totalAppointments:  homeVisitCount,
                      time: homeVisitTime,
                      backgroundColor: Colors.deepOrangeAccent,
                    ),
                    SizedBox(height: 16),
                    ScheduleCard(
                      title: transP.translatedTexts["Video Consultation"] ?? "Video Consultation",
                      totalAppointments: teleconsultCount,
                      time: teleconsultTime,
                      backgroundColor: Colors.amberAccent,
                    ),
                    SizedBox(height: height,),
                    TextWidget(
                        text: "Appointments", fontSize: 18.sp,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: Colors.black),
                    SizedBox(height: height,),
                    CalendarScreen(onDateSelected: (selectedDate) {
                      setState(() {
                        _selectedDate = selectedDate;
                        log("selected date is${formatDateString(_selectedDate.toString())}");
                      });
                    }),
                    SizedBox(height: height,),
                    SectionTitle(title: transP.translatedTexts["In Office Appointments"] ?? "In Office Appointments"),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('appointment')
                          .where('feesType', isEqualTo: 'In Office')
                          .where('appointmentDate', isEqualTo: formatDateString(_selectedDate.toString()).toString())  // Filter by selected date

                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text(transP.translatedTexts["No appointments available"] ?? "No appointments available"));
                        } else {
                          var appointments = snapshot.data!.docs.map((doc) {
                            return SmartAppointment.fromFirestore(doc.data() as Map<String, dynamic>);
                          }).toList();

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              SmartAppointment appointment = appointments[index];
                              return AppointmentCard(
                                title: appointment.feesType,
                                patientId: appointment.feesId,
                                time: appointment.appointmentTime,
                                color: Colors.lightBlueAccent,
                              );
                            },
                          );
                        }
                      },
                    ),
                    SizedBox(height: height,),
                    SectionTitle(title: transP.translatedTexts["Video Consultations"] ?? "Video Consultations"),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('appointment')
                          .where('feesType', isEqualTo: 'Video Consultation')
                          .where('appointmentDate', isEqualTo: formatDateString(_selectedDate.toString()).toString())  // Filter by selected date

                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text(transP.translatedTexts["No appointments available."] ?? "No appointments available."));
                        } else {
                          var appointments = snapshot.data!.docs.map((doc) {
                            return SmartAppointment.fromFirestore(doc.data() as Map<String, dynamic>);
                          }).toList();

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              SmartAppointment appointment = appointments[index];
                              return AppointmentCard(
                                title: appointment.feesType,
                                patientId: appointment.feesId,
                                time: appointment.appointmentTime,
                                color: Colors.amberAccent,
                              );
                            },
                          );
                        }
                      },
                    ),

                    SizedBox(height: height,),
                    SectionTitle(title: transP.translatedTexts["At Clinic/Home"] ?? "At Clinic/Home"),
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('appointment')
                          .where('feesType', isEqualTo: 'Home Visit Consultation')
                          .where('appointmentDate', isEqualTo: formatDateString(_selectedDate.toString()).toString())  // Filter by selected date

                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text(transP.translatedTexts["No appointments available."] ?? "No appointments available."));
                        } else {
                          var appointments = snapshot.data!.docs.map((doc) {
                            return SmartAppointment.fromFirestore(doc.data() as Map<String, dynamic>);
                          }).toList();

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: appointments.length,
                            itemBuilder: (context, index) {
                              SmartAppointment appointment = appointments[index];
                              return AppointmentCard(
                                title: appointment.feesType,
                                patientId: appointment.feesId,
                                time: appointment.appointmentTime,
                                color: Colors.deepOrangeAccent,
                              );
                            },
                          );
                        }
                      },
                    ),

                    SizedBox(height: height,),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateString(String dateString) {
    // Parse the string into a DateTime object
    DateTime date = DateTime.parse(dateString);

    // Format the DateTime object into the desired format
    return DateFormat('EEEE, MMMM d').format(date);
  }

//////////data realTime/////
  List<PieChartSectionData> _showingSections(Map<String, int> feesTypeCounts) {
    return feesTypeCounts.entries.map((entry) {
      return PieChartSectionData(
        color: _getColorForFeesType(entry.key), // You can customize colors for each type
        value: entry.value.toDouble(),
        radius: 13,
        showTitle: false,
      );
    }).toList();
  }

  Color _getColorForFeesType(String feesType) {
    switch (feesType) {
      case 'In Office':
        return Colors.lightBlueAccent;
      case 'Home Visit Consultation':
        return Colors.red;
      case 'Video Consultation':
        return Colors.yellow;
      default:
        return Colors.grey; // Default color for any other feesType
    }
  }

  Widget buildDetailItem(BuildContext context, Color color, String title, String value) {
    final transP = Provider.of<TranslationProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        width: 40.w, // Adjust this width as needed
        child: Row(
          children: [
            CircleAvatar(
              radius: 4,
              backgroundColor: color,
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 28.w, // Adjust this width as needed
              child: Text(
                transP.translatedTexts[title] ?? title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp, // Adjust the font size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp, // Adjust the font size as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ScheduleCard extends StatelessWidget {
  final String title;
  final String totalAppointments;
  final String time;
  final Color backgroundColor;

  ScheduleCard({
    required this.title,
    required this.totalAppointments,
    required this.time,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          TextWidget(
          text: title, fontSize: 18.sp,
          fontWeight: FontWeight.w600, isTextCenter: false,
          textColor: bgColor),
              SizedBox(height: 8),
              TextWidget(
                  text: " $totalAppointments", fontSize: 14.sp,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: bgColor),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextWidget(
                  text: "Time", fontSize: 16.sp,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: bgColor),
              SizedBox(height: 8),
              TextWidget(
                  text: time, fontSize: 16.sp,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: bgColor),


            ],
          ),
        ],
      ),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;

  const CalendarScreen({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });

            // Call the callback to pass the selected date
            widget.onDateSelected(_selectedDay);
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.blue,

            ),
            todayDecoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              // shape: BoxShape.circle,
            ),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          headerVisible: false,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            weekendStyle: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}


class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextWidget(text:
        title,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
          textColor: Colors.black87,
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String title;
  final String patientId;
  final String time;
  final Color color;

  AppointmentCard({
    required this.title,
    required this.patientId,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 80,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text:
                  title,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 8),
                TextWidget(text: "Patient ID: $patientId", fontSize: 14.sp,),
                TextWidget(text: "Time: $time", fontSize: 14.sp,),
              ],
            ),
          ),

        ],
      ),
    );
  }


}
