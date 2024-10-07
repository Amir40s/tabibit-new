import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/api_services/url/baseurl.dart';

import '../../../Providers/Profile/profile_provider.dart';
import '../../../Providers/translation/translation_provider.dart';
import '../../../constant.dart';
import '../../../controller/doctoro_specialiaty_controller.dart';
import '../../../model/puahNotification/push_notification.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/app_bottom_sheet.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/image_loader.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../StartScreens/LanguageScreen/language_screen.dart';
import '../../StartScreens/OnboardingScreen/onboarding_screen.dart';
import '../EditProfileScreen/patient_edit_profile_screen.dart';
import '../HelpAndSupportScreen/help_and_support_screen.dart';
import '../NotificationSetting/notification_setting_screen.dart';
import '../PaymentScreen/payment_screen.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageP = Provider.of<TranslationProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
             Header2(text: languageP.translatedTexts["Profile"] ?? "Profile"),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(()=>const PatientEditProfileScreen());
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
                    ListTile(
                      onTap: () {
                        Get.to(()=>PatientEditProfileScreen());
                      },
                      minTileHeight: 70,
                      title: const TextWidget(
                        text: "Personal Info", fontSize: 18,
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
                        child: SvgPicture.asset(AppIcons.personIcon),
                      ),
                      trailing: const Icon(CupertinoIcons.forward,color: textColor,),
                    ),
                    ListTile(
                      onTap: (){
                        Get.to(()=>const NotificationSettingScreen());
                      },
                      minTileHeight: 70,
                      title: const TextWidget(
                        text: "Notification", fontSize: 18,
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
                        child: SvgPicture.asset(
                            AppIcons.bellIcon,
                            colorFilter: const ColorFilter.mode(
                                themeColor,
                                BlendMode.srcIn
                            )
                        ),
                      ),
                      trailing: const Icon(CupertinoIcons.forward,color: textColor,),
                    ),
                    ListTile(
                      onTap: () async{
                        // Get.to(()=>const PaymentScreen());
                        final fcmService =  FCMService();
                        await fcmService.sendNotification(
                            BaseUrl.ab_deviceToekn,
                            "title",
                            "body",
                            "senderId"
                        );
                      },
                      minTileHeight: 70,
                      title: const TextWidget(
                        text: "Payment", fontSize: 18,
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
                        child: SvgPicture.asset(
                            AppIcons.walletIcon,
                            colorFilter: const ColorFilter.mode(
                            themeColor,
                            BlendMode.srcIn
                        )),
                      ),
                      trailing: const Icon(CupertinoIcons.forward,color: textColor,),
                    ),
                    ListTile(
                      onTap: () {
                        Get.to(()=>LanguageScreen(isNextButton: false,));
                      },
                      minTileHeight: 70,
                      title: const TextWidget(
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
                    ListTile(
                      onTap: () {
                        Get.to(()=>const HelpAndSupportScreen());
                      },
                      minTileHeight: 70,
                      title: const TextWidget(
                        text: "Help Center", fontSize: 18,
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
                        child: SvgPicture.asset(AppIcons.headphoneIcon),
                      ),
                      trailing: const Icon(CupertinoIcons.forward,color: textColor,),
                    ),
                    ListTile(
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
                                    .whenComplete(() async{
                                    await Provider.of<ProfileProvider>(context,listen: false).clearAll();
                                  Get.offAll(()=>OnboardingScreen());
                                },);
                              },
                          )
                        );
                      },
                      minTileHeight: 70,
                      title: const TextWidget(
                        text: "Logout", fontSize: 18,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.semiBold,),
                      leading: Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: redColor.withOpacity(0.1),
                            shape: BoxShape.circle
                        ),
                        child: SvgPicture.asset(
                          AppIcons.groupIcon,
                          colorFilter: const ColorFilter.mode(
                              redColor,
                              BlendMode.srcIn
                          ),),
                      ),
                      trailing: const Icon(CupertinoIcons.forward,color: textColor,),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}