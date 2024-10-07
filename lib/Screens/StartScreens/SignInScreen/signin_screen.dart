import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/Location/location_provider.dart';
import 'package:tabibinet_project/Screens/StartScreens/DoctorInfoDetailScreen/doctor_info_detail_screen.dart';

import '../../../Providers/SignIn/sign_in_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/dotted_line.dart';
import '../../../model/res/widgets/input_field.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../../model/services/FirebaseServices/auth_services.dart';
import '../ForgotPasswordScreen/forgot_password_screen.dart';
import '../SignUpScreen/sign_up_screen.dart';
import 'Components/sign_container.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final AuthServices authServices = AuthServices();
  final formKey = GlobalKey<FormState>();

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
                  text: "Sign In", fontSize: 24,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor),
            ),
            SizedBox(height: height2,),
            const Center(
              child: TextWidget(
                  text: "Access your account securely. Sign in to manage"
                      " your personalized experience.", fontSize: 14,
                  fontWeight: FontWeight.w400, isTextCenter: true,
                  textColor: textColor,maxLines: 2,),
            ),
            SizedBox(height: height2,),
            const TextWidget(
                text: "Email", fontSize: 14,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: textColor,fontFamily: AppFonts.semiBold,),
            SizedBox(height: height1,),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputField(
                    inputController: signInP.emailC,
                    hintText: "Enter email",
                    type: TextInputType.emailAddress,
                  ),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "Password", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor,fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height1,),
                  Consumer<SignInProvider>(
                    builder: (context, value, child) {
                      return InputField(
                        inputController: value.passwordC,
                        hintText: "Enter password",
                        obscureText: value.isSignInPasswordShow,
                        suffixIcon: InkWell(
                          onTap: () {
                            value.showSignInPassword();
                          },
                          child: Icon(
                            value.isSignInPasswordShow ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },),
                ],
              ),
            ),
            SizedBox(height: height1,),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Get.to(()=>ForgotPasswordScreen());
                },
                child: const TextWidget(
                    text: "Forgot Password?", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: themeColor,fontFamily: AppFonts.semiBold,),
              ),
            ),
            SizedBox(height: height2,),
            Consumer<SignInProvider>(
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
                title: "Sign In",
                press: () async {
                  FocusScope.of(context).unfocus();
                  if(formKey.currentState!.validate()){
                    await value.signIn();
                  }
                  // if(signInP.userType == "Patient"){
                  //   Get.to(()=>PatientBottomNavBar());
                  // }else{
                  //   Get.to(()=>DoctorBottomNavbar());
                  // }

                },);
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
                // SignContainer(
                //     onTap: () {
                //       auth.signOut();
                //     },
                //     image: AppIcons.appleIcon),
                // const SizedBox(width: 20,),
                // const SignContainer(image: AppIcons.facebookIcon),
              ],
            ),
            SizedBox(height: height2,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextWidget(text: "Don’t have an account?", fontSize: 14, fontWeight: FontWeight.w500, isTextCenter: false, textColor: textColor),
                InkWell(
                    onTap: () {
                      if(signInP.userType == "Health Professional"){
                        Get.to(()=>DoctorInfoDetailScreen());
                      }else{
                        Get.to(()=>SignUpScreen());
                      }
                    },
                    child: const TextWidget(
                        text: "Sign Up", fontSize: 14, fontWeight: FontWeight.w400,
                        isTextCenter: false, textColor: themeColor,fontFamily: AppFonts.medium,)),
                const TextWidget(text: "here", fontSize: 14, fontWeight: FontWeight.w500, isTextCenter: false, textColor: textColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
