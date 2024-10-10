import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../Providers/translation/translation_provider.dart';

import '../../../Providers/Language/language_provider.dart';


class TextWidget extends StatelessWidget {
  const TextWidget(
      {super.key,
        required this.text,
        required this.fontSize,
        this.fontWeight = FontWeight.normal,
        this.isTextCenter,
        this.textColor,
        this.maxLines,
        this.fontFamily = "Regular",
        this.valueKey,
        this.align,
        this.overflow
      });
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? textColor;
  final bool? isTextCenter;
  final int? maxLines;
  final String fontFamily;
  final TextAlign? align;
  final TextOverflow? overflow;
  final ValueKey<int>? valueKey;
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TranslationProvider>(context);
    return AutoSizeText(
      key: valueKey,
      provider.translatedTexts[text] ?? text,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      textAlign: align ?? TextAlign.start,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight, color: textColor,fontFamily: fontFamily),
    );

  }
}
