import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/SignIn/sign_in_provider.dart';
import 'package:tabibinet_project/Screens/StartScreens/DoctorInfoDetailScreen/doctor_info_detail_screen.dart';
import 'package:tabibinet_project/Screens/StartScreens/SignInScreen/signin_screen.dart';
import 'package:tabibinet_project/Screens/StartScreens/SignUpScreen/sign_up_screen.dart';

import '../../../Providers/translation/translation_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_assets.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import 'Components/account_container.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signP = Provider.of<SignInProvider>(context,listen: false);


    final List<String> _textItems = [
      'Hello, how are you?',
      'Welcome to our app!',
      'Select your preferred language',
    ];

    double height1 = 50.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height1,),
              const Center(
                child: TextWidget(
                    text: "Choose Account Type", fontSize: 24,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor),
              ),
              SizedBox(height: height1,),
              Consumer<SignInProvider>(
                builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AccountContainer(
                      onTap: () {
                        value.setUserType("Patient");
                      },
                      width: 17.w,
                      title: "Patient",
                      image: AppAssets.male,
                      isIcon: value.userType == "Patient",
                      textColor: value.userType == "Patient" ? bgColor : textColor,
                      cardColor: value.userType == "Patient" ? themeColor : bgColor,
                    ),
                    AccountContainer(
                      onTap: () {
                        value.setUserType("Health Professional");
                      },
                      width: 24.w,
                      title: "Health Professional",
                      image: AppAssets.female,
                      isIcon: value.userType == "Health Professional",
                      textColor: value.userType == "Health Professional" ? bgColor : textColor,
                      cardColor: value.userType == "Health Professional" ? themeColor : bgColor,
                    ),
                  ],
                );
              },),
              SizedBox(height: height1,),
              SubmitButton(
                title: "Login",
                press: () async{
                    Get.to(()=>SignInScreen());
              },),
              const SizedBox(height: 10,),
              SubmitButton(
                title: "Register",
                bgColor: bgColor,
                textColor: themeColor,
                press: () {
                  if(signP.userType == "Health Professional"){
                    Get.to(()=> DoctorInfoDetailScreen());
                  }else{
                    Get.to(()=>SignUpScreen());
                  }
                  },),
            ],
          ),
        ),
      ),
    );
  }
}
