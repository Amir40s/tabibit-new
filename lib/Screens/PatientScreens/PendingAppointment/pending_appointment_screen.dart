import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/controller/doctoro_specialiaty_controller.dart';
import 'package:tabibinet_project/model/res/widgets/app_bottom_sheet.dart';
import 'package:tabibinet_project/model/res/widgets/no_found_card.dart';

import '../../../Providers/MyAppointment/my_appointment_provider.dart';
import '../../../constant.dart';
import '../../../controller/translation_controller.dart';
import '../../../model/data/appointment_model.dart';
import '../../../model/res/constant/app_assets.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/curved_top_painter.dart';
import '../../../model/res/widgets/dotted_line.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../CancelAppointmentReason/cancel_appointment_reason_screen.dart';
import '../MyAppointmentScreen/Components/my_appointment_container.dart';

class PendingAppointmentScreen extends StatelessWidget {
  const PendingAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageP = Provider.of<TranslationProvider>(context);
    TranslationController controller = Get.put(TranslationController());
    AppDataController dataController = Get.put(AppDataController());

    Future.delayed(
      Duration.zero,
      () {
        dataController.fetchFees();
        Provider.of<MyAppointmentProvider>(context,listen: false).setAppointmentStatus("pending");
      }
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
                  return Center(child: Text('Error: ${languageP.translateSingleText(snapshot.error.toString())}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NoFoundCard();
                }

                final specs = dataController.feeList;

                log("List:: $specs");

                if (controller.feeList.isEmpty) {
                  controller.translateFees(
                    specs.map((e) => e.type).toList() +
                        specs.map((e) => e.subTitle).toList(),
                  );
                }

                final appoints = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appoints.length,
                  itemBuilder: (context, index) {
                    final appoint = appoints[index];

                    final docName = controller.translations[appoint.doctorName] ?? appoint.doctorName;
                    final feeType = controller.feeList[appoint.feesType] ?? appoint.feesType;

                    return MyAppointmentContainer(
                      appointmentIcon: AppIcons.phone,
                      doctorName: docName,
                      appointmentStatusText: "Pending",
                      chatStatusText: feeType,
                      image: appoint.image,
                      appointmentTimeText: appoint.appointmentTime,
                      ratingText: appoint.doctorRating,
                      leftButtonText: "Cancel",
                      rightButtonText: "Start",
                      statusTextColor: purpleColor,
                      statusBoxColor: purpleColor.withOpacity(0.1),
                      isPrimaryButtons: false,
                      onTap: () {},
                      leftButtonTap: () {
                      },
                      rightButtonTap: () {
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
