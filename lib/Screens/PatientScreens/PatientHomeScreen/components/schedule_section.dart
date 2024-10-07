import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/PatientScreens/PatientHomeScreen/components/schedule_container.dart';

import '../../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../../constant.dart';
class ScheduleSection extends StatelessWidget {
  ScheduleSection({super.key});

  final List<String> scheduleData = ["Slide 1", "Slide 2", "Slide 3"];
  final CarouselSliderController _carouselController = CarouselSliderController();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: scheduleData.map((data) {
            return Builder(
              builder: (BuildContext context) {
                return const ScheduleContainer();
              },
            );
          }).toList(),
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 15.h,
            initialPage: 0,
            viewportFraction: 0.85,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              Provider.of<PatientHomeProvider>(context,listen: false).setIndex(index);
            },
          ),
        ),
        const SizedBox(height: 16.0),
        Consumer<PatientHomeProvider>(
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: scheduleData.map((data) {
                int index = scheduleData.indexOf(data);
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
            );
          },
        ),
      ],
    );
  }
}
