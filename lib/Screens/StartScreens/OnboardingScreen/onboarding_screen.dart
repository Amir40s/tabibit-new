import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/Language/language_provider.dart';
import 'package:tabibinet_project/Providers/Onboard/onboard_provider.dart';
import 'package:tabibinet_project/Screens/StartScreens/LanguageScreen/language_screen.dart';
import 'package:tabibinet_project/model/res/constant/app_assets.dart';

import '../../../constant.dart';
import '../../../model/res/widgets/text_widget.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final List<Map<String, String>> onboardingData = [
    {
      'text1': "Expert Doctor ",
      'text2': 'Advice Online',
      'text3': 'Access top-tier medical expertise from the comfort of your home. Our platform connects you with specialized doctors for personalized advice and care, anytime, anywhere.',
    },
    {
      'text1': "Doctor Support, Always",
      'text2': 'Ready',
      'text3': "Our dedicated doctors are here to support you 24/7. Whether it's a simple consultation or urgent advice, you can count on us to be there when you need it most.",
    },
    {
      'text1': "Stay Healthy,",
      'text2': 'Stay Connected',
      'text3': "Your health is our priority. Stay connected with your healthcare providers and maintain your well-being through seamless, continuous care and support.",
    },
  ];

  final List<String> onboardingImages = [
    AppAssets.onboard_6,
    AppAssets.onboard_1,
    AppAssets.onboard_3,
    AppAssets.onboard_4,
    AppAssets.onboard_5,
    AppAssets.onboard_2,
    AppAssets.onboard_7,
  ];

  final List<String> onboardingImages2 = [
    AppAssets.onboard_7,
    AppAssets.onboard_5,
    AppAssets.onboard_2,
    AppAssets.onboard_4,
    AppAssets.onboard_5,
    AppAssets.onboard_1,
    AppAssets.onboard_6,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 47.w,
                    height: 100.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: onboardingImages.length,
                      itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        height: 200,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(onboardingImages[index],fit: BoxFit.cover,)),
                      );
                    },),
                  ),
                  SizedBox(
                    width: 47.w,
                    height: 100.h,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: onboardingImages2.length,
                      itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        height: 200,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(onboardingImages2[index],fit: BoxFit.cover,)),
                      );
                    },),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              width: 100.w,
              decoration: const BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))
              ),
              child: Consumer<OnboardProvider>(builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 7,
                      width: 60,
                      decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: Consumer<LanguageProvider>(
                        builder: (context, languageP, child) {
                          return RichText(
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: languageP.translate(onboardingData[value.currentIndex]['text1']!),
                                  style: const TextStyle(color: textColor, fontSize: 30,
                                      fontFamily: "Regular",fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text: languageP.translate(onboardingData[value.currentIndex]['text2']!),
                                      style: const TextStyle(color: themeColor, fontSize: 30,
                                          fontFamily: "Regular",fontWeight: FontWeight.w600),),
                                  ]
                              ));
                        },),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: TextWidget(
                        text: onboardingData[value.currentIndex]['text3']!,
                        fontSize: 16, fontWeight: FontWeight.normal,
                        isTextCenter: true, textColor: textColor,maxLines: 6,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: onboardingData.map((data) {
                        int index = onboardingData.indexOf(data);
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                          height: 6.0,
                          width: value.currentIndex == index ? 25.0 : 6.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: value.currentIndex == index
                                ? themeColor
                                : greyColor,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(()=>LanguageScreen(isNextButton: true,));
                          },
                          child: const TextWidget(
                              text: "Skip", fontSize: 14,fontFamily: "Medium",
                              fontWeight: FontWeight.normal, isTextCenter: false, textColor: themeColor),
                        ),
                        InkWell(
                          onTap: () {
                            if(value.currentIndex < 2){
                              value.setCurrentIndex();
                            }else{
                              Get.to(()=>LanguageScreen(isNextButton: true,));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                                color: themeColor,
                                shape: BoxShape.circle
                            ),
                            child: const Icon(
                              CupertinoIcons.forward,
                              color: bgColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              },),
            )
          ],
        ),
      ),
    );
  }
}