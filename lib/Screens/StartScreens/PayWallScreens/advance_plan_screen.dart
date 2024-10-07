import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/payment/payment_provider.dart';
import '../../../Providers/SignUp/sign_up_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../PatientScreens/PatientBottomNavBar/patient_bottom_nav_bar.dart';
import 'Components/plan_row.dart';

class AdvancePlanScreen extends StatelessWidget {
  const AdvancePlanScreen({super.key});

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
            text: "550 dhs/Month", fontSize: 20, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: textColor,fontFamily: AppFonts.medium,),
          const TextWidget(
            text: "All Features from Basic Offer", fontSize: 20, fontWeight: FontWeight.w500,
            isTextCenter: false, textColor: themeColor,fontFamily: AppFonts.medium,),
          const SizedBox(height: 10,),
          const PlanRow(tickColor: themeColor, text: "Comprehensive Access to Electronic Medical Records (EMR)"),
          const PlanRow(tickColor: themeColor, text: "Unlimited Electronic Prescriptions"),
          const PlanRow(tickColor: themeColor, text: "Advanced Patient Management"),
          const PlanRow(tickColor: themeColor, text: "Detailed Reports & Analytics"),
          const PlanRow(tickColor: themeColor, text: "Unlimited Document Management"),
          const PlanRow(tickColor: themeColor, text: "Integration with Medical Devices"),
          const PlanRow(tickColor: themeColor, text: "Advance Notifications and Alerts"),
          const PlanRow(tickColor: themeColor, text: "Offline Access"),
          const PlanRow(tickColor: themeColor, text: "Priority Customer Support"),
          const PlanRow(tickColor: themeColor, text: "Automated Search"),
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