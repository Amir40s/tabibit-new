import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tabibinet_project/Providers/translation/translation_provider.dart';

import 'package:tabibinet_project/Providers/Language/language_provider.dart';

import '../../../constant.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.title,
    this.icon,
    required this.press,
    this.height,
    this.width,
    this.radius,
    this.bdColor,
    this.iconColor,
    this.textSize,
    this.bdRadius,
    this.bgColor,
    this.textColor,
    this.iconSize,
    this.gradientColors,
  });
  final String? title;
  final IconData? icon;
  final Function() press;
  final double? height, width, radius, iconSize, textSize, bdRadius;
  final Color? bdColor, bgColor, textColor,iconColor;
  final LinearGradient? gradientColors;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TranslationProvider>(context);
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1.0),
        width: width ?? double.infinity,
        alignment: Alignment.center,
        height: height ?? 50.0,
        decoration: BoxDecoration(
            color: bgColor ?? themeColor,
            borderRadius: BorderRadius.circular(radius ?? 10.0),
            gradient: gradientColors,
            border: Border.all(
                color: bdColor ?? themeColor
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (title != null)

              AutoSizeText(
                minFontSize: 8,
                provider.translatedTexts[title!] ?? title!,
                maxLines: 2,
                style: TextStyle(
                    color: textColor ?? Colors.white, fontWeight: FontWeight.w500,fontFamily: "Medium"),
              ),

            if (icon != null)
              Padding(
                padding: EdgeInsets.only(left: title != null ? 8.0 : 0.0),
                child: Icon(
                  icon,
                  color: iconColor ?? Colors.white,
                  size: iconSize ?? 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SubmitButton2 extends StatelessWidget {
  const SubmitButton2({
    super.key,
    required this.title,
    this.icon,
    required this.press,
    this.height,
    this.width,
    this.radius,
    this.bdColor,
    this.iconColor,
    this.textSize,
    this.bdRadius,
    this.bgColor,
    this.textColor,
    this.iconSize,
    this.gradientColors,
  });
  final String? title;
  final String? icon;
  final Function() press;
  final double? height, width, radius, iconSize, textSize, bdRadius;
  final Color? bdColor, bgColor, textColor,iconColor;
  final LinearGradient? gradientColors;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1.0),
        width: width ?? double.infinity,
        alignment: Alignment.center,
        height: height ?? 50.0,
        decoration: BoxDecoration(
            color: bgColor ?? themeColor,
            borderRadius: BorderRadius.circular(radius ?? 10.0),
            gradient: gradientColors,
            border: Border.all(
                color: bdColor ?? themeColor
            )
          // boxShadow: [
          //   BoxShadow(
          //       offset: const Offset(0, 2),
          //       spreadRadius: 1,
          //       blurRadius: 2,
          //       color: Colors.grey.withOpacity(.5))
          // ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: EdgeInsets.only(right: title != null ? 8.0 : 0.0),
                child: Image.asset(
                  icon!,
                  height: iconSize ?? 20,
                  color: iconColor ?? Colors.white,
                ),
              ),
            if (title != null)
              Consumer<LanguageProvider>(builder: (context, value, child) {
                return AutoSizeText(
                  minFontSize: 8,
                  value.translate(title!),
                  maxLines: 2,
                  style: TextStyle(
                      color: textColor ?? Colors.white, fontWeight: FontWeight.w500,fontFamily: "Medium"),
                );
              },),
          ],
        ),
      ),
    );
  }
}
