import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/MyAppointment/my_appointment_provider.dart';
import 'package:tabibinet_project/model/data/appointment_model.dart';
import 'package:tabibinet_project/model/res/constant/app_assets.dart';

import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/app_bottom_sheet.dart';
import '../../../model/res/widgets/curved_top_painter.dart';
import '../../../model/res/widgets/dotted_line.dart';
import '../../../model/res/widgets/no_found_card.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../CancelAppointmentReason/cancel_appointment_reason_screen.dart';
import '../MyAppointmentScreen/Components/my_appointment_container.dart';
import '../StartAppointmentScreen/start_appointment_screen.dart';

class UpComingAppointment extends StatelessWidget {
  const UpComingAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () => Provider.of<MyAppointmentProvider>(context,listen: false).setAppointmentStatus("upcoming"),
    );
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        const SizedBox(
          height: 20,
        ),
        Consumer<MyAppointmentProvider>(
          builder: (context, value, child) {
            return StreamBuilder<List<AppointmentModel>>(
              stream: value.filterValue.isNotEmpty ? value.fetchFilterAppointment() :
              value.fetchMyAppointment(),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NoFoundCard();
                }

                final appoints = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appoints.length,
                  itemBuilder: (context, index) {
                    final appoint = appoints[index];
                    return MyAppointmentContainer(
                      appointmentIcon: AppIcons.phone,
                      doctorName: appoint.doctorName,
                      appointmentStatusText: "Upcoming",
                      chatStatusText: appoint.feesType,
                      image: appoint.image,
                      appointmentTimeText: appoint.appointmentTime,
                      ratingText: appoint.doctorRating,
                      leftButtonText: "Cancel",
                      rightButtonText: "Start",
                      statusTextColor: purpleColor,
                      statusBoxColor: purpleColor.withOpacity(0.1),
                      onTap: () {},
                      leftButtonTap: () {
                        Get.bottomSheet(
                                AppBottomSheet(
                                  height: 50.h,
                                  width: 100.w,
                                  title: "Cancel Appointment",
                                  subTitle: "Are you sure you want cancel\nthis appointment",
                                  primaryButText: "Yes Cancel",
                                  secondaryButText: "Back to Home",
                                  primaryButTap: () {
                                    Get.back();
                                    Get.to(()=>CancelAppointmentReasonScreen(
                                      appointmentId: appoint.id,
                                    ));
                                  },
                                )
                            );
                      },
                      rightButtonTap: () {
                        Get.to(()=>StartAppointmentScreen(
                          doctorName: appoint.doctorName,
                          doctorDeviceToken: appoint.deviceToken,
                          doctorId: appoint.doctorId,
                          appointmentTime: appoint.appointmentTime,
                          consultancyFee: appoint.fees,
                          consultancyType: appoint.feesType,
                          consultancySubTitle: appoint.feeSubTitle,
                        ));
                      },
                    );
                  },
                );
              },);
          },),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}


//Container(
//                     width: 100.w,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     decoration: const BoxDecoration(
//                       color: bgColor,
//                       borderRadius: BorderRadius.vertical(top: Radius.circular(100))
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const SizedBox(height: 30,),
//                         const TextWidget(
//                           text: "Cancel Appointment", fontSize: 24,
//                           fontWeight: FontWeight.w600, isTextCenter: false,
//                           textColor: redColor, fontFamily: AppFonts.medium,
//                         ),
//                         const SizedBox(height: 30,),
//                         const DottedLine(color: greyColor,),
//                         const SizedBox(height: 30,),
//                         const TextWidget(
//                           text: "Are you sure you want to log out", fontSize: 16,
//                           fontWeight: FontWeight.w400, isTextCenter: false,
//                           textColor: textColor,
//                         ),
//                         const SizedBox(height: 30,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SubmitButton(
//                                 width: 38.w,
//                                 height: 50,
//                                 title: "",
//                                 textColor: themeColor,
//                                 bgColor: bgColor,
//                                 bdRadius: 6,
//                                 press: () {
//
//                                 },
//                             ),
//                             SubmitButton(
//                                 width: 38.w,
//                                 height: 50,
//                                 title: "",
//                                 bdRadius: 6,
//                                 press: () {
//
//                                 },
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 20,),
//                       ],
//                     ),
//                   )
