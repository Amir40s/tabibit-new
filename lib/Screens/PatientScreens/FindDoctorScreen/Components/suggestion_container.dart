import 'package:flutter/material.dart';

import '../../../../../constant.dart';
import '../../../../../model/res/constant/app_fonts.dart';
import '../../../../../model/res/widgets/text_widget.dart';

class SuggestionContainer extends StatelessWidget {
  const SuggestionContainer({
    super.key,
    required this.text,
    required this.boxColor,
    required this.textColor,
  });

  final String text;
  final Color boxColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: themeColor
          )
      ),
      child: Center(
        child: TextWidget(
          text: text, fontSize: 16,
          fontWeight: FontWeight.w500, isTextCenter: false,
          textColor: textColor,
          fontFamily: AppFonts.medium,),
      ),
    );
  }
}

class SuggestionContainer2 extends StatelessWidget {
  const SuggestionContainer2({
    super.key,
    required this.text,
    required this.boxColor,
    required this.textColor,
    required this.isTick,
  });

  final String text;
  final Color boxColor;
  final Color textColor;
  final bool isTick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: themeColor
          )
      ),
      child: Row(
        children: [
          TextWidget(
            text: text, fontSize: 16,
            fontWeight: FontWeight.w500, isTextCenter: false,
            textColor: textColor,
            fontFamily: AppFonts.medium,),
          Visibility(
            visible: isTick,
              child: const Icon(Icons.done,color: bgColor,size: 20,))
        ],
      ),
    );
  }
}
