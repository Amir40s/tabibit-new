import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/SuccessScreen/success_screen.dart';

import '../../../Providers/Medicine/medicine_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/input_field.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../PatientScreens/FindDoctorScreen/Components/suggestion_container.dart';

class PrescribeMedicineScreen extends StatelessWidget {
  PrescribeMedicineScreen({
    super.key,
    required this.appointmentId,
    required this.isVisible
  });

  final String appointmentId;

  final medC = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final List<String> repeat = [
    "Everyday",
    "Alternative day",
    "Specific days",
  ];

  final List<String> day = [
    "Morning",
    "Noon",
    "Evening",
    "Night",
  ];

  final List<String> taken = [
    "After food",
    "Before food",
  ];

  final bool isVisible;
  
  @override
  Widget build(BuildContext context) {
    final medP = Provider.of<MedicineProvider>(context,listen: false);
    double height1 = 20.0;
    double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Prescribe Medicine"),
            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    SizedBox(height: height1,),
                    TextWidget(
                        text: "Tablet Name", fontSize: 16.sp,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor),
                    SizedBox(height: height2,),
                    Form(
                      key: formKey,
                      child: InputField(
                        inputController: medP.tabletC,
                        hintText: "medicine Name",
                      ),
                    ),
                    SizedBox(height: height1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: "Dosage", fontSize: 16.sp,
                                fontWeight: FontWeight.w600, isTextCenter: false,
                                textColor: textColor),
                            SizedBox(height: height2,),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    medP.decDosage();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: themeColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: const Icon(CupertinoIcons.minus,color: themeColor,),
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                Consumer<MedicineProvider>(
                                  builder: (context, value, child) {
                                    return TextWidget(
                                      text: "${value.dosage} Tablet", fontSize: 16.sp,
                                      fontWeight: FontWeight.w500, isTextCenter: false,
                                      textColor: textColor, fontFamily: AppFonts.medium,);
                                  },),
                                const SizedBox(width: 8,),
                                InkWell(
                                  onTap: () {
                                    medP.addDosage();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: themeColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: const Icon(CupertinoIcons.add,color: themeColor,),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                                text: "Duration", fontSize: 16.sp,
                                fontWeight: FontWeight.w600, isTextCenter: false,
                                textColor: textColor),
                            SizedBox(height: height2,),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    medP.decDuration();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: themeColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: const Icon(CupertinoIcons.minus,color: themeColor,),
                                  ),
                                ),
                                const SizedBox(width: 8,),
                                Consumer<MedicineProvider>(
                                  builder: (context, value, child) {
                                    return TextWidget(
                                      text: "${value.duration} Week", fontSize: 16.sp,
                                      fontWeight: FontWeight.w500, isTextCenter: false,
                                      textColor: textColor, fontFamily: AppFonts.medium,);
                                  },),
                                const SizedBox(width: 8,),
                                InkWell(
                                  onTap: () {
                                    medP.addDuration();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: themeColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: const Icon(CupertinoIcons.add,color: themeColor,),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: height1,),
                    TextWidget(
                        text: "Repeat", fontSize: 16.sp,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor),
                    SizedBox(height: height2,),
                    SizedBox(
                        height: 40,
                        width: 100.w,
                        child: Consumer<MedicineProvider>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: repeat.length,
                              itemBuilder: (context, index) {
                                final item = repeat[index];
                                final isSelected = provider.selectedRepeats.contains(item);
                                return GestureDetector(
                                  onTap: () {
                                    provider.selectRepeatButton(item);
                                  //  provider.selectRepeatButton(index);
                                  },
                                  child: SuggestionContainer2(
                                      text: repeat[index],
                                      isTick: isSelected,
                                      boxColor: isSelected ? themeColor : bgColor,
                                      textColor: isSelected ? bgColor : themeColor),
                                );
                              },);
                          },)
                    ),
                    SizedBox(height: height1,),
                    TextWidget(
                        text: "Time of day", fontSize: 16.sp,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor),
                    SizedBox(height: height2,),
                    SizedBox(
                        height: 40,
                        width: 100.w,
                        child: Consumer<MedicineProvider>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: day.length,
                              itemBuilder: (context, index) {
                                final item = day[index];
                                final isSelected = provider.selectDay.contains(item);
                                return GestureDetector(
                                  onTap: () {
                                    provider.selectDayButton(item);
                                    //provider.selectDayButton(index);
                                  },
                                  child: SuggestionContainer2(
                                      text: day[index],
                                      isTick: isSelected,
                                      boxColor: isSelected ? themeColor : bgColor,
                                      textColor: isSelected ? bgColor : themeColor),
                                );
                              },);
                          },)
                    ),
                    SizedBox(height: height1,),
                    TextWidget(
                        text: "To be taken", fontSize: 16.sp,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor),
                    SizedBox(height: height2,),
                    SizedBox(
                        height: 40,
                        width: 100.w,
                        child: Consumer<MedicineProvider>(
                          builder: (context, provider, child) {
                            return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: taken.length,
                              itemBuilder: (context, index) {
                                final item = taken[index];
                                final isSelected = provider.selectTaken.contains(item);
                                return GestureDetector(
                                  onTap: () {
                                    provider.selectTakenButton(item);
                                  //  provider.selectTakenButton(index);
                                  },
                                  child: SuggestionContainer2(
                                      text: taken[index],
                                      isTick: isSelected,
                                      boxColor: isSelected ? themeColor : bgColor,
                                      textColor: isSelected ? bgColor : themeColor),
                                );
                              },);
                          },)
                    ),
                    const SizedBox(height: 30,),
                    Visibility(
                      visible: isVisible,
                      child: Consumer<MedicineProvider>(
                        builder: (context, value, child) {
                          return  value.isLoading ?
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ) :
                          SubmitButton(
                            title: "Prescribe Medicine ",
                            press: () {
                              if(formKey.currentState!.validate()){
                                value.sendPrescription(appointmentId);
                              }
                            },);
                        },),
                    ),
                    Visibility(
                      visible: !isVisible,
                      child: SubmitButton(
                        title: "Update",
                        press: () {
                          Get.to(()=> const SuccessScreen(
                              title: "Prescription Updated Successfully!",
                              subTitle: "Prescription has been updated to the patient"
                          )
                          );
                      },),
                    ),
                    SizedBox(height: height1,),
                    Visibility(
                      visible: !isVisible,
                      child: SubmitButton(
                        title: "Renew Prescription",
                        textColor: themeColor,
                        bgColor: bgColor,
                        press: () {

                        },),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
