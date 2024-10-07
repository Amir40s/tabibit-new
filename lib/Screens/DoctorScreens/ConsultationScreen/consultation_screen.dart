import 'package:flutter/material.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';

import 'Components/at_clinic_section.dart';
import 'Components/home_visit_section.dart';
import 'Components/in_office_section.dart';
import 'Components/video_consultation_section.dart';

class ConsultationScreen extends StatelessWidget {
  ConsultationScreen({super.key});

  final List<String> suggestion = [
    "All",
    "Pending",
    "Upcoming",
    "Completed",
    "Cancelled",
  ];

  @override
  Widget build(BuildContext context) {
    double height = 20.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Consultations"),
            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: height,),
                    VideoConsultationSection(),
                    SizedBox(height: height,),
                    HomeVisitSection(),
                    SizedBox(height: height,),
                    InOfficeSection(),
                    SizedBox(height: height,),
                    AtClinicSection(),
                    SizedBox(height: height,),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
