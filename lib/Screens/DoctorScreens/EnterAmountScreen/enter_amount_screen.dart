import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/SuccessScreen/success_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/input_field.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

class EnterAmountScreen extends StatelessWidget {
  EnterAmountScreen({super.key});

  final amountC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
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
                            text: "dhs 1340.56", fontSize: 14.sp,
                            fontWeight: FontWeight.w500, isTextCenter: false,
                            textColor: themeColor),
                      ],
                    ),
                    SizedBox(height: height1,),
                    SubmitButton(
                      title: "Continue",
                      press: () {
                        Get.to(()=>const SuccessScreen(
                          title: "Transaction Successful",
                          subTitle: "Your withdrawal has been successfully down\n\nTotal Withdrawn",
                          title3: "100 dhs",
                        ));
                      },)
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
