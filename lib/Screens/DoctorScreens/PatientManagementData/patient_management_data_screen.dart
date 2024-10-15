import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/DoctorAppointment/doctor_appointment_provider.dart';
import 'package:tabibinet_project/Providers/Language/new/translation_new_provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';

import '../../../Providers/PatientAppointment/patient_appointment_provider.dart';
import '../../../constant.dart';
import '../../../model/data/appointment_model.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/input_field.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../PatientManagementDetailScreen/patient_management_detail_screen.dart';

class PatientManagementDataScreen extends StatelessWidget {
  PatientManagementDataScreen({super.key});

  final searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final doctorAppointmentP = Provider.of<DoctorAppointmentProvider>(context,listen: false);
    double height1 = 20.0;
    final languageP = Provider.of<TranslationProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header2(text: "Patient Management"),
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
                         return const Center(child: Text('No Patients found'));
                       }

                       // List of users
                       final users = snapshot.data!;
                       if (provider.appointmentList.isEmpty) {
                         provider.translateAppointment(
                           users.map((e) => e.feesType).toList() +
                               users.map((e) => e.patientName).toList() +
                               users.map((e) => e.patientProblem).toList() +
                               users.map((e) => e.appointmentDate).toList() +
                               users.map((e) => e.doctorName).toList() +
                               users.map((e) => e.feeSubTitle).toList(),
                         );
                       }

                       return ListView.separated(
                           padding: const EdgeInsets.symmetric(horizontal: 20),
                           itemBuilder: (context, index) {
                             final user = users[index];
                             final patientName = provider.appointmentList[user.patientName] ?? user.patientName;
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
                                         text: patientName, fontSize: 16.sp,
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
                                     title: "View Detail",
                                     textColor: themeColor,
                                     bgColor: themeColor.withOpacity(0.1),
                                     press: () {
                                       Get.to(()=> PatientManagementDetailScreen(
                                         appointmentId : user.id,
                                         patientName: user.patientName,
                                         patientAge: user.patientAge,
                                         patientGender: user.patientGender,
                                         userProblem: user.patientProblem,
                                         patientEmail: user.patientEmail,
                                         doctorEmail: user.doctorEmail,
                                         profilePic: user.image,
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
