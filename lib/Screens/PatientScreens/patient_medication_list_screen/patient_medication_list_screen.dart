import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/Language/new/translation_new_provider.dart';
import 'package:tabibinet_project/Providers/PatientAppointment/patient_appointment_provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/Screens/PatientScreens/PrescriptionListScreen/prescription_list_screen.dart';
import 'package:tabibinet_project/Screens/PatientScreens/patient_medication_screen/patient_medication_screen.dart';

import '../../../Providers/Language/language_provider.dart';
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
    final languageP = Provider.of<TranslationProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header2(text: "Prescription"),
            SizedBox(height: height1,),
            Expanded(
                child: Consumer<TranslationNewProvider>(
                  builder: (context, provider, child){
                    return StreamBuilder<List<AppointmentModel>>(
                      stream: doctorAppointmentP.fetchPatientsSingle(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return  Center(child: Text(languageP.translatedTexts["No Prescription found"] ?? "No Prescription found"));
                        }

                        // List of users
                        final users = snapshot.data!;

                        if (provider.prescriptionPatientList.isEmpty) {
                          provider.translatePatientPrescription(
                            users.map((e) => e.patientName).toList(),
                          );
                        }


                        return ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemBuilder: (context, index) {
                              final user = users[index];
                              final name = provider.prescriptionPatientList[user.patientName] ?? user.patientName;
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
                                          text: name, fontSize: 16.sp,
                                          fontWeight: FontWeight.w600, isTextCenter: false,
                                          textColor: textColor, fontFamily: AppFonts.semiBold,),
                                        const SizedBox(height: 10,),
                                        TextWidget(
                                          text: "${languageP.translatedTexts["ID Number:"] ?? "ID Number:"} #${user.id}", fontSize: 14.sp,
                                          fontWeight: FontWeight.w400, isTextCenter: false,
                                          textColor: textColor, ),
                                      ],
                                    ),
                                    SubmitButton(
                                      width: 26.w,
                                      height: 40,
                                      title: "${languageP.translatedTexts["View Detail"] ?? "View Detail"}",
                                      textColor: themeColor,
                                      bgColor: themeColor.withOpacity(0.1),
                                      press: () {
                                        Get.to(()=>PrescriptionListScreen(
                                          appointmentId: user.id,
                                          doctorName: user.doctorName,
                                        ));
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
