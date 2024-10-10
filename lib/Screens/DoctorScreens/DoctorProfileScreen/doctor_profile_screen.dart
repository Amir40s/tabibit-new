import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Providers/Profile/profile_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/app_bottom_sheet.dart';
import '../../../model/res/widgets/image_loader.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/profile_tile.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../PatientScreens/NotificationSetting/notification_setting_screen.dart';
import '../../PatientScreens/TermsAndCondition/terms_and_condition_screen.dart';
import '../../StartScreens/LanguageScreen/language_screen.dart';
import '../../StartScreens/OnboardingScreen/onboarding_screen.dart';
import '../DoctorEditProfile/doctor_edit_profile_screen.dart';
import '../PaymentManagementScreen/payment_management_screen.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Profile"),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(()=>const DoctorEditProfileScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        width: 100.w,
                        decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child:Row(
                          children: [
                            Consumer<ProfileProvider>(
                              builder: (context, value, child) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                          color: greyColor,
                                          shape: BoxShape.circle
                                      ),
                                      child: ImageLoaderWidget(imageUrl: value.profileUrl)
                                    // value.image != null ? Image.file(
                                    //   value.image!,
                                    //   fit: BoxFit.cover,)
                                    //     : const SizedBox(),
                                  ),
                                );
                              },),
                            const SizedBox(width: 10,),
                            Consumer<ProfileProvider>(
                              builder: (context, value, child) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: value.name, fontSize: 20,
                                      fontWeight: FontWeight.w600, isTextCenter: false,
                                      textColor: bgColor, fontFamily: AppFonts.medium,
                                    ),
                                    const SizedBox(height: 10,),
                                    TextWidget(
                                        text: value.phoneNumber, fontSize: 16,
                                        fontWeight: FontWeight.w400, isTextCenter: false,
                                        textColor: bgColor
                                    ),
                                  ],
                                );
                              },),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: bgColor,
                                  shape: BoxShape.circle
                              ),
                              child: const Icon(Icons.edit_outlined,size: 20,color: themeColor,),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    ProfileTile(
                      title: "Personal Info",
                      icon: AppIcons.profileIcon,
                      iconBgColor: secondaryGreenColor,
                      iconColor: themeColor,
                      onTap: () {
                        Get.to(()=>const DoctorEditProfileScreen());
                      },),
                    ProfileTile(
                      title: "Notification",
                      icon: AppIcons.bellIcon,
                      iconBgColor: secondaryGreenColor,
                      iconColor: themeColor,
                      onTap: () {
                        Get.to(()=>NotificationSettingScreen());
                      },),
                    ProfileTile(
                      title: "Privacy",
                      icon: AppIcons.privacyIcon,
                      iconBgColor: secondaryGreenColor,
                      iconColor: themeColor,
                      onTap: () {
                        Get.to(()=>TermsAndConditionScreen());
                      },),
                    ProfileTile(
                      title: "Payment management",
                      icon: AppIcons.walletIcon,
                      iconBgColor: secondaryGreenColor,
                      iconColor: themeColor,
                      onTap: () {
                        Get.to(()=>PaymentManagementScreen());
                      },),
                    ListTile(
                      onTap: () {
                        Get.to(()=>LanguageScreen(isNextButton: false,));
                      },
                      minTileHeight: 70,
                      title:  TextWidget(
                        text: "Language", fontSize: 18,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.semiBold,),
                      leading: Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                            color: secondaryGreenColor,
                            shape: BoxShape.circle
                        ),
                        child: Image.asset(AppIcons.languageIcon),
                      ),
                      trailing: const Icon(CupertinoIcons.forward,color: textColor,),
                    ),
                    ProfileTile(
                      title: "Logout",
                      icon: AppIcons.groupIcon,
                      iconBgColor: redColor.withOpacity(0.1),
                      iconColor: redColor,
                      onTap: () {
                        Get.bottomSheet(
                            AppBottomSheet(
                              height: 45.h,
                              width: 100.w,
                              title: "Log Out",
                              subTitle: "Are you sure you want to log out",
                              primaryButText: "Logout",
                              secondaryButText: "Cancel",
                              primaryButTap: () {
                                auth.signOut()
                                    .whenComplete(() {

                                  Get.offAll(()=>OnboardingScreen());
                                },);
                              },
                            )
                        );
                      },),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
