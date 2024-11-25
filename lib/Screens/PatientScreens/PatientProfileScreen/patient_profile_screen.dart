import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Providers/Profile/profile_provider.dart';
import '../../../Providers/translation/translation_provider.dart';
import '../../../constant.dart';
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
                  _buildProfileHeader(context),
                  const SizedBox(height: 20),
                  _buildListTile(
                    title: "Personal Info",
                    iconPath: AppIcons.personIcon,
                    onTap: () => Get.to(() => const PatientEditProfileScreen()),
                  ),
                  _buildListTile(
                    title: "Notification",
                    iconPath: AppIcons.bellIcon,
                    onTap: () => Get.to(() => const NotificationSettingScreen()),
                  ),
                  _buildListTile(
                    title: "Language",
                    iconPath: AppIcons.languageIcon,
                    onTap: () => Get.to(() => LanguageScreen(isNextButton: false)),
                    isSvg: false,
                  ),
                  _buildListTile(
                    title: "Help Center",
                    iconPath: AppIcons.headphoneIcon,
                    onTap: () => Get.to(() => const HelpAndSupportScreen()),
                  ),
                  _buildLogoutTile(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => const PatientEditProfileScreen()),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            _buildProfileImage(),
            const SizedBox(width: 10),
            _buildProfileInfo(context),
            const Spacer(),
            _buildEditIcon(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Consumer<ProfileProvider>(
      builder: (context, profile, child) {
        return ClipOval(
          child: Container(
            height: 70,
            width: 70,
            color: greyColor,
            child: ImageLoaderWidget(imageUrl: profile.profileUrl),
          ),
        );
      },
    );
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profile, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: profile.name,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textColor: bgColor,
              fontFamily: AppFonts.medium,
            ),
            const SizedBox(height: 10),
            TextWidget(
              text: profile.phoneNumber,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              textColor: bgColor,
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditIcon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.edit_outlined, size: 20, color: themeColor),
    );
  }

  Widget _buildListTile({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
    bool isSvg = true,
  }) {
    return ListTile(
      onTap: onTap,
      minVerticalPadding: 20,
      title: TextWidget(
        text: title,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        textColor: textColor,
        fontFamily: AppFonts.semiBold,
      ),
      leading: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: secondaryGreenColor,
          shape: BoxShape.circle,
        ),
        child: isSvg
            ? SvgPicture.asset(iconPath)
            : Image.asset(iconPath),
      ),
      trailing: const Icon(CupertinoIcons.forward, color: textColor),
    );
  }

  Widget _buildLogoutTile(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.bottomSheet(
          AppBottomSheet(
            height: 45.h,
            width: 100.w,
            title: "Log Out",
            subTitle: "Are you sure you want to log out?",
            primaryButText: "Logout",
            secondaryButText: "Cancel",
            primaryButTap: () {
              auth.signOut().whenComplete(() async {
                await Provider.of<ProfileProvider>(context, listen: false).clearAll();
                Get.offAll(() => OnboardingScreen());
              });
            },
          ),
        );
      },
      minVerticalPadding: 20,
      title: const TextWidget(
        text: "Logout",
        fontSize: 18,
        fontWeight: FontWeight.w600,
        textColor: textColor,
        fontFamily: AppFonts.semiBold,
      ),
      leading: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: redColor.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          AppIcons.groupIcon,
          colorFilter: const ColorFilter.mode(redColor, BlendMode.srcIn),
        ),
      ),
      trailing: const Icon(CupertinoIcons.forward, color: textColor),
    );
  }
}
