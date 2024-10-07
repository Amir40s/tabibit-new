import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/controller/translation_controller.dart';
import 'package:tabibinet_project/model/res/constant/app_text.dart';
import 'package:tabibinet_project/model/services/SharedPreference/shared_preference.dart';

import '../../../Providers/Language/language_provider.dart';
import '../../../Providers/translation/translation_provider.dart';
import '../../../constant.dart';
import '../../../controller/doctoro_specialiaty_controller.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../LocationScreen/location_screen.dart';
import 'Components/language_container.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key,required this.isNextButton});

  final bool isNextButton;

  final List<String> supportedLanguages = ['fr', 'ar', 'en', 'es'];

  final List<Map<String, String>> options = [
    {'title': 'French', 'subtitle': '', 'icon': AppIcons.flag_1},
    {'title': 'Arabic', 'subtitle': '', 'icon': AppIcons.flag_2},
    {'title': 'English', 'subtitle': '', 'icon': AppIcons.flag_3},
    {'title': 'Spanish', 'subtitle': '', 'icon': AppIcons.flag_4},
  ];

  @override
  Widget build(BuildContext context) {
    final languageP = Provider.of<TranslationProvider>(context);
    final TranslationController controller = Get.find<TranslationController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
               TextWidget(
                   text: languageP.translatedTexts["Choose Language"] ?? "Choose Language", fontSize: 24,
                   fontWeight: FontWeight.w600, isTextCenter: false,
                   textColor: textColor),
              const SizedBox(height: 10,),
               TextWidget(
                  text: languageP.translatedTexts["Choose language for app to show"] ?? "Choose language for app to show", fontSize: 14,
                  fontWeight: FontWeight.w400, isTextCenter: false,
                  textColor: textColor),
              const SizedBox(height: 20,),
              Consumer<LanguageProvider>(builder: (context, provider, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final isSelected = provider.selectedIndex == index;
                    return GestureDetector(

                      onTap: () async{
                        final pref = await SharedPreferencesService.getInstance();
                       await  pref.setString("language", supportedLanguages[index]);
                        provider.selectButton(index);
                        languageP.changeLanguage(supportedLanguages[index].toString());
                        await languageP.translateMultiple(AppText.appTextList,targetLanguage: supportedLanguages[index].toString());
                        provider.loadLanguage(supportedLanguages[index]);
                        controller.changeLanguage(supportedLanguages[index].toString());
                      },
                      child: LanguageContainer(
                        title: options[index]['title']!,
                        subTitle: isSelected ? "Primary Language" : "",
                        image: options[index]['icon']!,
                        boxColor: isSelected? themeColor : bgColor,
                        textColor: isSelected? bgColor: textColor,
                        boundaryColor: isSelected? themeColor :greyColor,
                        borderColor: isSelected ? themeColor : greenColor,
                      ),
                    );
                  },
                );
              },),
              const SizedBox(height: 20,),
              SubmitButton(
                title: isNextButton? "Next" : languageP.translatedTexts["Select"] ?? "Select",
                press: () {
                  if(isNextButton){
                  Get.to(()=>const LocationScreen());
                  }else{
                    Get.back();
                  }
              },)
            ],
          ),
        ),
      ),
    );
  }
}
