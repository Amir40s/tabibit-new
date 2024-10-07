import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';

import '../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/input_field.dart';
import '../../../model/res/widgets/text_widget.dart';

class CheckInteractionScreen extends StatelessWidget {
  CheckInteractionScreen({super.key});

  final List<String> _dropdownItems = ['drug1', 'drug2', 'drug3'];

  final searchC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Drug Interaction Checker"),
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
                    TextWidget(
                      text: "Choose Your Drug", fontSize: 16.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.medium,),
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
                            icon: SvgPicture.asset(AppIcons.downArrowIcon,height: 3.h,),
                            underline: const SizedBox(),
                            borderRadius: BorderRadius.circular(15),
                            hint: TextWidget(
                              text: "Enter Group name of drug", fontSize: 14.sp,
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
                    TextWidget(
                      text: "Choose Drug To Compare", fontSize: 16.sp,
                      fontWeight: FontWeight.w600, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.medium,),
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
                            icon: SvgPicture.asset(AppIcons.downArrowIcon,height: 3.h,),
                            underline: const SizedBox(),
                            borderRadius: BorderRadius.circular(15),
                            hint: TextWidget(
                              text: "Enter Group name of drug", fontSize: 14.sp,
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
                    const SizedBox(height: 30,),
                    SubmitButton(
                      title: "Check Interaction",
                      press: () {

                      },)
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
