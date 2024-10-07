import 'package:flutter/material.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/input_field.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height1 = 10.0;
    double height2 = 30.0;
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
            InputField(
              inputController: emailC,
              hintText: "Enter email",
            ),
            const SizedBox(height: 120,),
            SubmitButton(
              title: "Send OTP",
              press: () {
                auth.sendPasswordResetEmail(email: emailC.text.toString())
                    .then((value) {
                      ToastMsg().toastMsg(
                          "We have sent Email to Recover"
                          " your Password, Please Check Email");
                      },)
                    .onError((error, stackTrace) {
                      ToastMsg().toastMsg(error.toString());
                      },);
                // Get.to(()=>OtpScreen());
              },),
          ],
        ),
      ),
    );
  }
}
