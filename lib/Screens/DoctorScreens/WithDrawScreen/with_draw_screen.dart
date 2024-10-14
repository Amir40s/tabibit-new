import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../../../Providers/bankDetails/bank_details_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../bankDetail/add_bank_details_screen.dart';
import '../EnterAmountScreen/enter_amount_screen.dart';

class WithDrawScreen extends StatelessWidget {
  const WithDrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    final provider = Provider.of<BankDetailsProvider>(context);

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
                  TextWidget(
                    text: "Payment Methods",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    isTextCenter: false,
                    textColor: textColor,
                    fontFamily: AppFonts.semiBold,
                  ),
                  SizedBox(height: height1),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(auth.currentUser?.uid.toString())
                        .collection('bankDetails')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final bankDetails = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: bankDetails.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final bankDetail = bankDetails[index];
                          final bankDetailId = bankDetail.id;
                          final bankData = bankDetail.data() as Map<String, dynamic>;

                          final bool isSelected =
                              provider.selectedBankDetailId == bankDetailId;

                          final String type = bankData['type'];

                          return GestureDetector(
                            onTap: () {
                              provider.setSelectedBankDetail(bankDetailId);
                            },
                            child: _bankAccount(
                              type: type == "Bank Account" ? "Bank Account" : "Credit/Debit",
                              accountNumber: type == "Bank Account"
                                  ? bankData['accountNumber']
                                  : bankData["cardNumber"],
                              isSelected: isSelected,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: height1),
                  _buildAddNewAccountSection(height2),
                  const SizedBox(height: 50),
                  SubmitButton(
                    title: "Continue",
                    press: () {
                      if(provider.selectedBankDetailId !=null){
                        Get.to(() =>  EnterAmountScreen());
                      }else{
                        ToastMsg().toastMsg("Please select a Bank");
                      }
                    },
                  ),
                  SizedBox(height: height1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Add new withdrawal account section
  Widget _buildAddNewAccountSection(double height2) {
    return GestureDetector(
      onTap: (){
        Get.to(() =>  AddBankDetailsScreen());
      },
      child: Container(
        width: 100.w,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: greyColor),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: themeColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add_rounded, color: bgColor),
            ),
            SizedBox(height: height2),
            TextWidget(
              text: "Add new withdrawal account",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              isTextCenter: false,
              textColor: themeColor,
              fontFamily: AppFonts.semiBold,
            ),
          ],
        ),
      ),
    );
  }

  // Bank account widget
  Widget _bankAccount({required String accountNumber, required String type, required bool isSelected}) {
    return Container(
      margin: EdgeInsets.only(bottom: 3.w),
      decoration: BoxDecoration(
        color: isSelected ? themeColor.withOpacity(0.1) : bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? themeColor : Colors.grey, // Change border color
        ),
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          AppIcons.payment_2,
        ),
        title: TextWidget(
          text: type,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          isTextCenter: false,
          textColor: textColor,
        ),
        subtitle: TextWidget(
          text: accountNumber,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          isTextCenter: false,
          textColor: textColor,
        ),
        trailing: SvgPicture.asset(
          isSelected ? AppIcons.radioOnIcon : AppIcons.radioOffIcon,
          colorFilter: const ColorFilter.mode(themeColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}
