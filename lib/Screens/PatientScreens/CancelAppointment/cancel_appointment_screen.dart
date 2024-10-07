import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Providers/MyAppointment/my_appointment_provider.dart';
import '../../../constant.dart';
import '../../../model/data/appointment_model.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/no_found_card.dart';
import '../MyAppointmentScreen/Components/my_appointment_container.dart';

class CancelAppointmentScreen extends StatelessWidget {
  const CancelAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration.zero,
        () => Provider.of<MyAppointmentProvider>(context,listen: false).setAppointmentStatus("cancel"));
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior.onDrag,
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
                      appointmentIcon: AppIcons.video,
                      doctorName: appoint.doctorName,
                      image: appoint.image,
                      appointmentStatusText: "Decline",
                      chatStatusText: appoint.feesType,
                      appointmentTimeText: appoint.appointmentTime,
                      ratingText: appoint.doctorRating,
                      leftButtonText: "Book Again",
                      rightButtonText: "Leave a Review",
                      statusTextColor: redColor,
                      statusBoxColor: redColor.withOpacity(0.1),
                      onTap: () {

                      },
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
