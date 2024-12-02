import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/controller/translation_controller.dart';

import '../../../../../constant.dart';
import '../../../../../model/res/constant/app_fonts.dart';
import '../../../../../model/res/widgets/text_widget.dart';
import '../../../../Providers/translation/translation_provider.dart';
import '../../../../model/data/user_model.dart';
import '../../../../model/res/constant/app_icons.dart';
import '../../reviews/doctor_review_list_screen.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.doctorName,
    required this.specialityName,
    required this.yearsOfExperience,
    required this.patients,
    required this.reviews,
    required this.model,
  });

  final String doctorName;
  final String specialityName;
  final String yearsOfExperience;
  final String patients;
  final String reviews;
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    final languageP = Provider.of<TranslationProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      height: 48.h,
      width: 100.w,
      decoration: const BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextWidget(
                text: "${languageP.translatedTexts["Dr."] ?? "Dr."} $doctorName", fontSize: 20.sp,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: bgColor, fontFamily: AppFonts.semiBold,),
              const Spacer(),
              // Container(
              //   height: 40,
              //   width: 40,
              //   decoration: BoxDecoration(
              //       color: bgColor,
              //       borderRadius: BorderRadius.circular(8)
              //   ),
              //   child: const Icon(CupertinoIcons.suit_heart_fill,color: themeColor,size: 20,),
              // ),
            ],
          ),
          TextWidget(
            text: specialityName, fontSize: 16.sp,
            fontWeight: FontWeight.w400, isTextCenter: false,
            textColor: bgColor,),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: SvgPicture.asset(AppIcons.personIcon, height: 18.sp,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      text: languageP.translatedTexts["Patients"] ?? "Patients", fontSize: 12.sp,
                      fontWeight: FontWeight.w400, isTextCenter: false,
                      textColor: bgColor),
                  TextWidget(
                    text: patients, fontSize: 12.sp,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: bgColor, fontFamily: AppFonts.semiBold,),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: SvgPicture.asset(AppIcons.groupIcon, height: 18.sp,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      text: languageP.translatedTexts["Years experience"] ?? "Years experience", fontSize: 12.sp,
                      fontWeight: FontWeight.w400, isTextCenter: false,
                      textColor: bgColor),
                  TextWidget(
                    text: yearsOfExperience, fontSize: 12.sp,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: bgColor, fontFamily: AppFonts.semiBold,),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: SvgPicture.asset(AppIcons.msgIcon, height: 18.sp,),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(DoctorReviewListScreen(model: model,),transition: Transition.rightToLeft);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        text: languageP.translatedTexts["Reviews"] ?? "Reviews", fontSize: 12.sp,
                        fontWeight: FontWeight.w400, isTextCenter: false,
                        textColor: bgColor),
                    TextWidget(
                      text: "#$reviews", fontSize: 12.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: bgColor, fontFamily: AppFonts.semiBold,),
                  ],
                ),
              )
            ],)
        ],
      ),
    );
  }
}
