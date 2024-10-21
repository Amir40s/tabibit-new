import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/Language/new/translation_new_provider.dart';
import 'package:tabibinet_project/Providers/call_data_provider.dart';
import 'package:tabibinet_project/Screens/PatientScreens/PatientBottomNavBar/patient_bottom_nav_bar.dart';
import 'package:tabibinet_project/Screens/PatientScreens/ReviewScreen/appointment_review_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../Providers/MyAppointment/my_appointment_provider.dart';
import '../../../model/res/constant/app_assets.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/no_found_card.dart';
import '../MyAppointmentScreen/Components/my_appointment_container.dart';

class CompletedAppointmentScreen extends StatelessWidget {
  const CompletedAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration.zero,
        () => Provider.of<MyAppointmentProvider>(context,listen: false).setAppointmentStatus("complete")
    );

    final callDataP  = Provider.of<CallDataProvider>(context,listen: false);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        const SizedBox(
          height: 20,
        ),
        Consumer2<MyAppointmentProvider,TranslationNewProvider>(
          builder: (context, value,provider, child) {
            return StreamBuilder(
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
                if (provider.appointmentList.isEmpty) {
                  provider.translateAppointment(
                    appoints.map((e) => e.feesType).toList() +
                        appoints.map((e) => e.doctorName).toList() +
                        appoints.map((e) => e.feeSubTitle).toList(),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appoints.length,
                  itemBuilder: (context, index) {
                    final appoint = appoints[index];
                    final doctorName = provider.appointmentList[appoint.doctorName] ?? appoint.doctorName;
                    final feesType = provider.appointmentList[appoint.feesType] ?? appoint.feesType;
                    return MyAppointmentContainer(
                      appointmentIcon: AppIcons.chat,
                      doctorName:doctorName,
                      appointmentStatusText: "Accepted",
                      chatStatusText: feesType,
                      image: appoint.doctorImage,
                      appointmentTimeText: appoint.appointmentTime,
                      ratingText: appoint.doctorRating,
                      leftButtonText: "Back to Home",
                      rightButtonText: appoint.isReview == "false" ? "Leave a Review" : "Reviewed",
                      statusTextColor: themeColor,
                      statusBoxColor: secondaryGreenColor,
                      onTap: () {

                      },
                      leftButtonTap: () {
                        Get.back();
                      },
                      rightButtonTap: () async{
                        if(appoint.isReview == "false"){
                          callDataP.setLoading(false);
                          callDataP.setAppointments(appoint, false);
                          Get.to(AppointmentReviewScreen());
                        }
                      },
                    );
                  },
                );
              },
            );
          },),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
