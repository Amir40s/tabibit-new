import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../../../constant.dart';
import '../../../../../model/res/widgets/submit_button.dart';

class ExperienceSection extends StatelessWidget {
  ExperienceSection({super.key});

  final List<String> experience = [
    "Any Experience",
    "Less than year",
    "1 - 5",
    "2 - 10",
    "5 - 10",
    "6 - 10",
    "8 - 10",
    "9 - 5",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Consumer<PatientHomeProvider>(
        builder: (context, value, child) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: experience.length,
            itemBuilder: (context, index) {
              final isSelected = value.currentExperience == index;
              return SubmitButton(
                bgColor: bgColor,
                iconColor: themeColor,
                textColor: isSelected ? themeColor : textColor,
                bdColor: isSelected ? themeColor : greyColor,
                title: experience[index],
                press: () {
                  value.setExperience(index);
                },);
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 70,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10
            ),
          );
        },
      ),
    );
  }
}
