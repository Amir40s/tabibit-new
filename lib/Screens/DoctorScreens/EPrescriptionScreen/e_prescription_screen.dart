import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/constant/app_icons.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';

import '../CheckInteractionScreen/check_interaction_screen.dart';
import '../DosageCalculatorScreen/dosage_calculator_screen.dart';
import '../MedicationLookupScreen/medication_lookup_screen.dart';
import '../PrescribeMedicineScreen/prescribe_medicine_screen.dart';
import 'Components/prescription_container.dart';

class EPrescriptionScreen extends StatelessWidget {
  const EPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "E-Prescriptions"),
            Expanded(
              child: GridView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 20.h,
                    crossAxisSpacing: 10
                  ),
                  children: [
                    PrescriptionContainer(
                        text: "Check Interaction",
                        icon: AppIcons.checkInteractionIcon,
                        boxColor: const Color(0xff45D0EE),
                        onTap: () {
                          Get.to(()=>CheckInteractionScreen());
                        },
                    ),
                    PrescriptionContainer(
                        text: "Calculate Dosage",
                        icon: AppIcons.calculateDosageIcon,
                        boxColor: const Color(0xffF24C0F),
                        onTap: () {
                          Get.to(()=>DosageCalculatorScreen());
                        },
                    ),
                    PrescriptionContainer(
                      text: "Prescribe Medicine",
                      icon: AppIcons.calculateDosageIcon,
                      boxColor: const Color(0xffDEBA05),
                      onTap: () {
                        Get.to(()=>PrescribeMedicineScreen(
                          isVisible: true,
                          appointmentId: "",
                        ));
                      },
                    ),
                    PrescriptionContainer(
                      text: "Medication Lookup",
                      icon: AppIcons.calculateDosageIcon,
                      boxColor: const Color(0xff0596DE),
                      onTap: () {
                        Get.to(()=>MedicationLookupScreen());
                      },
                    ),
                  ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

