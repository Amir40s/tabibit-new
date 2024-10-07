import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../../../constant.dart';
import '../../../../../model/res/widgets/submit_button.dart';

class RatingSection extends StatelessWidget {
  RatingSection({super.key});

  final List<String> rating = [
    "2.4",
    "3.4",
    "4.4",
    "6.8",
    "7.5",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 100.w,
      child: Consumer<PatientHomeProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            padding: const EdgeInsets.only(left: 20),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: rating.length,
            itemBuilder: (context, index) {
              final isSelected = value.currentRating == index;
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SubmitButton(
                  width: 20.w,
                  bgColor: isSelected ? themeColor : bgColor ,
                  icon: isSelected ? CupertinoIcons.star_fill : CupertinoIcons.star,
                  iconSize: 15,
                  iconColor: isSelected ? bgColor : themeColor,
                  textColor: isSelected ? bgColor : textColor,
                  bdColor: isSelected ? themeColor : greyColor,
                  title: rating[index],
                  press: () {
                    value.setRating(index);
                  },),
              );
            },
          );
        },
      ),
    );
  }
}
