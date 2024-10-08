import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../../../constant.dart';
import '../../../../model/res/constant/app_assets.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/constant/app_icons.dart';
import '../../../../model/res/widgets/text_widget.dart';

class ScheduleContainer extends StatelessWidget {
  final String data; // Title
  final String subtitle; // Subtitle
  final String image; // Image URL

  const ScheduleContainer({
    super.key,
    required this.data,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
      width: 80.w,
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: greenColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: data, // Title
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  isTextCenter: false,
                  textColor: textColor,
                  fontFamily: AppFonts.semiBold,
                ),
                // TextWidget(
                //   text: subtitle, // Subtitle
                //   fontSize: 14.sp,
                //   fontWeight: FontWeight.w400,
                //   isTextCenter: false,
                //   textColor: textColor,
                //   fontFamily: AppFonts.regular,
                // ),
                const Spacer(),
                 TextWidget(
                  text: subtitle,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  isTextCenter: false,
                  maxLines: 2,
                  textColor: textColor,
                  fontFamily: AppFonts.regular,
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 15.h,
            width: 20.w,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(15)),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topRight,
                children: [
                  // Use an image from the URL
                  // Image.network(image, fit: BoxFit.fill), // Use image URL
                  Container(
                    height: 15.h,
                    width: 16.w,
                    decoration:  BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image.toString(),),
                          fit: BoxFit.cover,
                          repeat: ImageRepeat.noRepeat,
                      ),
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
