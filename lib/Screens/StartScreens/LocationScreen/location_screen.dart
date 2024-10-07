import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../Providers/Location/location_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../AccountTypeScreen/account_type_screen.dart';
import 'Components/google_map_section.dart';
import 'Components/search_location_field.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  // final List<String> supportedLanguages = ['en', 'fr', 'es', 'ar'];
  @override
  Widget build(BuildContext context) {
    final locationP = Provider.of<LocationProvider>(context,listen: false);
    locationP.getUserCurrentLocation(context);
    locationP.location(context);
    // final languageP = Provider.of<LanguageProvider>(context,listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h,),
                  const Center(
                    child: TextWidget(
                        text: "Choose Location", fontSize: 24,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor),
                  ),
                  const SizedBox(height: 10,),
                  const Center(
                    child: TextWidget(
                        text: "Choose your location for near hospitals",
                        fontSize: 14,
                        fontWeight: FontWeight.w400, isTextCenter: false,
                        textColor: textColor),
                  ),
                  const SizedBox(height: 20,),
                  const TextWidget(
                      text: "Country", fontSize: 21,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: textColor,fontFamily: "Medium",),
                  const SizedBox(height: 10,),
                  Consumer<LocationProvider>(
                    builder: (context, value, child) {
                    return InkWell(
                      onTap: () {
                        showCountryPicker(
                          moveAlongWithKeyboard: true,
                          context: context,
                          showPhoneCode: false, // Do not show the phone code
                          onSelect: (Country country) {
                            log('Selected country: ${country.name}');
                            value.selectCountryName(country.name);
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 9.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: themeColor,
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextWidget(text: value.countryName, fontSize: 16, fontWeight: FontWeight.w600,
                              isTextCenter: false, textColor: textColor,fontFamily: "Medium",),
                            SvgPicture.asset(AppIcons.downArrowIcon,height: 35,)
                          ],
                        ),
                      ),
                    );
                  },),
                  const SizedBox(height: 10,),
                  const TextWidget(
                      text: "Address", fontSize: 21,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: textColor,fontFamily: "Medium",),
                  const SizedBox(height: 10,),
                  const SearchLocationField(),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 100.w,
              height: 40.h,
              child: const GoogleMapSection(),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SubmitButton(
                title: "Next",
                press: () {
                  if(locationP.countryName.isNotEmpty){
                    Get.to(()=>const AccountTypeScreen());
                    // locationP.dispose();
                  }else{
                    Get.snackbar("Error!", "Please Select Country");
                  }
                },),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
