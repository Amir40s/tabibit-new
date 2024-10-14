import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/Profile/profile_provider.dart';
import 'package:tabibinet_project/Providers/bankDetails/bank_details_provider.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';

import '../../../model/data/withdraw_request.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../WithDrawScreen/with_draw_screen.dart';

class PaymentManagementScreen extends StatelessWidget {
  const PaymentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    final profileP = Provider.of<ProfileProvider>(context,listen: false);
    profileP.getSelfInfo();
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: ListView(
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
                          text: "${profileP.balance} MAD", fontSize: 24.sp,
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
                              text: "${profileP.balance} MAD", fontSize: 23.sp,
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
                          text: "${profileP.balance} MAD", fontSize: 24.sp,
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
        Consumer<BankDetailsProvider>(
          builder: (context, provider, child) {
            return StreamBuilder<List<WithdrawRequest>>(
              stream: provider.getWithdrawRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No withdrawal requests found'));
                }

                final requests = snapshot.data!;


                return ListView.builder(
                  itemCount: requests.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return   PaymentTile(
                      model: request,
                    );
                  },
                );
              },
            );
          },
        ),
          ],
        ),
      ),
    );
  }
}

class PaymentTile extends StatelessWidget {
  final WithdrawRequest model;
  const PaymentTile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    double height = 10.0;
    String formattedDate = DateFormat('MMM dd, yyyy').format(model.timestamp);
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: secondaryGreenColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child:  Icon(
              model.type == "approved" ?
              CupertinoIcons.arrow_up_right : CupertinoIcons.arrow_down_left,color: greenColor,size: 30,),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                  text: model.type,
                  fontSize: 18.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: textColor),
              TextWidget(
                  text: formattedDate,
                  fontSize: 12.sp, fontWeight: FontWeight.w400,
                  isTextCenter: false, textColor: Colors.grey),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                  text: "Amount Status: ${model.status}",
                  fontSize: 14.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: Colors.grey),
              TextWidget(
                  text: "${model.amount} MAD",
                  fontSize: 16.sp, fontWeight: FontWeight.w600,
                  isTextCenter: false, textColor: greenColor),
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
            text: "Payment Management", fontSize: 19.sp,
            fontWeight: FontWeight.w600, isTextCenter: false,
            textColor: bgColor,fontFamily: AppFonts.semiBold,),
        ],
      ),
    );
  }
}
