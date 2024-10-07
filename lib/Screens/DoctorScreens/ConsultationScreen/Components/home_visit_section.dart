import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../Providers/DoctorAppointment/doctor_appointment_provider.dart';
import '../../../../constant.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/widgets/appointment_container.dart';
import '../../../../model/res/widgets/text_widget.dart';
import '../../../PatientScreens/FindDoctorScreen/Components/suggestion_container.dart';
import '../../ConsultationDetailScreen/consultation_detail_screen.dart';

class HomeVisitSection extends StatelessWidget {
  HomeVisitSection({super.key});

  final List<String> suggestion = [
    "All",
    "Pending",
    "Upcoming",
    "Completed",
    "Cancelled",
  ];

  @override
  Widget build(BuildContext context) {
    double height = 20.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextWidget(
            text: "Home Visits", fontSize: 18.sp,
            fontWeight: FontWeight.w600, isTextCenter: false,
            textColor: textColor, fontFamily: AppFonts.semiBold,),
        ),
        SizedBox(height: height,),
        SizedBox(
            height: 40,
            width: 100.w,
            child: Consumer<DoctorAppointmentProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: suggestion.length,
                  itemBuilder: (context, index) {
                    final isSelected = provider.selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        provider.selectButton(index,suggestion[index]);
                      },
                      child: SuggestionContainer(
                          text: suggestion[index],
                          boxColor: isSelected ? themeColor : bgColor,
                          textColor: isSelected ? bgColor : themeColor),
                    );
                  },);
              },)
        ),
        SizedBox(height: height,),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 2,
          itemBuilder: (context, index) {
            return AppointmentContainer(
                onTap: () {
                  Get.to(()=>ConsultationDetailScreen());
                },
                patientName: "",
                patientGender: "",
                patientAge: "",
                patientPhone: "",
                statusText: "Pending",
                text1: "Consultations Type",
                text2: "Video",
                statusTextColor: purpleColor,
                boxColor: purpleColor.withOpacity(0.1));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 15,);
          },),
      ],);
  }
}
