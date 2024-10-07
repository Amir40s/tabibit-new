import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/actionProvider/actionProvider.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';

import '../../../../constant.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';
import '../../../Providers/PatientAppointment/patient_appointment_provider.dart';
import '../../../Providers/payment/payment_provider.dart';
import '../BookingConfirmedScreen/booking_confirmed_screen.dart';
import 'Components/payment_detail_section.dart';
import 'Components/payment_method_section.dart';

class MakePaymentScreen extends StatelessWidget {
  const MakePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    final provider = Provider.of<PaymentProvider>(context,listen: false);
    final appointmentP = Provider.of<PatientAppointmentProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(text: "Make Payment"),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    const PaymentDetailSection(),
                    SizedBox(height: height1),
                    const TextWidget(
                  text: "Payment Methods", fontSize: 20,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.semiBold,
                ),
                    SizedBox(height: height1),
                    const PaymentMethodSection(),
                    SizedBox(height: height1),
                    SubmitButton(
                      title: "Confirm Appointment",
                      press: () async{
                        ActionProvider.startLoading();
                        await provider.initPaymentSheet(
                          amount: appointmentP.selectFee.toString(),
                          name: appointmentP.nameC.text.toString()
                        );
                      },),
                    SizedBox(height: height1),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
