import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Providers/PayWall/paywall_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/text_widget.dart';
import 'advance_plan_screen.dart';
import 'free_plan_screen.dart';
import 'premium_plan_screen.dart';

class PaywallScreen extends StatelessWidget {
  PaywallScreen({super.key});

  final List<Map<String, String>> tabs = [
    {'title': 'Basic'},
    {'title': 'Premium'},
    {'title': 'Advance'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: ListView(
          children: [
            const SizedBox(height: 50,),
            Center(
              child: SizedBox(
                height: 70,
                child: Consumer<PaywallProvider>(
                  builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: tabs.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final isSelected = provider.currentIndex == index;
                      return GestureDetector(
                        onTap: () {
                          provider.setIndex(index);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                          height: 30,
                          width: 25.w,
                          decoration: BoxDecoration(
                              color: isSelected? themeColor : bgColor,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                  color: themeColor
                              )
                          ),
                          child: Center(
                            child: TextWidget(text: tabs[index]['title']!, fontSize: 16,
                              fontWeight: FontWeight.w500, isTextCenter: false,
                              textColor: isSelected? bgColor : themeColor ,fontFamily: AppFonts.medium,),
                          ),
                        ),
                      );
                    },);
                },
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Consumer<PaywallProvider>(
              builder: (context, screenIndexProvider, child) {
                return IndexedStack(
                  index: screenIndexProvider.currentIndex,
                  children: const [
                    FreePlanScreen(),
                    PremiumPlanScreen(),
                    AdvancePlanScreen(),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

