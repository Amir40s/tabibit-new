import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/PatientAppointment/patient_appointment_provider.dart';
import 'package:tabibinet_project/Screens/PatientScreens/PrescriptionListScreen/prescription_list_screen.dart';
import 'package:tabibinet_project/Screens/PatientScreens/patient_medication_screen/patient_medication_screen.dart';

import '../../DoctorScreens/PatientManagementDetailScreen/patient_management_detail_screen.dart';
import '../../../constant.dart';
import '../../../model/data/appointment_model.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class PatientMedicationListScreen extends StatelessWidget {
  const PatientMedicationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doctorAppointmentP = Provider.of<PatientAppointmentProvider>(context,listen: false);
    double height1 = 20.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header2(text: "Prescription"),
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
                child: StreamBuilder<List<AppointmentModel>>(
                  stream: doctorAppointmentP.fetchPatientsSingle(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No Prescription found'));
                    }

                    // List of users
                    final users = snapshot.data!;

                    return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: greyColor
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: user.patientName, fontSize: 16.sp,
                                      fontWeight: FontWeight.w600, isTextCenter: false,
                                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                                    const SizedBox(height: 10,),
                                    TextWidget(
                                      text: "ID Number: #${user.id}", fontSize: 14.sp,
                                      fontWeight: FontWeight.w400, isTextCenter: false,
                                      textColor: textColor, ),
                                  ],
                                ),
                                SubmitButton(
                                  width: 26.w,
                                  height: 40,
                                  title: "View Detail",
                                  textColor: themeColor,
                                  bgColor: themeColor.withOpacity(0.1),
                                  press: () {
                                    Get.to(()=>PrescriptionListScreen(
                                        appointmentId: user.id,
                                      doctorName: user.doctorName,
                                    ));
                                    // Get.to(()=> PatientMedicationScreen(
                                    //     doctorName: user.doctorName,
                                    //     appointmentId: user.id, prescriptionId: '',
                                    // ));
                                  },)
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 15,);
                        },
                        itemCount: users.length
                    );
                  },
                )
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
