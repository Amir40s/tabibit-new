import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/PatientAppointment/patient_appointment_provider.dart';

import '../../../../../constant.dart';
import '../../../../../model/res/constant/app_fonts.dart';
import '../../../../../model/res/widgets/dotted_line.dart';
import '../../../../../model/res/widgets/text_widget.dart';

class PaymentDetailSection extends StatelessWidget {
  const PaymentDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: secondaryGreenColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: greenColor)
      ),
      child: Column(
        children: [
          ListTile(
            title: TextWidget(
                text: "Consulting", fontSize: 14,
                fontWeight: FontWeight.w400, isTextCenter: false,
                textColor: textColor
            ),
            trailing: Consumer<PatientAppointmentProvider>(
              builder: (context, value, child) {
                return TextWidget(
                    text: "${value.selectFee} MAD", fontSize: 16,
                    fontWeight: FontWeight.w400, isTextCenter: false,
                    textColor: textColor
                );
              },),
          ),
          ListTile(
            title: TextWidget(
                text: "Appointment Date", fontSize: 14,
                fontWeight: FontWeight.w400, isTextCenter: false,
                textColor: textColor,maxLines: 2,
            ),
            trailing: Consumer<PatientAppointmentProvider>(
              builder: (context, value, child) {
                return TextWidget(
                    text: "${value.appointmentDate}", fontSize: 16,
                    fontWeight: FontWeight.w400, isTextCenter: false,
                    textColor: textColor
                );
              },),
          ),
          ListTile(
            title: TextWidget(text: "Other Service", fontSize: 14, fontWeight: FontWeight.w400, isTextCenter: false, textColor: textColor),
            trailing: TextWidget(text: "0.0 MAD", fontSize: 16, fontWeight: FontWeight.w400, isTextCenter: false, textColor: textColor),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.0),
            child: DottedLine(color: greyColor,),
          ),
          ListTile(
            title: TextWidget(
              text: "Total", fontSize: 14,
              fontWeight: FontWeight.w600, isTextCenter: false,
              textColor: textColor, fontFamily: AppFonts.semiBold,
            ),
            trailing: Consumer<PatientAppointmentProvider>(
              builder: (context, value, child) {
                return TextWidget(
                    text: "${value.selectFee} MAD", fontSize: 16,
                    fontWeight: FontWeight.w400, isTextCenter: false,
                    textColor: themeColor,fontFamily: AppFonts.semiBold,
                );
              },),
          ),
        ],
      ),
    );
  }
}
