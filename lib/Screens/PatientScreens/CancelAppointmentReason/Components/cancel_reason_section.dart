import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/PatientHome/patient_home_provider.dart';

import '../../../../constant.dart';
import '../../../../model/res/constant/app_icons.dart';
import '../../../../model/res/widgets/text_widget.dart';

class CancelReasonSection extends StatelessWidget {
  CancelReasonSection({super.key});

  final List<String> reasons = [
    "I want to change to another doctor",
    "I want to change package",
    "I don't want to consult",
    "I have recovered from the disease",
    "I have found a suitable medicine",
    "I just want to cancel",
    "I don't want to tell",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientHomeProvider>(
      builder: (context, value, child) {
        return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: reasons.length,
        itemBuilder: (context, index) {
          final isSelected = value.selectCancelReason == index;
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              value.setCancelReason(index);
            },
            child: Container(
              width: 100.w,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color:isSelected ? themeColor : greyColor)
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    isSelected ? AppIcons.radioOnIcon
                      : AppIcons.radioOffIcon,height: 3.h,),
                  const SizedBox(width: 10,),
                  TextWidget(text: reasons[index], fontSize: 14.sp, fontWeight: FontWeight.w400, isTextCenter: false, textColor: textColor)

                ],
              ),
            ),
          );
        },);
    },);
  }
}
