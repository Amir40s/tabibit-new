import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/Profile/profile_provider.dart';
import 'package:tabibinet_project/Providers/Favorite/favorite_doctor_provider.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';
import '../../../constant.dart';
import '../DoctorSpecialityScreen/doctor_speciality_screen.dart';
import '../FindDoctorScreen/find_doctor_screen.dart';
import 'components/doctor_section.dart';
import 'components/patient_home_header.dart';
import 'components/schedule_section.dart';
import 'components/speciality_slider_section.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileProvider>().getSelfInfo();
    context.read<FavoritesProvider>().fetchFavoriteDoctors();
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PatientHomeHeader(),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  const _HomeScreenContent(),
                   ScheduleSection(),
                  SizedBox(height: 2.w,),
                  const _SectionHeader(
                    title: "Doctor Speciality",
                    viewAllScreen: DoctorSpecialityScreen(),
                  ),
                  SizedBox(height: 2.w,),
                  const SpecialitySliderSection(),
                  SizedBox(height: 2.w,),
                  _SectionHeader(
                    title: "Top Doctor",
                    viewAllScreen: FindDoctorScreen(),
                  ),
                  SizedBox(height: 2.w,),
                  const DoctorSection(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    final String formattedTime = DateFormat('EEEE, MMMM d').format(DateTime.now());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          TextWidget(
            text: formattedTime,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            isTextCenter: false,
            textColor: textColor.withOpacity(0.5),
            fontFamily: AppFonts.semiBold,
          ),
          const SizedBox(height: 5),
          const TextWidget(
            text: "Let’s Find Your Doctor",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            isTextCenter: false,
            textColor: textColor,
            fontFamily: AppFonts.semiBold,
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => Get.to(() =>  FindDoctorScreen()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _SearchBox(),
                _MenuIcon(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const TextWidget(
            text: "Upcoming Schedule",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            isTextCenter: false,
            textColor: textColor,
            fontFamily: AppFonts.semiBold,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      width: 72.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: greyColor),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: greyColor, size: 24),
          SizedBox(width: 10),
          TextWidget(
            text: 'Find here!',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            isTextCenter: false,
            textColor: greyColor,
            fontFamily: AppFonts.regular,
          ),
        ],
      ),
    );
  }
}

class _MenuIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: themeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SvgPicture.asset(AppIcons.menuIcon),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Widget viewAllScreen;

  const _SectionHeader({
    required this.title,
    required this.viewAllScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          TextWidget(
            text: title,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            isTextCenter: false,
            textColor: textColor,
            fontFamily: AppFonts.semiBold,
          ),
          const Spacer(),
          InkWell(
            onTap: () => Get.to(() => viewAllScreen),
            child: const TextWidget(
              text: "View All",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              isTextCenter: false,
              textColor: themeColor,
              fontFamily: AppFonts.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
