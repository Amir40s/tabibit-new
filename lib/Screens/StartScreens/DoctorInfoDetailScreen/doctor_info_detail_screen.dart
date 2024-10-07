import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Screens/StartScreens/SignUpScreen/sign_up_screen.dart';

import '../../../Providers/SignIn/sign_in_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/input_field.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';
import '../../../model/res/widgets/toast_msg.dart';
import '../SignInScreen/signin_screen.dart';
import 'Components/doctor_appointment_time_section.dart';
import 'Components/speciality_dropdown.dart';

class DoctorInfoDetailScreen extends StatelessWidget {
  DoctorInfoDetailScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signP = Provider.of<SignInProvider>(context,listen: false);
    double height = 50.0;
    double height1 = 20.0;
    double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(height: height,),
              const Center(
                child: TextWidget(
                    text: "Add Information", fontSize: 24,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor),
              ),
              SizedBox(height: height2,),
              const Center(
                child: TextWidget(
                    text: "Add your Information to show Patients", fontSize: 14,
                    fontWeight: FontWeight.w400, isTextCenter: false,
                    textColor: textColor),
              ),
              SizedBox(height: height1,),
              const TextWidget(
                text: "Speciality", fontSize: 14,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: textColor,fontFamily: AppFonts.semiBold,),
              SizedBox(height: height2,),
              SpecialityDropdown(),
              SizedBox(height: height1,),
              const TextWidget(
                text: "Years of Experience", fontSize: 14,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: textColor,fontFamily: AppFonts.semiBold,),
              SizedBox(height: height2,),
              InputField(
                inputController: signP.yearsOfExperienceC,
                hintText: "Enter Experience",
                type: TextInputType.number,
              ),
              SizedBox(height: height1,),
              const TextWidget(
                text: "Availability Time", fontSize: 14,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: textColor,fontFamily: AppFonts.semiBold,),
              SizedBox(height: height2,),
              DoctorAppointmentTimeSection(),
              SizedBox(height: height1,),
              const TextWidget(
                text: "Appointment Fee (MAD)", fontSize: 14,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: textColor,fontFamily: AppFonts.semiBold,),
              SizedBox(height: height2,),
              InputField(
                inputController: signP.appointmentFeeC,
                hintText: "Enter Appointment Fee",
                type: TextInputType.number,
              ),
              SizedBox(height: height1,),
              const TextWidget(
                text: "Speciality Detail", fontSize: 14,
                fontWeight: FontWeight.w600, isTextCenter: false,
                textColor: textColor,fontFamily: AppFonts.semiBold,),
              SizedBox(height: height2,),
              InputField(
                inputController: signP.specialityDetailC,
                hintText: "Enter the Detail on your Speciality",
                maxLines: 6,
              ),
              SizedBox(height: height1,),
              SubmitButton(
                title:  "Next",
                press: () {
                  if(formKey.currentState!.validate()){
                    if(signP.appointmentFrom != null && signP.appointmentTo != null){
                      Get.to(SignUpScreen());
                    }else{
                      ToastMsg().toastMsg("Enter the Availability Time");
                    }
                  }
                },),
            ],
          ),
        ),
      ),
    );
  }
}
