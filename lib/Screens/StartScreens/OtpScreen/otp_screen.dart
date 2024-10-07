import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../../Providers/Location/location_provider.dart';
import '../../../Providers/SignIn/sign_in_provider.dart';
import '../../../Providers/SignUp/sign_up_provider.dart';
import '../../../constant.dart';
import 'package:tabibinet_project/model/res/constant/app_utils.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../../model/res/widgets/toast_msg.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key,});

  final pinC = TextEditingController();
  final appUtils = AppUtils();

  // final String otp;

  @override
  Widget build(BuildContext context) {
    double height1 = 10.0;
    double height2 = 30.0;
    final signInP = Provider.of<SignInProvider>(context,listen: false);
    final locationP = Provider.of<LocationProvider>(context,listen: false);
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
                  text: "Verify OTP", fontSize: 24,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor),
            ),
            SizedBox(height: height2,),
            const Center(
              child: TextWidget(
                text: "Enter OTP code received to authenticate "
                    "your identity and complete verification", fontSize: 14,
                fontWeight: FontWeight.w400, isTextCenter: true,
                textColor: textColor,maxLines: 2,),
            ),
            SizedBox(height: height2,),
            SizedBox(height: height1,),
            Pinput(
              controller: pinC,
              defaultPinTheme: PinTheme(
                height: 60,
                width: 60,
                  textStyle: const TextStyle(fontFamily: AppFonts.semiBold,fontSize: 18),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: greyColor
                      )
                  )
              ),
              focusedPinTheme: PinTheme(
                height: 60,
                width: 60,
                  textStyle: const TextStyle(fontFamily: AppFonts.semiBold,fontSize: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: greenColor
                  )
                )
              ),
            ),
            SizedBox(height: height2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextWidget(text: "Did’nt receive email?", fontSize: 16, fontWeight: FontWeight.w500, isTextCenter: false, textColor: textColor),
                Consumer<SignUpProvider>(
                  builder: (context, value, child) {
                    return InkWell(
                        onTap: () async {
                          int otp = AppUtils().generateUniqueNumber();
                          await appUtils.sendMail(
                              recipientEmail: value.emailC.text.toString(),
                              otpCode: otp.toString(),
                              context: context
                          );
                          Provider.of<SignUpProvider>(context,listen: false).setOTP(otp.toString());
                          // Get.to(()=>SignUpScreen());
                        },
                        child: const TextWidget(
                          text: "Resend", fontSize: 16, fontWeight: FontWeight.w400,
                          isTextCenter: false, textColor: themeColor,fontFamily: AppFonts.medium,));
                  },),
              ],
            ),
            const SizedBox(height: 120,),
            Consumer<SignUpProvider>(
              builder: (context, value, child) {
                return value.isLoading ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator()),
                  ],
                )
                    : SubmitButton(
                  title: "Continue",
                  press: () async {
                    FocusScope.of(context).unfocus();
                    if(value.otp == pinC.text){
                      // sentOTP(value.emailC.text.toString());
                      await value.signUp(
                          speciality:  signInP.speciality,
                          specialityId: signInP.specialityId,
                          specialityDetail:  signInP.specialityDetailC.text.toString(),
                          yearsOfExperience: signInP.yearsOfExperienceC.text.toString(),
                          appointmentFrom:  signInP.appointmentFrom,
                          appointmentTo: signInP.appointmentTo,
                          appointmentFee: signInP.appointmentFeeC.text.toString(),
                          type: signInP.userType,
                          country: locationP.countryName,
                          location: locationP.userLocation,
                          latitude: locationP.latitude,
                          longitude: locationP.longitude
                      );
                    }
                    else{
                      ToastMsg().toastMsg("OTP is Incorrect");
                    }
                    // Get.to(()=>const SuccessScreen(
                    //   title: "Reset Successfully!",
                    //   subTitle: "Your password has been reset successfully."
                    //       " Please login with new credentials.",
                    // ));
                  },);
              },),
          ],
        ),
      ),
    );
  }
}
