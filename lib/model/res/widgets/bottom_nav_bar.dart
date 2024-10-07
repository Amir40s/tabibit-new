import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Providers/BottomNav/bottom_navbar_provider.dart';

import '../../../constant.dart';
import '../constant/app_icons.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<BottomNavBarProvider>(context);

    return BottomAppBar(
      color: themeColor,
      height: 100,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: SizedBox(
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(context, AppIcons.bottom_1, 0),
            buildNavItem(context, AppIcons.bottom_2, 1),
            const SizedBox(width: 48), // Space for FAB
            buildNavItem(context, AppIcons.bottom_3, 2),
            buildNavItem(context, AppIcons.bottom_4, 3),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(BuildContext context, String icon, int index) {
    final provider = Provider.of<BottomNavBarProvider>(context);
    final isSelected = provider.currentIndex == index;

    return GestureDetector(
      onTap: () {
        provider.setIndex(index);
        debugPrint(index.toString());
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? textColor : bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          icon,
          color: isSelected ? bgColor : themeColor,
          height: 15,
        ),
      ),
    );
  }
}

class CustomBottomNavBar2 extends StatelessWidget {
  const CustomBottomNavBar2({super.key});

  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      color: themeColor,
      height: 100,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: SizedBox(
        height: 70.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(context, AppIcons.bottom_5, 0),
            buildNavItem(context, AppIcons.bottom_6, 1),
            buildNavItem(context, AppIcons.bottom_7, 2),
            buildNavItem(context, AppIcons.chat, 3),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(BuildContext context, String icon, int index) {
    final provider = Provider.of<BottomNavBarProvider>(context);
    final isSelected = provider.currentIndex == index;

    return GestureDetector(
      onTap: () {
        provider.setIndex(index);
        debugPrint(index.toString());
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? textColor : bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(isSelected ? bgColor : themeColor, BlendMode.srcIn),
          height: 15,
        ),
      ),
    );
  }
}
