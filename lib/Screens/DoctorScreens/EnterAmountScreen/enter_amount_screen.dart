import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/Profile/profile_provider.dart';
import 'package:tabibinet_project/Providers/bankDetails/bank_details_provider.dart';
import 'package:tabibinet_project/Screens/SuccessScreen/success_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/input_field.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

class EnterAmountScreen extends StatelessWidget {
  EnterAmountScreen({super.key});

  final amountC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    final provider = Provider.of<ProfileProvider>(context,listen: false);
    final bankP = Provider.of<BankDetailsProvider>(context,listen: false);



    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const Header(text: "Withdraw Payments"),
              Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      SizedBox(height: height1,),
                      TextWidget(
                          text: "Enter Amount",
                          fontSize: 16.sp, fontWeight: FontWeight.w500,
                          isTextCenter: false, textColor: textColor),
                      SizedBox(height: height2,),
                      InputField(
                        inputController: amountC,
                        hintText: "Enter amount",
                        type: TextInputType.number,
                      ),
                      SizedBox(height: height2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                              text: "Max ", fontSize: 14.sp,
                              fontWeight: FontWeight.w500, isTextCenter: false,
                              textColor: textColor),
                          TextWidget(
                              text: "MAD 1340.56", fontSize: 14.sp,
                              fontWeight: FontWeight.w500, isTextCenter: false,
                              textColor: themeColor),
                        ],
                      ),
                      SizedBox(height: height1,),
                      SubmitButton(
                        title: "Continue",
                        press: () {
                          if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                            double enterAmount = double.parse(amountC.text.toString());
                            double maxAmount = 1340.0;
                            double balance = double.parse(provider.balance);
                            log("Message Amount:: $enterAmount");
                            log("Message Amount:: $maxAmount");
                            log("Message Amount:: $balance");
                            if(enterAmount > maxAmount){
                              ToastMsg().toastMsg("Please select amount between 0 and $enterAmount");
                            }else{
                              if(enterAmount > balance || enterAmount <= 0){
                                ToastMsg().toastMsg("you have insufficient amount");
                              }else{
                                bankP.submitWithdrawRequest(enterAmount);
                              }
                            }
                          }
                        },
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
