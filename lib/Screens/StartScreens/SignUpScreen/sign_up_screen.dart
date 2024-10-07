import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/model/res/constant/app_utils.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';
import '../../../Providers/Location/location_provider.dart';
import '../../../Providers/SignIn/sign_in_provider.dart';
import '../../../Providers/SignUp/sign_up_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/dotted_line.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../SignInScreen/Components/sign_container.dart';
import '../SignInScreen/signin_screen.dart';
import 'Components/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final appUtils = AppUtils();

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
                  text: "Create an Account", fontSize: 24,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor),
            ),
            SizedBox(height: height2,),
            const Center(
              child: TextWidget(
                text: "Sign up today for personalized health insights"
                    " and exclusive member perks!", fontSize: 14,
                fontWeight: FontWeight.w400, isTextCenter: true,
                textColor: textColor,maxLines: 2,),
            ),
            SizedBox(height: height2,),
            Form(
                key: formKey,
                child: const SignUpForm()),
            SizedBox(height: height1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Consumer<SignUpProvider>(builder: (context, provider, child) {
                  return SizedBox(
                    height: 30,
                    width: 30,
                    child: Checkbox(
                      value: provider.isCheck,
                      onChanged: (value) {
                        provider.checkRememberPassword(value!);
                      },),
                  );
                },),
                const TextWidget(
                    text: "Remember Password", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor,fontFamily: AppFonts.semiBold,),
              ],
            ),
            SizedBox(height: height2,),
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
                title: "Sign Up",
                press: () async {
                  if(value.passwordC.text == value.confirmPasswordC.text){
                    if(formKey.currentState!.validate()){
                      int otp = AppUtils().generateUniqueNumber();
                      value.setLoading(true);
                      await appUtils.sendMail(
                          recipientEmail: value.emailC.text.toString(),
                          otpCode: otp.toString(),
                          context: context
                      );
                      Provider.of<SignUpProvider>(context,listen: false).setOTP(otp.toString());
                      value.setLoading(false);
                    }
                  }else{
                    ToastMsg().toastMsg("Confirm Password is InCorrect!");
                  }
                  },
              );
            },),
            SizedBox(height: height2,),
            const Row(
              children: [
                Expanded(
                  child: DottedLine(
                    height: 2,
                    color: greyColor,
                    dotLength: 4,
                    spacing: 4,
                    direction: Axis.horizontal,
                  ),
                ),
                TextWidget(
                  text: "Or Continue With", fontSize: 14,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor,fontFamily: AppFonts.semiBold,),
                Expanded(
                  child: DottedLine(
                    height: 2,
                    color: greyColor,
                    dotLength: 4,
                    spacing: 4,
                    direction: Axis.horizontal,
                  ),
                ),
              ],
            ),
            SizedBox(height: height2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignContainer(
                    onTap: () {
                      signInP.signInWithGoogle(
                          context,
                          locationP.countryName,
                          locationP.userLocation,
                          locationP.latitude,
                          locationP.longitude
                      );
                    },
                    image: AppIcons.googleIcon),
                // const SizedBox(width: 20,),
                // const SignContainer(image: AppIcons.appleIcon),
                // const SizedBox(width: 20,),
                // const SignContainer(image: AppIcons.facebookIcon),
              ],
            ),
            SizedBox(height: height2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextWidget(text: "Already have an account?", fontSize: 16, fontWeight: FontWeight.w500, isTextCenter: false, textColor: textColor),
                InkWell(
                    onTap: () {
                      Get.to(()=>SignInScreen());
                    },
                    child: const TextWidget(text: "Login", fontSize: 16, fontWeight: FontWeight.w400,
                        isTextCenter: false, textColor: themeColor,fontFamily: AppFonts.medium,)),
                const TextWidget(text: "here", fontSize: 16, fontWeight: FontWeight.w500, isTextCenter: false, textColor: textColor),

              ],
            ),
            SizedBox(height: height2,),
          ],
        ),
      ),
    );
  }
}
