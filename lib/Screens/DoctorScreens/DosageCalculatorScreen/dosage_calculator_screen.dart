import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_assets.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/constant/app_icons.dart';
import '../../../model/res/widgets/input_field.dart';

class DosageCalculatorScreen extends StatelessWidget {
  DosageCalculatorScreen({super.key});

  final searchC = TextEditingController();
  final tabletC = TextEditingController();
  final weighC = TextEditingController();
  final ageC = TextEditingController();

  final List<String> _dropdownItems = ['100', '200', '300'];


  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Dosage Calculator"),
            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: height1,),
                    InputField2(
                      inputController: searchC,
                      hintText: "Find here!",
                      prefixIcon: Icons.search,
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(14),
                        padding: const EdgeInsets.all(3),
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          color: greenColor,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(AppIcons.crossIcon),
                      ),
                    ),
                    SizedBox(height: height1,),
                    Container(
                      height: 180,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Image.asset(AppAssets.medicineImage),
                    ),
                    SizedBox(height: height1,),
                    TextWidget(
                        text: "Tablet Name", fontSize: 16.sp,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor),
                    SizedBox(height: height2,),
                    InputField(
                      inputController: tabletC,
                      hintText: "medicine Name",
                    ),
                    SizedBox(height: height1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 40.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text: "Patient Weight", fontSize: 16.sp,
                                  fontWeight: FontWeight.w600, isTextCenter: false,
                                  textColor: textColor),
                              SizedBox(height: height2,),
                              InputField(
                                inputController: tabletC,
                                hintText: "e.g 50 kg",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 40.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                  text: "Age", fontSize: 16.sp,
                                  fontWeight: FontWeight.w600, isTextCenter: false,
                                  textColor: textColor),
                              SizedBox(height: height2,),
                              InputField(
                                inputController: tabletC,
                                hintText: "000",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height1,),
                    TextWidget(
                        text: "Strength", fontSize: 16.sp,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor),
                    SizedBox(height: height2,),
                    Container(
                      width: 100.w,
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                      decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: greyColor
                          )
                      ),
                      child: Consumer<PatientHomeProvider>(
                        builder: (context, provider, child) {
                          return DropdownButton<String>(
                            dropdownColor: bgColor,
                            icon: Row(
                              children: [
                                TextWidget(
                                  text: "mg/kg", fontSize: 16.sp,
                                  fontWeight: FontWeight.w600, isTextCenter: false,
                                  textColor: textColor,fontFamily: AppFonts.medium,),
                                const SizedBox(width: 5,),
                                SvgPicture.asset(AppIcons.downArrowIcon,height: 3.h,),
                              ],
                            ),
                            underline: const SizedBox(),
                            borderRadius: BorderRadius.circular(15),
                            hint: TextWidget(
                              text: "0000", fontSize: 14.sp,
                              fontWeight: FontWeight.w400, isTextCenter: false,
                              textColor: greyColor,),
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: AppFonts.semiBold,
                                fontWeight: FontWeight.w600,
                                color: textColor
                            ),
                            isExpanded: true,
                            value: provider.selectedAppointmentType,
                            onChanged: (newValue) {
                              provider.setAppointmentType(newValue!);
                            },
                            items: _dropdownItems.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          );
                        },),
                    ),
                    SizedBox(height: height1,),
                    SubmitButton(
                      title: "Calculate",
                      press: () {

                      },)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
