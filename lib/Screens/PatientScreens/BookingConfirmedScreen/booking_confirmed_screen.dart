import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/Screens/PatientScreens/PatientBottomNavBar/patient_bottom_nav_bar.dart';
import 'package:tabibinet_project/Screens/PatientScreens/PatientHomeScreen/patient_home_screen.dart';
import 'package:tabibinet_project/controller/translation_controller.dart';
import 'package:tabibinet_project/Screens/PatientScreens/PatientBottomNavBar/patient_bottom_nav_bar.dart';
import 'package:tabibinet_project/model/res/components/circle_icon.dart';
import '../../../../constant.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/widgets/dotted_line.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';
import '../../../Providers/PatientAppointment/patient_appointment_provider.dart';

class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appointmentP = Provider.of<PatientAppointmentProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryGreenColor,
        body: Column(
          children: [
            const Header(text: ""),
            Expanded(
              child: ListView(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      SizedBox(
                        height: 86.h,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50.h,
                              width: 100.w,
                              child: Column(
                                children: [
                                  const CircleIcon(icon: Icons.done_rounded),
                                  SizedBox(height: 20.sp,),
                                  const TextWidget(
                                      text: "Booking Confirmed",
                                      fontSize: 24, fontWeight: FontWeight.w600,
                                      isTextCenter: false, textColor: textColor),
                                   TextWidget(
                                      text: "Dr. ${appointmentP.doctorName} Wilson is a highly skilled cardiologist"
                                          " dedicated to providing exceptional cardiac care. With ",
                                      fontSize: 12, fontWeight: FontWeight.w400,
                                      isTextCenter: true, textColor: textColor,maxLines: 2,),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(35))
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(color: Colors.grey,blurRadius: 1)
                                ]
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                       TextWidget(
                                          text: "ID : ${appointmentP.doctorId}",
                                          fontSize: 14, fontWeight: FontWeight.w400,
                                          isTextCenter: false, textColor: textColor),
                                      const Spacer(),
                                      // Container(
                                      //   padding: const EdgeInsets.all(5),
                                      //   decoration: BoxDecoration(
                                      //       color: bgColor,
                                      //       shape: BoxShape.circle,
                                      //       border: Border.all(color: greyColor)
                                      //   ),
                                      //   child: Icon(Icons.edit,color: Colors.grey,size: 18.sp,),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(13),
                                        height: 72,
                                        width: 72,
                                        decoration: BoxDecoration(
                                          color: greyColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 35.w,
                                            child:  TextWidget(
                                              text: "Dr. ${appointmentP.doctorName}", fontSize: 16,
                                              fontWeight: FontWeight.w600, isTextCenter: false,maxLines: 2,
                                              textColor: textColor, fontFamily: AppFonts.semiBold,),
                                          ),
                                          const SizedBox(height: 10,),
                                          SizedBox(
                                            width: 35.w,
                                            child: const TextWidget(
                                              text: "Online", fontSize: 14,
                                              fontWeight: FontWeight.w400, isTextCenter: false,
                                              textColor: textColor, fontFamily: AppFonts.regular,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                  const DottedLine(color: greyColor,),
                                  const SizedBox(height: 20,),
                                  SizedBox(
                                    height: 25.sp,
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TextWidget(
                                          text: "Name :",
                                          fontSize: 12, fontWeight: FontWeight.w400,
                                          isTextCenter: false, textColor: textColor,maxLines: 1,),
                                        TextWidget(
                                            text: "Dr. ${appointmentP.doctorName}", fontFamily: AppFonts.semiBold,
                                            fontSize: 12, fontWeight: FontWeight.w600,
                                            isTextCenter: false, textColor: textColor),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.sp,
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TextWidget(
                                          text: "Time :",
                                          fontSize: 12, fontWeight: FontWeight.w400,
                                          isTextCenter: false, textColor: textColor,maxLines: 1,),
                                        TextWidget(
                                            text: appointmentP.appointmentTime.toString(), fontFamily: AppFonts.semiBold,
                                            fontSize: 12, fontWeight: FontWeight.w600,
                                            isTextCenter: false, textColor: textColor),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.sp,
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TextWidget(
                                          text: "Date :",
                                          fontSize: 12, fontWeight: FontWeight.w400,
                                          isTextCenter: false, textColor: textColor,maxLines: 1,),
                                        TextWidget(
                                            text: appointmentP.appointmentDate.toString(), fontFamily: AppFonts.semiBold,
                                            fontSize: 12, fontWeight: FontWeight.w600,
                                            isTextCenter: false, textColor: textColor),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.sp,
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const TextWidget(
                                          text: "Total",
                                          fontSize: 12, fontWeight: FontWeight.w400,
                                          isTextCenter: false, textColor: textColor,maxLines: 1,),
                                        TextWidget(
                                            text: "${appointmentP.selectFee} MAD", fontFamily: AppFonts.semiBold,
                                            fontSize: 12, fontWeight: FontWeight.w600,
                                            isTextCenter: false, textColor: themeColor),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20,),
                            SubmitButton(
                              title: "Done",
                              press: () async {
                                Get.offAll(()=>PatientBottomNavBar());
                                // await appointmentP.sendAppointment();
                            },),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
