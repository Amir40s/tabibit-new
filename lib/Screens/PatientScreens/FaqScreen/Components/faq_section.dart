import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/FaqProvider/faq_provider.dart';
import 'package:tabibinet_project/Providers/Language/new/translation_new_provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/model/data/faq_model.dart';

import '../../../../constant.dart';
import '../../../../controller/doctoro_specialiaty_controller.dart';
import '../../../../controller/translation_controller.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/constant/app_icons.dart';
import '../../../../model/res/widgets/dotted_line.dart';
import '../../../../model/res/widgets/text_widget.dart';

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});


  @override
  Widget build(BuildContext context) {

    double height1 = 20;
    final faqP = Provider.of<FaqProvider>(context,listen: false);

    return Column(
      children: [
        Consumer<TranslationNewProvider>(
         builder: (context,provider,child){
           return StreamBuilder<List<FaqModel>>(
             stream: faqP.fetchFaq(),
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
               }
               if (!snapshot.hasData || snapshot.data!.isEmpty) {
                 return const Center(child: Text('No FAQ Found'));
               }

               final specs = snapshot.data!;

               if (provider.faqList.isEmpty) {
                 provider.translateFaq(
                   specs.map((e) => e.question).toList() +
                       specs.map((e) => e.answer).toList(),
                 );
               }



               return Consumer<FaqProvider>(
                 builder: (context, value, child) {
                   return ListView.separated(
                     padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                     shrinkWrap: true,
                     itemCount: specs.length,
                     itemBuilder: (context, index) {
                       final isSelected = value.selectFaq == index;
                       final faq = specs[index];

                       final question = provider.faqList[faq.question] ?? faq.question;
                       final answer = provider.faqList[faq.answer] ?? faq.answer;

                       return InkWell(
                         splashColor: Colors.transparent,
                         highlightColor: Colors.transparent,
                         onTap: () {
                           value.setFaq(index);
                           if(isSelected){
                             value.setFaq(null);
                           }
                         },
                         child: Container(
                           padding: const EdgeInsets.all(20),
                           decoration: BoxDecoration(
                               color: bgColor,
                               borderRadius: BorderRadius.circular(15),
                               border: Border.all(
                                   color: isSelected ? greenColor
                                       : greyColor)
                           ),
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   SizedBox(
                                     width: 70.w,
                                     child: TextWidget(
                                       text: question, fontSize: 14,
                                       fontWeight: FontWeight.w600, isTextCenter: false,
                                       textColor: textColor, fontFamily: AppFonts.semiBold,),
                                   ),
                                   SvgPicture.asset(
                                     isSelected ? AppIcons.caretUpIcon
                                         : AppIcons.caretDownIcon,
                                     height: 3.h,
                                   )
                                 ],
                               ),
                               Visibility(
                                   visible: isSelected,
                                   child: SizedBox(height: height1,)),
                               Visibility(
                                   visible: isSelected,
                                   child: const DottedLine(color: greyColor,)),
                               Visibility(
                                   visible: isSelected,
                                   child: SizedBox(height: height1,)),
                               Visibility(
                                 visible: isSelected,
                                 child: Text(
                                     answer,
                                     style:  TextStyle(
                                         fontSize: 16, fontWeight: FontWeight.w400,
                                         color: textColor
                                     ) ),
                               )
                             ],
                           ),
                         ),
                       );
                     },
                     separatorBuilder: (context, index) {
                       return SizedBox(height: height1,);
                     },
                   );
                 },);
             },);
         },
        ),
      ],
    );
  }
}
