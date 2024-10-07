import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/Screens/PatientScreens/ContactUs/contact_us_screen.dart';
import 'package:tabibinet_project/Screens/PatientScreens/FaqScreen/faq_screen.dart';
import 'package:tabibinet_project/Screens/PatientScreens/TermsAndCondition/terms_and_condition_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';

import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/dotted_line.dart';
import '../../../model/res/widgets/text_widget.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // double height1 = 20;
    final languageP  = Provider.of<TranslationProvider>(context);
    double height2 = 10;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
             Header(text: "Help and Support"),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: secondaryGreenColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: themeColor)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(()=>FaqScreen());
                    },
                    contentPadding: const EdgeInsets.all(0),
                    title:  TextWidget(
                      text: languageP.translatedTexts["FAQ"] ?? "FAQ", fontSize: 16,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.medium,),
                    trailing: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: themeColor,
                        )
                      ),
                      child: const Icon(CupertinoIcons.forward,color: themeColor,),
                    ),
                  ),
                  SizedBox(height: height2,),
                  const DottedLine(color: greyColor,),
                  SizedBox(height: height2,),
                  ListTile(
                    onTap: (){
                      Get.to(()=>ContactUsScreen());
                    },
                    contentPadding: const EdgeInsets.all(0),
                    title:  TextWidget(
                      text: languageP.translatedTexts["Contact Us"] ?? "Contact Us", fontSize: 16,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.medium,),
                    trailing: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: themeColor,
                          )
                      ),
                      child: const Icon(CupertinoIcons.forward,color: themeColor,),
                    ),
                  ),
                  SizedBox(height: height2,),
                  const DottedLine(color: greyColor,),
                  SizedBox(height: height2,),
                  ListTile(
                    onTap: (){
                      Get.to(()=>TermsAndConditionScreen());
                    },
                    contentPadding: const EdgeInsets.all(0),
                    title:  TextWidget(
                      text: languageP.translatedTexts["Terms & Conditions"] ?? "Terms & Conditions", fontSize: 16,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.medium,),
                    trailing: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: themeColor,
                          )
                      ),
                      child: const Icon(CupertinoIcons.forward,color: themeColor,),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
