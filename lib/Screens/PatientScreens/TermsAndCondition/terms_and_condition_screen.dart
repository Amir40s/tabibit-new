import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double height1 = 30;
    double height2 = 10;

    final provider = Provider.of<TranslationProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Header(text: "Legal and Policies"),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Theme(
                    data: ThemeData(
                      scrollbarTheme: ScrollbarThemeData(
                        thumbColor: WidgetStateProperty.all(greenColor), // Change the color of the scrollbar thumb here
                        trackColor: WidgetStateProperty.all(greyColor), // Change the track color if needed
                      ),
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,

                      radius: const Radius.circular(20),

                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          SizedBox(height: height2,),
                          TextWidget(
                            text: "Terms", fontSize: 16.sp,
                            fontWeight: FontWeight.w600, isTextCenter: false,
                            textColor: textColor, fontFamily: AppFonts.semiBold,),
                          SizedBox(height: height2,),
                           TextWidget(
                            text: "${provider.translatedTexts["Our Legal and Policies outline the terms"] ?? "Our Legal and Policies outline the terms"}"
                                "${provider.translatedTexts[" and conditions governing the use of our services."] ?? " and conditions governing the use of our services."}"
                                "${provider.translatedTexts[" By accessing or using our platform, you agree to"] ?? " By accessing or using our platform, you agree to"}"
                                "${provider.translatedTexts[" abide by these terms, which include but are not"] ?? " abide by these terms, which include but are not"}"
                                "${provider.translatedTexts[" limited to, user responsibilities, intellectual"] ?? " limited to, user responsibilities, intellectual"}"
                                "${provider.translatedTexts[" property rights, privacy practices, and dispute"] ?? " property rights, privacy practices, and dispute"}"
                                "${provider.translatedTexts[" resolution procedures. We reserve the right to"] ?? " resolution procedures. We reserve the right to"}"
                                "${provider.translatedTexts[" update or modify these terms at any time, and your"] ?? " update or modify these terms at any time, and your"}"
                                "${provider.translatedTexts[" continued use of the platform constitutes acceptance"] ?? " continued use of the platform constitutes acceptance"}"
                                "${provider.translatedTexts[" of any changes. Please review our Legal and Policies"] ?? " of any changes. Please review our Legal and Policies"}"
                                "${provider.translatedTexts[" regularly for updates."] ?? " regularly for updates."}",

                             fontSize: 14, fontWeight: FontWeight.w400,
                              isTextCenter: false, textColor: textColor, maxLines: 100,),
                          SizedBox(height: height1,),
                          TextWidget(
                            text: "Changes to the Service and/or Terms:", fontSize: 16.sp,
                            fontWeight: FontWeight.w600, isTextCenter: false,
                            textColor: textColor, fontFamily: AppFonts.semiBold,),
                          SizedBox(height: height2,),
                           TextWidget(
                            text: "${provider.translatedTexts["Changes to the Service and/or Terms refers"] ?? "Changes to the Service and/or Terms refers"}"
                                "${provider.translatedTexts[" to our commitment to continuously improve and"] ?? " to our commitment to continuously improve and"}"
                                "${provider.translatedTexts[" update our platform to enhance user experience"] ?? " update our platform to enhance user experience"}"
                                "${provider.translatedTexts[" and comply with legal requirements. We reserve"] ?? " and comply with legal requirements. We reserve"}"
                                "${provider.translatedTexts[" the right to modify or discontinue any aspect of"] ?? " the right to modify or discontinue any aspect of"}"
                                "${provider.translatedTexts[" the service, including features, functionalities,"] ?? " the service, including features, functionalities,"}"
                                "${provider.translatedTexts[" and access levels, at any time without prior notice."] ?? " and access levels, at any time without prior notice."}"
                                "${provider.translatedTexts[" Additionally, we may revise these terms of service"] ?? " Additionally, we may revise these terms of service"}"
                                "${provider.translatedTexts[" to reflect changes in our business practices, industry"] ?? " to reflect changes in our business practices, industry"}"
                                "${provider.translatedTexts[" standards, or regulatory obligations. Any updates to the"] ?? " standards, or regulatory obligations. Any updates to the"}"
                                "${provider.translatedTexts[" terms will be effective immediately upon posting on our"] ?? " terms will be effective immediately upon posting on our"}"
                                "${provider.translatedTexts[" website or app, and your continued use of the service"] ?? " website or app, and your continued use of the service"}"
                                "${provider.translatedTexts[" constitutes acceptance of the revised terms. We encourage"] ?? " constitutes acceptance of the revised terms. We encourage"}"
                                "${provider.translatedTexts[" users to review the terms regularly to stay informed"] ?? " users to review the terms regularly to stay informed"}"
                                "${provider.translatedTexts[" about any changes. If you do not agree with the updated"] ?? " about any changes. If you do not agree with the updated"}"
                                "${provider.translatedTexts[" terms, you may discontinue using the service. However,"] ?? " terms, you may discontinue using the service. However,"}"
                                "${provider.translatedTexts[" continued use of the service following updates indicates"] ?? " continued use of the service following updates indicates"}"
                                "${provider.translatedTexts[" your acceptance of the modifications."] ?? " your acceptance of the modifications."}",

                            fontSize: 14, fontWeight: FontWeight.w400,
                            isTextCenter: false, textColor: textColor, maxLines: 100,),
                          const SizedBox(height: 100,),
                        ],
                      ),
                    ),
                  ),
                )
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: themeColor,
          onPressed: () {

        },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: const Icon(Icons.arrow_downward_rounded,color: bgColor,),),
      ),
    );
  }
}
