import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/widgets/image_loader.dart';

import '../../../../Providers/translation/translation_provider.dart';
import '../../../../constant.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/widgets/dotted_line.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';

class TopDoctorContainer extends StatelessWidget {
  const TopDoctorContainer({
    super.key,
    required this.doctorName,
    required this.specialityName,
    required this.specialityDetail,
    required this.availabilityFrom,
    required this.availabilityTo,
    required this.appointmentFee,
    required this.imageUrl,
    required this.rating,
    required this.isFav,
    required this.isOnline,
    this.onTap,
    this.likeTap,
  });

  final String doctorName;
  final String specialityName;
  final String specialityDetail;
  final String availabilityFrom;
  final String availabilityTo;
  final String appointmentFee;
  final String imageUrl;
  final String rating;
  final bool isFav;
  final bool isOnline;
  final VoidCallback? onTap;
  final VoidCallback? likeTap;

  @override
  Widget build(BuildContext context) {
    final languageP = Provider.of<TranslationProvider>(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: greyColor,
                width: 1.5
            ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(13),
                      height: 72,
                      width: 72,
                      decoration: BoxDecoration(
                        color:  skyBlueColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ImageLoaderWidget(imageUrl: imageUrl),
                    ),
                    Positioned(
                      right: -7.5,
                      top: 5,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            color: isOnline ? Colors.green : Colors.grey,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: bgColor,
                                width: 2
                            )
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 35.w,
                      child: TextWidget(
                        text: "${languageP.translatedTexts['Dr.']} $doctorName", fontSize: 16,
                        fontWeight: FontWeight.w600, isTextCenter: false,maxLines: 2,
                        textColor: textColor, fontFamily: AppFonts.semiBold,),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 25.w,
                          child: TextWidget(
                            text: specialityName, fontSize: 14,maxLines: 1,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: textColor, fontFamily: AppFonts.regular,),
                        ),
                        const SizedBox(width: 5,),
                        const Icon(Icons.circle,color: textColor,size: 5,),
                        const SizedBox(width: 5,),
                        SizedBox(
                          width: 18.w,
                          child: TextWidget(
                            text: specialityDetail, fontSize: 12,maxLines: 1,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: textColor, fontFamily: AppFonts.regular,),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                        const Icon(Icons.star,color: Colors.yellow,size: 20,),
                        TextWidget(
                          text: rating, fontSize: 12,
                          fontWeight: FontWeight.w400, isTextCenter: false,
                          textColor: textColor, fontFamily: AppFonts.regular,),
                        const SizedBox(width: 5,),
                        const Icon(Icons.circle,color: textColor,size: 5,),
                        const SizedBox(width: 5,),
                        const Icon(Icons.access_time_filled_rounded,color: themeColor, size: 20,),
                        const SizedBox(width: 5,),
                        SizedBox(
                          width: 25.w,
                          child: TextWidget(
                            text: "$availabilityFrom-$availabilityTo", fontSize: 12,
                            fontWeight: FontWeight.w400, isTextCenter: false,maxLines: 1,
                            textColor: themeColor, fontFamily: AppFonts.regular,),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: likeTap ?? (){},
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: greenColor
                        )
                    ),
                    child: Center(
                      child: Icon(
                        isFav ?  Icons.favorite
                            : Icons.favorite_border,
                        color: themeColor,size: 20,),
                    ),
                    //SvgPicture.asset(AppIcons.favIcon)
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubmitButton(
                    width: 30.w,
                    height: 40,
                    title: "Appointment",
                    press: onTap ?? (){}
                ),
                const SizedBox(width: 10,),
                const Expanded(
                    child: DottedLine(
                      color: greyColor,
                    )),
                const SizedBox(width: 10,),
                TextWidget(
                  text: "$appointmentFee MAD", fontSize: 18,
                  fontWeight: FontWeight.w600, isTextCenter: false,
                  textColor: textColor, fontFamily: AppFonts.semiBold,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
