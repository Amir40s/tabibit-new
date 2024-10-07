import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../../../constant.dart';
import '../../../../../model/res/widgets/dotted_line.dart';
import '../../../../model/res/constant/app_icons.dart';
import 'option_tile.dart';

class OptionSection extends StatelessWidget {
  OptionSection({super.key});

  final List<String> options = [
    "Popularity",
    "Star Rating (highest first)",
    "Star Rating (highest first)",
    "Best Reviewed First",
    "Mast Reviewed First",
    "Price (lowest first)",
    "Price (highest first)",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: greyColor
          )
      ),
      child: Consumer<PatientHomeProvider>(
        builder: (context, value, child) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final isSelected = value.currentOption == index;
              return OptionTile(
                title: options[index],
                image: isSelected ? AppIcons.radioOnIcon : AppIcons.radioOffIcon,
                onTap: () {
                  value.setOption(index);
                },);
            },
            separatorBuilder: (context, index) {
              return const DottedLine(
                height: 2,
                color: greyColor,
                dotLength: 4,
                spacing: 4,
                direction: Axis.horizontal,
              );
            },
          );
        },
      ),
    );
  }
}
