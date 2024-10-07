import 'package:flutter/material.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import '../../../../constant.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../../model/res/widgets/text_widget.dart';
import 'Components/diagonistic_section.dart';
import 'Components/speciality_section.dart';

class DoctorSpecialityScreen extends StatelessWidget {
  const DoctorSpecialityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(text: "Doctor Speciality"),
            Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SpecialitySection(),
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                    //   child: TextWidget(
                    //     text: "Diagnostics & Tests", fontSize: 20,
                    //     fontWeight: FontWeight.w600, isTextCenter: false,
                    //     textColor: textColor, fontFamily: AppFonts.semiBold,),
                    // ),
                    // const SizedBox(height: 20,),
                    // // const DiagnosticSection(),
                    // const SizedBox(height: 20,),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
