import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Providers/translation/translation_provider.dart';
import '../../../constant.dart';
import '../../../controller/translation_controller.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/input_field.dart';
import 'Components/faq_cat_section.dart';
import 'Components/faq_section.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});

  final searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {


    double height1 = 20;

    return const SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Header(text: "FAQ"),
            Expanded(
                child: FaqSection())
          ],
        ),
      ),
    );
  }
}
