import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Screens/PatientScreens/SpecificDoctorScreen/specific_doctor_screen.dart';
import 'package:tabibinet_project/constant.dart';
import '../../../../controller/doctoro_specialiaty_controller.dart';
import '../../../../controller/translation_controller.dart';
import 'doctor_speciality_container.dart';
import '../../../../Providers/FindDoctor/find_doctor_provider.dart';
import '../../../../model/res/constant/app_icons.dart';

class SpecialitySliderSection extends StatelessWidget {
  const SpecialitySliderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final docp = Provider.of<FindDoctorProvider>(context,listen: false);
    final AppDataController findDoctorController = Get.put(AppDataController(docp));

    final TranslationController translationController = Get.put(TranslationController());

    return SizedBox(
      height: 78,
      width: 100.w,
      child: Obx(() {
        if (findDoctorController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (findDoctorController.specialties.isEmpty) {
          return const Center(child: Text('No specialties found'));
        }

        final specs = findDoctorController.specialties;

        // Translate the specialties only once when available
        if (translationController.translatedTexts.isEmpty) {
          translationController.translateMultiple(specs.map((e) => e.specialty).toList());
        }

        return ListView.builder(
          padding: const EdgeInsets.only(left: 20),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: specs.length,
          itemBuilder: (context, index) {
            final spec = specs[index];
            final translatedText = translationController.translatedTexts[spec.specialty] ?? spec.specialty;

            return GestureDetector(
              onTap: () {
                Get.to(() => SpecificDoctorScreen(specialityName: spec.specialty));
                findDoctorController.setDoctorCategory(index, spec.id, spec.specialty);
              },
              child: DoctorSpecialityContainer(
                title: translatedText,
                subTitle: "",
                icon: AppIcons.brainIcon,
                boxColor: bgColor,
              ),
            );
          },
        );
      }),
    );
  }
}
