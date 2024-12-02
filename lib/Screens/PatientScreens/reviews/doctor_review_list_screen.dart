import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/data/review_model.dart';
import 'package:tabibinet_project/model/data/user_model.dart';
import 'package:tabibinet_project/model/res/constant/app_assets.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../Providers/stream/stream_data_provider.dart';

class DoctorReviewListScreen extends StatelessWidget {
  final UserModel model;
  const DoctorReviewListScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: themeColor,
        centerTitle: true,
        leading: GestureDetector(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.keyboard_backspace_rounded,color: Colors.white,)),
        title: const TextWidget(
            text: "Review",
            fontSize: 18.0,
            textColor: Colors.white,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 2.w,),
              Consumer<StreamDataProvider>(
                builder: (context, provider, child) {
                  return StreamBuilder<List<ReviewModel>>(
                    stream:  provider.getDoctorReviews(docId: model.userUid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No reviews found'));
                      }
        
                      List<ReviewModel> reviewList = snapshot.data!;
                      log("Length of reviews is:: ${snapshot.data!.length}");
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8.0),
                        itemCount: reviewList.length,
                        itemBuilder: (ctx, index) {
                          ReviewModel review = reviewList[index];
                          return _reviewBox(
                            model: review
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reviewBox({required ReviewModel model}){
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2.0,
            blurRadius: 5.0,
          )
        ],
      ),
      margin: EdgeInsets.all(2.w),
      padding: EdgeInsets.all(4.w),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Row(
               children: [
                 CircleAvatar(
                   child: SvgPicture.asset(AppAssets.male),
                 ),
                 SizedBox(width: 1.w,),
                 TextWidget(
                     text: model.name,
                     fontSize: 14.0,
                     fontWeight: FontWeight.bold,
                 ),
               ],
             ),

             RatingStars(
               value: double.tryParse(model.rating) ?? 0.0,
               starBuilder: (index, color) => Icon(
                 Icons.star,
                 color: color,
                 size: 24.0,
               ),
               starCount: 5,
               starSize: 24,
               valueLabelColor: const Color(0xff9b9b9b),
               maxValue: 5,
               starSpacing: 2,
               starOffColor: const Color(0xffe7e8ea),
               starColor: Colors.blue,
             )
           ],
         ),
          SizedBox(height: 2.w,),
         const TextWidget(text: "Review:", fontSize: 14.0,fontWeight: FontWeight.bold,),
          SizedBox(height: 1.w,),
          TextWidget(text: model.comment, fontSize: 12.0,textColor: Colors.grey,)
        ],
      ),
    );
  }

}
