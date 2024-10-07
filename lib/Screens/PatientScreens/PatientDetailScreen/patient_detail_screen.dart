import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../../../../constant.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../../model/res/widgets/input_field.dart';
import '../../../../model/res/widgets/submit_button.dart';
import '../../../../model/res/widgets/text_widget.dart';
import '../../../Providers/PatientAppointment/patient_appointment_provider.dart';
import '../../../model/res/constant/app_icons.dart';
import '../MakePaymentScreen/make_payment_screen.dart';
import 'Components/age_section.dart';

class PatientDetailScreen extends StatelessWidget {
  PatientDetailScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final String phonePattern = r'^\+?([1-9]{1}[0-9]{1,3})?([0-9]{10})$';


  @override
  Widget build(BuildContext context) {

    final patientAppointmentP = Provider.of<PatientAppointmentProvider>(context,listen: false);
    final languageP = Provider.of<TranslationProvider>(context);
    double height1 = 20;

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(text: "Patients details"),
            Expanded(
                child: Form(
                  key: formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    children: [
                      const TextWidget(
                        text: "Full Name", fontSize: 14,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.semiBold,),
                      SizedBox(height: height1,),
                      InputField(
                        inputController: patientAppointmentP.nameC,
                        hintText: "Full Name",
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: SvgPicture.asset(
                              AppIcons.personIcon,
                              colorFilter: const ColorFilter.mode(greyColor, BlendMode.srcIn)),
                        ),
                      ),
                      SizedBox(height: height1,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: "Select Your Age Range", fontSize: 14,
                            fontWeight: FontWeight.w600, isTextCenter: false,
                            textColor: textColor, fontFamily: AppFonts.semiBold,),
                          TextWidget(
                            text: " *", fontSize: 14,
                            fontWeight: FontWeight.w600, isTextCenter: false,
                            textColor: themeColor, fontFamily: AppFonts.semiBold,),
                        ],
                      ),
                      SizedBox(height: height1,),
                      AgeSection(),
                      SizedBox(height: height1,),
                      const TextWidget(
                        text: "Phone Number", fontSize: 14,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.semiBold,),
                      SizedBox(height: height1,),
                      ValidatedTextField(
                        validator: (value) {
                          if (!RegExp(phonePattern).hasMatch(value ?? '')) {
                            return languageP.translatedTexts["Please enter a valid phone number with country code"] ?? "Please enter a valid phone number with country code";
                          }
                          return null;
                        },
                        inputController: patientAppointmentP.phoneC,
                        hintText: "Phone Number",
                        type: TextInputType.phone,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(9.0),
                          child: Icon(Icons.phone_in_talk_rounded,color: greyColor,),
                        ),
                      ),
                      SizedBox(height: height1,),
                      const TextWidget(
                        text: "Gender", fontSize: 14,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.semiBold,),
                      SizedBox(height: height1,),
                      Consumer<PatientAppointmentProvider>(
                        builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubmitButton(
                                  bgColor: value.selectedGender == "Male" ? themeColor
                                      : secondaryGreenColor,
                                  textColor: value.selectedGender == "Male" ? bgColor
                                      : themeColor,
                                  width: 43.w,
                                  title: "Male",
                                  press: (){
                                    value.selectGender("Male");
                                  }
                              ),
                              SubmitButton(
                                  width: 43.w,
                                  title: "Female",
                                  bgColor: value.selectedGender == "Female"? themeColor
                                      : secondaryGreenColor,
                                  textColor: value.selectedGender == "Female"? bgColor
                                      : themeColor,
                                  press: (){
                                    value.selectGender("Female");
                                  }
                              ),
                            ],
                          );
                        },),
                      SizedBox(height: height1,),
                      const TextWidget(
                        text: "Write Your Problem", fontSize: 14,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.semiBold,),
                      SizedBox(height: height1,),
                      InputField(
                        inputController: patientAppointmentP.problemC,
                        hintText: "Tell doctor about your problem...",
                        maxLines: 6,
                      ),
                      SizedBox(height: height1,),
                      SubmitButton(
                        title: "Continue", press: () {
                          if(formKey.currentState!.validate()){
                            if(patientAppointmentP.selectedGender != null &&
                                patientAppointmentP.selectPatientAge != null){
                              Get.to(()=>const MakePaymentScreen());
                            }else{
                              ToastMsg().toastMsg(languageP.translatedTexts["Gender or Age is Missing!"] ?? "Gender or Age is Missing!",toastColor: redColor);
                            }
                          }
                      },
                      ),
                      SizedBox(height: height1,),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
