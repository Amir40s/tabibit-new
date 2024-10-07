import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';

import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../WithDrawScreen/with_draw_screen.dart';

class PaymentManagementScreen extends StatelessWidget {
  const PaymentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: greyColor.withOpacity(0.5),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30))
                  ),
                  child: Column(
                    children: [
                      const PaymentHeader(),
                      SizedBox(height: height1,),
                      TextWidget(
                          text: "Your Balance", fontSize: 16.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: bgColor),
                      SizedBox(height: height2,),
                      TextWidget(
                          text: "1340.56 dhs", fontSize: 24.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: bgColor),
                      SizedBox(height: height2,),
                      SubmitButton(
                        title: "Withdraw",
                        bgColor: bgColor,
                        textColor: themeColor,
                        icon: Icons.login_rounded,
                        iconColor: themeColor,
                        press: () {

                        },),
                      SizedBox(height: height1,),
                      SizedBox(height: height1,),
                      TextWidget(
                          text: "This week’s income", fontSize: 18.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: Colors.grey),
                      SizedBox(height: height2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                              text: "746.80 dhs", fontSize: 23.sp,
                              fontWeight: FontWeight.w600, isTextCenter: false,
                              textColor: textColor),
                          const SizedBox(width: 10,),
                          SubmitButton(
                            width: 17.w,
                            height: 35,
                            title: "34%",
                            icon: CupertinoIcons.arrow_up_right,
                            iconColor: bgColor,
                            iconSize: 18,
                            bgColor: const Color(0xff04AD01),
                            press: () {

                          },)
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
                  ),
                  child: Column(
                    children: [
                      const PaymentHeader(),
                      SizedBox(height: height1,),
                      TextWidget(
                          text: "Your Balance", fontSize: 16.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: bgColor),
                      SizedBox(height: height2,),
                      TextWidget(
                          text: "1340.56 dhs", fontSize: 24.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: bgColor),
                      SizedBox(height: height2,),
                      SubmitButton(
                        title: "Withdraw",
                        bgColor: bgColor,
                        textColor: themeColor,
                        icon: Icons.login_rounded,
                        iconColor: themeColor,
                        press: () {
                          Get.to(()=>WithDrawScreen());
                        },)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height1,),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: TextWidget(
                          text: "Oct 26, 2022", fontSize: 16.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: Colors.grey
                      ),
                    ),
                    const PaymentTile(),
                    SizedBox(height: height1,),
                    Center(
                      child: TextWidget(
                          text: "Oct 26, 2022", fontSize: 16.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: Colors.grey
                      ),
                    ),
                    const PaymentTile(),
                    SizedBox(height: height1,),
                    Center(
                      child: TextWidget(
                          text: "Oct 26, 2022", fontSize: 16.sp,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: Colors.grey
                      ),
                    ),
                    SizedBox(height: height1,),
                    const PaymentTile(),
                    SizedBox(height: height1,),
                  ],
            )),
          ],
        ),
      ),
    );
  }
}

class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key});

  @override
  Widget build(BuildContext context) {
    double height = 10.0;
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: secondaryGreenColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: const Icon(CupertinoIcons.arrow_up_right,color: greenColor,size: 30,),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                  text: "Adam Costa",
                  fontSize: 18.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: textColor),
              TextWidget(
                  text: "5:02 PM",
                  fontSize: 12.sp, fontWeight: FontWeight.w400,
                  isTextCenter: false, textColor: Colors.grey),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                  text: "Standard Chartered Bank",
                  fontSize: 14.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: Colors.grey),
              TextWidget(
                  text: "200 dhs",
                  fontSize: 16.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: greenColor),
            ],
          ),
        ),
        SizedBox(height: height,),
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xffFFF4CF),
                borderRadius: BorderRadius.circular(10)
            ),
            child: const Icon(CupertinoIcons.arrow_down_right,color: Color(0xffC39800),size: 30,),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                  text: "Sarah Eric",
                  fontSize: 18.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: textColor),
              TextWidget(
                  text: "5:02 PM",
                  fontSize: 12.sp, fontWeight: FontWeight.w400,
                  isTextCenter: false, textColor: Colors.grey),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                  text: "Payment Received",
                  fontSize: 14.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: Colors.grey),
              TextWidget(
                  text: "200 dhs",
                  fontSize: 16.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: const Color(0xffC39800)),
            ],
          ),
        ),
      ],
    );
  }
}


class PaymentHeader extends StatelessWidget {
  const PaymentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.h,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle
              ),
              child: const Center(child: Icon(CupertinoIcons.back,color: themeColor,size: 24,)),
            ),
          ),
          const SizedBox(width: 15,),
          TextWidget(
            text: "Software Management", fontSize: 19.sp,
            fontWeight: FontWeight.w600, isTextCenter: false,
            textColor: bgColor,fontFamily: AppFonts.semiBold,),
        ],
      ),
    );
  }
}
