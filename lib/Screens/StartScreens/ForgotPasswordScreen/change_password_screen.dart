import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/actionProvider/forgot_provider.dart';
import 'package:tabibinet_project/model/res/widgets/input_field.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../../../../constant.dart';
import '../../../Providers/actionProvider/actionProvider.dart';
import '../../../model/res/constant/app_utils.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../SuccessScreen/success_screen.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final forgotProvider =  Provider.of<ForgotProvider>(context,listen: false);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: 2.w
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h,),
               const TextWidget(
                  text: "Create New Password",
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 1.h,),
               const TextWidget(
                  text: "Please enter and confirm your new password.You will need to login after you reset.",
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),

                SizedBox(height: 3.h,),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 4.w
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.5.h,),
                     const TextWidget(
                        text: "Password",
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        align: TextAlign.start,
                      ),
                      SizedBox(height: 1.h,),
                      Consumer<ForgotProvider>(
                        builder: (context, provider, child){
                          return InputField(
                            hintText: "Password",
                            inputController: password,
                            // controller: passwordController,
                            suffixIcon: InkWell(
                              onTap: () {
                                provider.togglePasswordVisibility();
                              },
                              child: (provider.isPasswordVisible)
                                  ? const Icon(
                                Icons.visibility,
                                color: themeColor,
                              )
                                  : const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            obscureText: !provider.isPasswordVisible,
                            validator: (password) {
                              if (password!.isNotEmpty) {
                                return AppUtils().passwordValidator(password);
                              } else {
                                return 'Required';
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: 4.h,),
                      TextWidget(
                        text: "Confirm Password",
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        align: TextAlign.start,
                      ),
                      SizedBox(height: 1.h,),
                      Consumer<ForgotProvider>(
                        builder: (context, provider, child){
                          return InputField(
                            inputController: confirmPassword,
                            hintText: "Confirm Password",
                            // controller: passwordController,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                provider.togglePasswordConfirmVisibility();
                              },
                              child: (provider.isPasswordConfirmVisible)
                                  ? const Icon(
                                Icons.visibility,
                                color: themeColor,
                              )
                                  : const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            obscureText: !provider.isPasswordConfirmVisible,
                            validator: (password) {
                              if (password!.isNotEmpty) {
                                return AppUtils().passwordValidator(password);
                              } else {
                                return 'Required';
                              }
                            },
                          );
                        },
                      ),

                      SizedBox(height: 10.h,),
                      Consumer<ActionProvider>(
                       builder: (context,provider,child){
                         return
                           provider.isLoading ?
                           const Center(child: CircularProgressIndicator(color: themeColor,),)
                               : SubmitButton(
                             width: 90.w,
                             title: "Reset Password",
                             press: () async{


                               if(password.text.toString() == confirmPassword.text.toString()){
                                 ActionProvider().startLoading();
                                 await forgotProvider.changePassword(newPassword: password.text.toString());
                                 ActionProvider().stopLoading();
                                 Get.to(()=> SuccessScreen(
                                   title: "Reset Successfully!",
                                   subTitle: "Your password has been reset successfully."
                                       "Please login with new credentials.",
                                 ));
                               }else{
                                 ToastMsg().toastMsg("Password does not match");
                               }
                             });
                       },
                      ),
                      SizedBox(height: 8.h,),
                      _circleIcon(),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  _circleIcon(){
    return GestureDetector(
      onTap: (){
        Get.back();
      },
      child: Align(
        alignment: AlignmentDirectional.center,
        child: Container(
          width: 15.w,
          height: 15.w,
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5.0,
                  offset: const Offset(0.0, 2.0),
                )
              ]
          ),
          child: const Center(child: Icon(Icons.close,color: Colors.red,),),
        ),
      ),
    );
  }
}
