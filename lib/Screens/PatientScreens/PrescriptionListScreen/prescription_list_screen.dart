import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/PatientAppointment/patient_appointment_provider.dart';
import '../../../constant.dart';
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
        body: Column(
          children: [
            const Header(text: "Prescription"),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: InputField2(
            //     inputController: searchC,
            //     hintText: "Find here!",
            //     prefixIcon: Icons.search,
            //     suffixIcon: Container(
            //       margin: const EdgeInsets.all(14),
            //       padding: const EdgeInsets.all(3),
            //       height: 20,
            //       width: 20,
            //       decoration: const BoxDecoration(
            //         color: greenColor,
            //         shape: BoxShape.circle,
            //       ),
            //       child: SvgPicture.asset(AppIcons.crossIcon),
            //     ),
            //   ),
            // ),
            SizedBox(height: height1,),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: MedicationListSection(
                    appointmentId: appointmentId,
                    isDel: false,
                    doctorName: doctorName,
                  ),
                ),
            ),
            SizedBox(height: height1,),
          ],
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
