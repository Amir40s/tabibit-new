import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/payment/payment_provider.dart';
import 'package:tabibinet_project/Screens/StartScreens/PayWallScreens/Components/plan_row.dart';

import '../../../Providers/SignUp/sign_up_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';

import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../PatientScreens/PatientBottomNavBar/patient_bottom_nav_bar.dart';

class PremiumPlanScreen extends StatelessWidget {
  const PremiumPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context,listen: false);
    final payment = Provider.of<PaymentProvider>(context,listen: false);
    return Container(
    width: 100.w,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: const Color(0xffE7EBFF)
        )
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidget(
          text: "350 dhs/Month", fontSize: 20, fontWeight: FontWeight.w500,
          isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium,),
        const TextWidget(
          text: "All Features from Free Offer", fontSize: 20, fontWeight: FontWeight.w500,
          isTextCenter: false, textColor: themeColor,fontFamily: AppFonts.medium,),
        const SizedBox(height: 10,),
        const PlanRow(tickColor: themeColor, text: "Smart Agenda"),
        const PlanRow(tickColor: themeColor, text: "Appointment Confirmation and Reminders"),
        const PlanRow(tickColor: themeColor, text: "Practice/Clinic Appointment Management"),
        const PlanRow(tickColor: themeColor, text: "Video Consultation / Home Visits / In-office / At Clinic"),
        const PlanRow(tickColor: themeColor, text: "Instant Messaging"),
        const PlanRow(tickColor: themeColor, text: "Access for Assistants"),
        const PlanRow(tickColor: themeColor, text: "SMS Reminders"),
        const PlanRow(tickColor: themeColor, text: "Prescription Creation"),
        const PlanRow(tickColor: themeColor, text: "DocShare"),
        const SizedBox(height: 10,),
        SubmitButton(
          title: "Get Started",
          radius: 100,
          press: () async{
          await  payment.initPaymentSheet(
                amount: "350",
                name: "Membership",
               type: "trial"
            );


          },)
      ],
    ),
          );
  }
}