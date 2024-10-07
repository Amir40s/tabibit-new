import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/constant/app_assets.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';

import '../../../../Providers/Location/location_provider.dart';
import '../../../../constant.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../../model/res/widgets/input_field.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';
import '../../../model/res/constant/app_icons.dart';

class AddCardScreen extends StatelessWidget {
  AddCardScreen({super.key});

  final cardHolderC = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double height1 = 20.0;
    double height2 = 10.0;

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(text: "Add Card"),
            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Image.asset(AppAssets.creditCard),
                    SizedBox(height: height1,),
                    const TextWidget(
                      text: "Card Holder Name", fontSize: 14,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,
                    ),
                    SizedBox(height: height2,),
                    InputField(
                      inputController: cardHolderC,
                      hintText: "Amin Smith",
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          AppIcons.personIcon,
                          colorFilter: const ColorFilter.mode(greyColor, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    SizedBox(height: height1,),
                    const TextWidget(
                      text: "Card Number", fontSize: 14,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,
                    ),
                    SizedBox(height: height2,),
                    InputField(
                      inputController: cardHolderC,
                      hintText: "******46565",
                      suffixIcon: const Icon(Icons.remove_red_eye_outlined,color: greyColor,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height1,),
                            const TextWidget(
                              text: "Exp Date", fontSize: 14,
                              fontWeight: FontWeight.w600, isTextCenter: false,
                              textColor: textColor, fontFamily: AppFonts.semiBold,
                            ),
                            SizedBox(height: height2,),
                            SizedBox(
                              width: 40.w,
                              child: InputField(
                                inputController: cardHolderC,
                                hintText: "DD.MM.YYY",
                                type: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height1,),
                            const TextWidget(
                              text: "CVV Code", fontSize: 14,
                              fontWeight: FontWeight.w600, isTextCenter: false,
                              textColor: textColor, fontFamily: AppFonts.semiBold,
                            ),
                            SizedBox(height: height2,),
                            SizedBox(
                              width: 40.w,
                              child: InputField(
                                inputController: cardHolderC,
                                hintText: "000",
                                type: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height1,),
                    const TextWidget(
                      text: "Country", fontSize: 14,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.semiBold,
                    ),
                    SizedBox(height: height2,),
                    Consumer<LocationProvider>(
                      builder: (context, value, child) {
                        return InkWell(
                          onTap: () {
                            showCountryPicker(
                              moveAlongWithKeyboard: true,
                              context: context,
                              showPhoneCode: false, // Do not show the phone code
                              onSelect: (Country country) {
                                debugPrint('Selected country: ${country.name}');
                                value.selectCountryName(country.name);
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 6.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: greyColor,
                                  width: 1.5
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  text: value.countryName, fontSize: 12,
                                  fontWeight: FontWeight.w500, isTextCenter: false,
                                  textColor: textColor,fontFamily: AppFonts.medium,
                                ),
                                const Icon(CupertinoIcons.chevron_down,color: greyColor,size: 25,)
                              ],
                            ),
                          ),
                        );
                      },),
                    SizedBox(height: height1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Checkbox(value: true, onChanged: (value) {

                          },),
                        ),
                        const TextWidget(
                            text: "Set as your default payment method", fontSize: 16,
                            fontWeight: FontWeight.w400, isTextCenter: false,
                            textColor: textColor)
                      ],
                    ),
                    SizedBox(height: height1,),
                    SubmitButton(
                      title: "Add",
                      press: () {
                        Get.back();
                    },),
                    SizedBox(height: height1,),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
