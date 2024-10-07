import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../EnterAmountScreen/enter_amount_screen.dart';

class WithDrawScreen extends StatelessWidget {
  const WithDrawScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double height1 = 20.0;
    double height2 = 10.0;

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(text: "Withdraw Payments"),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: height1),
                    const TextWidget(
                      text: "Payment Methods", fontSize: 20,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,),
                    SizedBox(height: height1),
                    Container(
                      decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: themeColor
                          )
                      ),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          AppIcons.payment_1,
                        ),
                        title: TextWidget(
                            text: "Credit / Debit Card", fontSize: 16.sp,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: textColor),
                        subtitle: TextWidget(
                            text: "1234 **** **** 1234", fontSize: 14.sp,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: textColor),
                        trailing: SvgPicture.asset(
                          AppIcons.radioOffIcon,
                          colorFilter: const ColorFilter.mode(themeColor, BlendMode.srcIn),),
                      ),
                    ),
                    SizedBox(height: height1),
                    Container(
                      decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: themeColor
                          )
                      ),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          AppIcons.payment_2,
                        ),
                        title: TextWidget(
                            text: "Bank Account", fontSize: 16.sp,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: textColor),
                        subtitle: TextWidget(
                            text: "1234 **** **** 1234", fontSize: 14.sp,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: textColor),
                        trailing: SvgPicture.asset(
                          AppIcons.radioOnIcon,
                          colorFilter: const ColorFilter.mode(themeColor, BlendMode.srcIn),),
                      ),
                    ),
                    SizedBox(height: height1),
                    Container(
                      width: 100.w,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: greyColor
                          )
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: themeColor,
                                shape: BoxShape.circle
                            ),
                            child: const Icon(Icons.add_rounded,color: bgColor,),
                          ),
                          SizedBox(height: height2,),
                          const TextWidget(
                            text: "Add new withdrawal account", fontSize: 16,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: themeColor, fontFamily: AppFonts.semiBold,),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    SubmitButton(
                      title: "Continue",
                      press: () {
                        Get.to(()=>EnterAmountScreen());
                      },),
                    SizedBox(height: height1),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}

//Row(
//                         children: [

//                           SizedBox(width: height2,),
//                           SizedBox(
//                             width: 60.w,
//                             child: ,
//                           ),
//                           const Spacer(),

//                         ],
//                       )