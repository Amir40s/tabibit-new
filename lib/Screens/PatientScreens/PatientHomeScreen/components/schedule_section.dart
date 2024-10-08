import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/schedule/schedule_provider.dart';
import '../../../../constant.dart';
import '../../../../model/data/schedule_model.dart';
import 'schedule_container.dart'; // Import your ScheduleContainer
import '../../../../Providers/PatientHome/patient_home_provider.dart';

class ScheduleSection extends StatelessWidget {
   ScheduleSection({super.key});

  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {

    // final provider = Provider.of<ScheduleProvider>(context);

    return StreamBuilder<List<ScheduleItem>>(
      stream: Provider.of<ScheduleProvider>(context).schedules, // Use the stream from provider
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
    
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        }
    
    
        // Check if data has changed to avoid unnecessary updates
        if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
          // Update cached schedule data
          // scheduleData = snapshot.data!;
        } else {
          return const Center(child: Text('No schedules available'));
        }
    
        // final scheduleData = snapshot.data!;
    
        // log("Length:: ${scheduleData.length}");
        final List<ScheduleItem> scheduleData = snapshot.data!;
    
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: scheduleData.length,
              itemBuilder: (context, index, realIndex) {
                final scheduleItem = scheduleData[index];
                return ScheduleContainer(
                  data: scheduleItem.title,
                  subtitle: scheduleItem.description, // Use the correct property
                  image: scheduleItem.imageUrl, // Use the correct property
                );
              },
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 15.h,
                initialPage: 0,
                autoPlay: true,
                viewportFraction: 0.85,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  // final provider = Provider.of<ScheduleProvider>(context, listen: false);
                  // if (provider.currentIndex != index) {
                  //   provider.setIndex(index);
                  // }
                },
                enableInfiniteScroll: false,
                // onScrolled: (value) {
                //   if (value == null || value.isNegative || value >= scheduleData.length) {
                //     // Prevent scrolling beyond the last item
                //     _carouselController.jumpToPage(scheduleData.length - 1);
                //   }
                // },
    
              ),
            ),
            const SizedBox(height: 16.0),
            // Consumer<ScheduleProvider>(
            //   builder: (context,provider, child){
            //     return  Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: scheduleData.map((data) {
            //         int index = scheduleData.indexOf(data);
            //         return AnimatedContainer(
            //           duration: const Duration(milliseconds: 300),
            //           margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
            //           height: 6.0,
            //           width:  provider.currentIndex == index ? 25.0 : 6.0,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color:  provider.currentIndex == index ? themeColor : greyColor,
            //           ),
            //         );
            //       }).toList(),
            //     );
            //   },
            // ),
          ],
        );
      },
    );
  }
}
