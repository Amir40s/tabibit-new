import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';

import '../../../../../constant.dart';
import '../../../../../model/res/constant/app_fonts.dart';
import '../../../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../../../model/res/widgets/text_widget.dart';
import '../../../../model/res/constant/app_icons.dart';
import '../../AddCardScreen/add_card_screen.dart';
import '../../PaymentScreen/payment_screen.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    final languageP = Provider.of<TranslationProvider>(context);
    return Consumer<PatientHomeProvider>(
      builder: (context, value, child) {
        return GridView(
          shrinkWrap:true,
          padding: const EdgeInsets.symmetric(vertical: 10),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 160,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20
          ),
         children: [
           // PaymentContainer(
           //   image: AppIcons.paypalIcon,
           //   text: languageP.translatedTexts["Paypal"] ?? "Paypal",
           //   isSelected: false,
           //   onTap: () {
           //
           // },),
           // PaymentContainer(
           //   image: AppIcons.payoneerIcon,
           //   text: "Payoneer",
           //   isSelected: false,
           //   onTap: () {
           //
           //   },),
           PaymentContainer(
             image: AppIcons.bankIcon,
             text: languageP.translatedTexts["Bank Transfer"] ?? "Bank Transfer",
             isSelected: false,
             onTap: () {

             },),
           PaymentContainer(
             image: AppIcons.masterCardIcon,
             text: languageP.translatedTexts["Mastercard"] ?? "Mastercard",
             isSelected: true,
             onTap: () {

             },),
           // PaymentContainer(
           //   image: AppIcons.codeIcon,
           //   text: "Payment Through Code",
           //   isSelected: true,
           //   onTap: () {
           //     Get.to(()=>const PaymentScreen());
           //   },),
           // GestureDetector(
           //   onTap: () {
           //     Get.to(()=>AddCardScreen());
           //   },
           //   child: Container(
           //     decoration: BoxDecoration(
           //       color: bgColor,
           //       borderRadius: BorderRadius.circular(12),
           //       border: Border.all(
           //           color: greyColor
           //       ),
           //     ),
           //     child: Column(
           //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           //       crossAxisAlignment: CrossAxisAlignment.center,
           //       children: [
           //         Container(
           //           padding: const EdgeInsets.all(10),
           //           decoration: const BoxDecoration(
           //               shape: BoxShape.circle,
           //               color: themeColor,
           //               boxShadow: [
           //                 BoxShadow(
           //                     color: Colors.grey,
           //                     blurRadius: 1
           //                 )
           //               ]
           //           ),
           //           child: const Center(child: Icon(Icons.add,color: bgColor,)),
           //         ),
           //         const TextWidget(
           //           text: "Add Card", fontSize: 14,
           //           fontWeight: FontWeight.w600, isTextCenter: true,
           //           textColor: themeColor, fontFamily: AppFonts.semiBold,
           //           maxLines: 2,
           //         ),
           //       ],
           //     ),
           //   ),
           // ),
         ],
        );
      },
    );
  }
}

class PaymentContainer extends StatelessWidget {
  const PaymentContainer({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });
  
  final String text;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: greyColor
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1
                  )
                ]
              ),
              child: Image.asset(image),
            ),
            TextWidget(
              text: text, fontSize: 16,
              fontWeight: FontWeight.w400, isTextCenter: true,
              textColor: textColor, fontFamily: AppFonts.regular,
              maxLines: 2,
            ),
            SizedBox(
              height: 25,
              child: SvgPicture.asset(isSelected? AppIcons.radioOnIcon : AppIcons.radioOffIcon),
            ),
          ],
        ),
      ),
    );
  }
}
