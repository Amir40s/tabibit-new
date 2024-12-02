import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/actionProvider/actionProvider.dart';
import 'package:tabibinet_project/Providers/actionProvider/forgot_provider.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../../../Providers/SignUp/sign_up_provider.dart';
import '../../../Providers/TwilioProvider/twilio_provider.dart';
import '../../../Providers/actionProvider/country_code_picker.dart';
import '../../../constant.dart';
import '../../../model/res/components/phone_number_widget.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_utils.dart';
import '../../../model/res/widgets/input_field.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../OtpScreen/otp_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final phoneC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height1 = 10.0;
    double height2 = 30.0;
    final twilioProvider = Provider.of<TwilioProvider>(context,listen: false);
    final forgotP = Provider.of<ForgotProvider>(context);
    final countryP = Provider.of<CountryPickerProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            const SizedBox(height: 50,),
            const Center(
              child: TextWidget(
                  text: "Forgot Password", fontSize: 24,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor),
            ),
            SizedBox(height: height2,),
            const Center(
              child: TextWidget(
                text: "Reset your password securely for "
                    "uninterrupted access to your account.", fontSize: 14,
                fontWeight: FontWeight.w400, isTextCenter: true,
                textColor: textColor,maxLines: 2,),
            ),
            SizedBox(height: height2,),
            const TextWidget(
              text: "Email", fontSize: 14,
              fontWeight: FontWeight.w600, isTextCenter: false,
              textColor: textColor,fontFamily: AppFonts.semiBold,),
            SizedBox(height: height1,),
            PhoneNumberWidget(
              controller: phoneC,
            ),
            const SizedBox(height: 120,),
            Consumer<ActionProvider>(
             builder: (context,provider,child){
               return  provider.isLoading ?
              const Center(child: CircularProgressIndicator(color: themeColor,),) :
               SubmitButton(
                 title: "Send OTP",
                 press: () async{
                   if(countryP.enteredPhoneNumber.isNotEmpty){
                     ActionProvider().startLoading();
                     bool isPhoneExist = await forgotP.checkPhoneNumberExistsAndFetchData(countryP.enteredPhoneNumber);
                     if(isPhoneExist){
                       int otp = AppUtils().generateUniqueNumber();
                       Provider.of<SignUpProvider>(context, listen: false).setOTP(otp.toString());
                       await twilioProvider.sendSmsReminder(
                         countryP.enteredPhoneNumber,
                         "Your TabibiNet Account Recovery Verification Code is: ${otp.toString()}\nPlease Don't Share OTP Code anyone",
                       );
                       ActionProvider().stopLoading();
                       Get.to(OtpScreen(type: "forgot",));
                       ToastMsg().toastMsg("OTP sent to your phone number!");
                     }else{
                       ActionProvider().stopLoading();
                       ToastMsg().toastMsg("Account Not Found against phone number: ${countryP.enteredPhoneNumber}");
                     }
                   }

                 },);
             },
            ),
          ],
        ),
      ),
    );
  }
}
