import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/PatientAppointment/patient_appointment_provider.dart';

import '../../../../../constant.dart';
import '../../../../../model/res/constant/app_fonts.dart';
import '../../../../../model/res/widgets/text_widget.dart';

class AgeSection extends StatelessWidget {
  AgeSection({super.key});

  final List<Map<String,String>> age = [
    {"age" : "10+"},
    {"age" : "20+"},
    {"age" : "30+"},
    {"age" : "40+"},
    {"age" : "50+"},
    {"age" : "60+"},
    {"age" : "70+"},
    {"age" : "80+"},
    {"age" : "90+"},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Consumer<PatientAppointmentProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: age.length,
            itemBuilder: (context, index) {
              final isSelected = value.selectPatientAge == index;
              return GestureDetector(
                onTap: () {
                  value.setPatientAge(index, age[index]["age"]!);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                  decoration: BoxDecoration(
                      color: isSelected ? themeColor : bgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: themeColor)
                  ),
                  child: Center(
                    child: TextWidget(
                      text: age[index]["age"]!, fontSize: 16,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: isSelected ? bgColor : themeColor, fontFamily: AppFonts.medium,),
                  ),
                ),
              );
            },);
        },),
    );
  }
}