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
                            text: "Our Legal and Policies outline the terms"
                                " and conditions governing the use of our services."
                                " By accessing or using our platform, you agree to"
                                " abide by these terms, which include but are not"
                                " limited to, user responsibilities, intellectual"
                                " property rights, privacy practices, and dispute"
                                " resolution procedures. We reserve the right to"
                                " update or modify these terms at any time, and your"
                                " continued use of the platform constitutes acceptance"
                                " of any changes. Please review our Legal and Policies"
                                " regularly for updates.",
                              fontSize: 14, fontWeight: FontWeight.w400,
                              isTextCenter: false, textColor: textColor, maxLines: 100,),
                          SizedBox(height: height1,),
                          TextWidget(
                            text: "Changes to the Service and/or Terms:", fontSize: 16.sp,
                            fontWeight: FontWeight.w600, isTextCenter: false,
                            textColor: textColor, fontFamily: AppFonts.semiBold,),
                          SizedBox(height: height2,),
                          const TextWidget(
                            text: "Changes to the Service and/or Terms refers"
                                " to our commitment to continuously improve and"
                                " update our platform to enhance user experience"
                                " and comply with legal requirements. We reserve"
                                " the right to modify or discontinue any aspect of"
                                " the service, including features, functionalities,"
                                " and access levels, at any time without prior notice."
                                " Additionally, we may revise these terms of service"
                                " to reflect changes in our business practices, industry"
                                " standards, or regulatory obligations. Any updates to the"
                                " terms will be effective immediately upon posting on our"
                                " website or app, and your continued use of the service"
                                " constitutes acceptance of the revised terms.\n\n We encourage"
                                " users to review the terms regularly to stay informed"
                                " about any changes. If you do not agree with the updated"
                                " terms, you may discontinue using the service. However,"
                                " continued use of the service following updates indicates"
                                " your acceptance of the modifications.",
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
