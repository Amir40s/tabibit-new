import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/call_data_provider.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/dotted_line.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/input_field.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';

import '../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../PatientBottomNavBar/patient_bottom_nav_bar.dart';

class AppointmentReviewScreen extends StatelessWidget {

  AppointmentReviewScreen({super.key,});

  final descriptionC = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CallDataProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Write a Review"),
            Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  children: [
                    Container(
                  height: 160,
                  width: 160,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.w),
                        child: Image.network(provider.appointments[0].doctorImage),
                      ),
                ),
                    SizedBox(height: 20.sp,),
                     TextWidget(
                  text: "How was your experience with\nDr. ${provider.appointments[0].doctorName}",
                  fontSize: 20, maxLines: 2,
                  fontWeight: FontWeight.w600, isTextCenter: true,
                  textColor: textColor, fontFamily: AppFonts.medium,),
                SizedBox(height: 10.sp,),
                Consumer<CallDataProvider>(
                builder: (context,provider, child){
                  return RatingStars(
                    value: provider.starsRating,
                    onValueChanged: (onChange){
                      log("on Value  Changed: ${onChange}");
                      provider.setStarsRating(onChange);
                    },
                    starBuilder: (index, color) => Icon(
                      Icons.star,
                      color: color,
                      size: 30.0,
                    ),
                    starCount: 5,
                    starSize: 30,
                    valueLabelColor: const Color(0xff9b9b9b),
                    maxValue: 5,
                    starSpacing: 2,
                    animationDuration: Duration(milliseconds: 1000),
                    starOffColor: const Color(0xffe7e8ea),
                    starColor: Colors.yellow,
                  );
                },
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(Icons.star_rounded,color: themeColor,size: 24.sp,),
                //     Icon(Icons.star_rounded,color: themeColor,size: 24.sp,),
                //     Icon(Icons.star_rounded,color: themeColor,size: 24.sp,),
                //     Icon(Icons.star_outline_rounded,color: themeColor,size: 24.sp,),
                //     Icon(Icons.star_outline_rounded,color: themeColor,size: 24.sp,),
                //   ],
                // ),
                SizedBox(height: 20.sp,),
                const DottedLine(color: greyColor, height: 1.5,),
                SizedBox(height: 20.sp,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: "Write Your Review", fontSize: 16,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.medium,
                    ),
                    TextWidget(
                      text: "Max 250 words", fontSize: 12,
                      fontWeight: FontWeight.w400, isTextCenter: false,
                      textColor: textColor,
                    ),
                  ],
                ),
                SizedBox(height: 10.sp,),
                InputField(
                  inputController: descriptionC,
                  hintText: "Tell us about doctor feedback",
                  maxLines: 5,
                ),
                SizedBox(height: 10.sp,),
                 TextWidget(
                  text: "Would you recommended Dr. ${provider.appointments[0].doctorName} to your friends", fontSize: 16,
                  fontWeight: FontWeight.w500, isTextCenter: false, maxLines: 2,
                  textColor: textColor, fontFamily: AppFonts.medium,
                ),
                SizedBox(height: 10.sp,),
                Consumer<PatientHomeProvider>(
                  builder: (context, value, child) {
                  return Row(
                    children: [
                      InkWell(
                          onTap: () {
                            value.selectReview("yes");
                          },
                          child: SvgPicture.asset(value.review == "yes" ? AppIcons.radioOnIcon : AppIcons.radioOffIcon,height: 20.sp,)),
                      SizedBox(width: 10.sp,),
                      const TextWidget(
                        text: "Yes", fontSize: 14,
                        fontWeight: FontWeight.w400, isTextCenter: false,
                        textColor: textColor,
                      ),
                      SizedBox(width: 20.sp,),
                      InkWell(
                          onTap: () {
                            value.selectReview("no");
                          },
                          child: SvgPicture.asset(value.review == "no" ? AppIcons.radioOnIcon : AppIcons.radioOffIcon,height: 20.sp,)),
                      SizedBox(width: 10.sp,),
                      const TextWidget(
                        text: "No", fontSize: 14,
                        fontWeight: FontWeight.w400, isTextCenter: false,
                        textColor: textColor,
                      ),
                    ],
                  );
                },),
              ],
            )
            )
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<CallDataProvider>(
           builder: (context,loadingP,child){
             return loadingP.isLoading ?
             Container(
                 width: 50.w,
                 height: 50.0,
                 child: Center(child: CircularProgressIndicator(color: themeColor)))
             : SubmitButton(
               title: "Submit",
               press: () async{
                 await provider.saveRating(
                     doctorId: provider.appointments[0].doctorId,
                     appointID: provider.appointments[0].id,
                     comment: descriptionC.text.toString()
                 );
                 Get.offAll(()=>const PatientBottomNavBar());
               },);
           },
          ),
        ),
      ),
    );
  }
}
