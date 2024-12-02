import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/PrescribeMedicineScreen/prescribe_medicine_screen.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../LabReportScreen/lab_report_screen.dart';

class EPrescriptionDataScreen extends StatelessWidget {
  const EPrescriptionDataScreen({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(text: "E-Prescriptions"),
            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  children: [
                    TextWidget(
                      text: "Prescriptions", fontSize: 20.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor,fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubmitButton(
                          width: 40.w,
                          height: 40,
                          title: "Follow up",
                          press: () {

                          },),
                        SubmitButton(
                          width: 40.w,
                          height: 40,
                          title: "Awaiting",
                          textColor: themeColor,
                          bgColor: bgColor,
                          press: () {

                          },),
                      ],
                    ),
                    SizedBox(height: height1,),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          // final user = users[index];
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
                                      text: "Micheal Rickliff", fontSize: 16.sp,
                                      fontWeight: FontWeight.w600, isTextCenter: false,
                                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                                    const SizedBox(height: 10,),
                                    TextWidget(
                                      text: "Prescription: Medication for GURD", fontSize: 14.sp,
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
                                    Get.to(()=> PrescribeMedicineScreen(
                                      isVisible: false,
                                      appointmentId: "",
                                      deviceToken: "",
                                      doctorName: "",
                                      patientId: "",
                                    ));
                                  },)
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 15,);
                        },
                        itemCount: 10
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }

}
