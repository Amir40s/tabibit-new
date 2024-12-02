import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/LabReportScreen/Components/lap_report_list_widget.dart';
import 'package:tabibinet_project/controller/audioController.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../Providers/PatientAppointment/patient_appointment_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/header.dart';
import '../../DoctorScreens/EmrDetailScreen/Components/medication_list_section.dart';

class PrescriptionListScreen extends StatelessWidget {
  const PrescriptionListScreen({
    super.key,
    required this.appointmentId,
    required this.doctorName,
  });

  final String appointmentId;
  final String doctorName;

  @override
  Widget build(BuildContext context) {
    final doctorAppointmentP = Provider.of<PatientAppointmentProvider>(context,listen: false);
    double height1 = 20.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          padding:  EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(text: "Prescription",isPadding: false,),
              SizedBox(height: height1,),
              TextWidget(
                text: "Lap Reports", fontSize: 18.sp,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: textColor, fontFamily: AppFonts.semiBold,),
              SizedBox(height: height1,),
              LapReportListWidget(appointmentId: appointmentId,type: "patient",),
              SizedBox(height: height1,),
              TextWidget(
                text: "Medication List", fontSize: 18.sp,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: textColor, fontFamily: AppFonts.semiBold,),
              SizedBox(height: height1,),
              MedicationListSection(
                appointmentId: appointmentId,
                isDel: false,
                doctorName: doctorName,
              ),
              SizedBox(height: height1,),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: redColor,
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        //   child: const Icon(Icons.add_rounded,color: bgColor,size: 35,),
        //   onPressed: () {
        //
        // },),
      ),
    );
  }
}
