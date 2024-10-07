import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../constant.dart';
import '../constant/app_fonts.dart';

class ReusableDropdown<T> extends StatelessWidget {
  final double width;
  final double? borderWidth;
  final double? borderRadius;
  final double? verticalPad;
  final double? fontSize;
  final String? fontFamily;
  final T? selectedValue;
  final List<T> items;
  final String hintText;
  final Color? borderColor;
  final ValueChanged<T?> onChanged;

  const ReusableDropdown({
    super.key,
    required this.width,
    this.borderWidth,
    this.borderRadius,
    this.verticalPad,
    this.fontSize,
    this.fontFamily,
    required this.selectedValue,
    required this.items,
    required this.hintText,
    this.borderColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: verticalPad ?? 0),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          border: Border.all(
              color: borderColor ?? greyColor,
              width: borderWidth ?? 1.5
          )
      ),
      child: DropdownButton<T>(
        dropdownColor: bgColor,
        icon: const Icon(CupertinoIcons.chevron_down,size: 15,),
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(10),
        style: TextStyle(
            fontSize: fontSize ?? 12,
            fontFamily: fontFamily ?? AppFonts.medium,
            fontWeight: FontWeight.w600,
            color: textColor
        ),
        hint: TextWidget(
          text: hintText, fontSize: fontSize ?? 12,
          fontWeight: FontWeight.w600, isTextCenter: false,
          textColor: greyColor,fontFamily: fontFamily ?? AppFonts.medium,),
        isExpanded: true,
        value: selectedValue,
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(value.toString()), // Customize how items are displayed
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
