import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Screens/StartScreens/DoctorInfoDetailScreen/doctor_experience_info_screen.dart';
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
    final signP = Provider.of<SignInProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: _DoctorInfoForm(formKey: formKey, signInProvider: signP),
      ),
    );
  }
}

class _DoctorInfoForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final SignInProvider signInProvider;

  const _DoctorInfoForm({
    Key? key,
    required this.formKey,
    required this.signInProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 50.0;
    double height1 = 20.0;
    double height2 = 10.0;

    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          SizedBox(height: height),
          const Center(
            child: TextWidget(
              text: "Add Information",
              fontSize: 24,
              fontWeight: FontWeight.w600,
              isTextCenter: false,
              textColor: textColor,
            ),
          ),
          SizedBox(height: height2),
          const Center(
            child: TextWidget(
              text: "Add your Information to show Patients",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              isTextCenter: false,
              textColor: textColor,
            ),
          ),
          SizedBox(height: height1),
         const _SectionTitle(title: "Speciality"),
          SizedBox(height: height2),
          const SpecialityDropdown(),
          SizedBox(height: height1),
          const _SectionTitle(title: "Years of Experience"),
          SizedBox(height: height2),
          InputField(
            inputController: signInProvider.yearsOfExperienceC,
            hintText: "Enter Experience",
            type: TextInputType.number,
          ),
          SizedBox(height: height1),
          const _SectionTitle(title: "Availability Time"),
          SizedBox(height: height2),
           DoctorAppointmentTimeSection(),
          SizedBox(height: height1),
         const _SectionTitle(title: "Video Consultation Fee (MAD)"),
          SizedBox(height: height2),
          InputField(
            inputController: signInProvider.appointmentFeeC,
            hintText: "Enter Video Consultation Fee",
            type: TextInputType.number,
          ),

          SizedBox(height: height1),
          const _SectionTitle(title: "In-Office Consultation Fee (MAD)"),
          SizedBox(height: height2),
          InputField(
            inputController: signInProvider.inOfficeFeeC,
            hintText: "Enter In-Office Consultation Fee",
            type: TextInputType.number,
          ),
          SizedBox(height: height1),

          const _SectionTitle(title: "Home Visit Consultation Fee (MAD)"),
          SizedBox(height: height2),
          InputField(
            inputController: signInProvider.homeVisitFeeC,
            hintText: "Enter Home Visit Consultation Fee",
            type: TextInputType.number,
          ),
          SizedBox(height: height1),

         const _SectionTitle(title: "Speciality Detail"),
          SizedBox(height: height2),
          InputField(
            inputController: signInProvider.specialityDetailC,
            hintText: "Enter the Detail on your Speciality",
            maxLines: 6,
          ),
          SizedBox(height: height1),
          SubmitButton(
            title: "Next",
            press: () {
              if (formKey.currentState!.validate()) {
                if (signInProvider.appointmentFrom != null && signInProvider.appointmentTo != null) {
                  Get.to(DoctorExperienceInfoScreen());
                } else {
                  ToastMsg().toastMsg("Enter the Availability Time");
                }
              }
            },
          ),
          SizedBox(height: height1),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextWidget(
      text: title,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      isTextCenter: false,
      textColor: textColor,
      fontFamily: AppFonts.semiBold,
    );
  }
}
