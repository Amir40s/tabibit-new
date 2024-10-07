import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/Screens/PatientScreens/SpecificDoctorScreen/specific_doctor_screen.dart';

import '../../../../../constant.dart';
import '../../../../../model/res/constant/app_fonts.dart';
import '../../../../../model/res/widgets/text_widget.dart';
import '../../../../Providers/FindDoctor/find_doctor_provider.dart';
import '../../../../Providers/PatientHome/patient_home_provider.dart';
import '../../../../model/data/specialize_model.dart';
import '../../../../model/res/constant/app_icons.dart';

class SpecialitySection extends StatelessWidget {
  SpecialitySection({super.key});

  final List<Map<String,String>> options = [
    {
      "title" : "Surgeon",
      "subTitle" : "120 doctors",
      "image" : AppIcons.surgeonIcon,
    },
    {
      "title" : "Physician",
      "subTitle" : "132 doctors",
      "image" : AppIcons.physicianIcon,
    },
    {
      "title" : "Pediatrician",
      "subTitle" : "140 doctors",
      "image" : AppIcons.pediatricianIcon,
    },
    {
      "title" : "Gynecologist ",
      "subTitle" : "210 doctors",
      "image" : AppIcons.gynecologistIcon,
    },
    {
      "title" : "Cardiologist ",
      "subTitle" : "200 doctors",
      "image" : AppIcons.cardiologistIcon,
    },
    {
      "title" : "Dermatologist ",
      "subTitle" : "220 doctors",
      "image" : AppIcons.dermatologistIcon,
    },
    {
      "title" : "Neurologist",
      "subTitle" : "200 doctors",
      "image" : AppIcons.neurologistIcon,
    },
    {
      "title" : "Psychiatrist",
      "subTitle" : "240 doctors",
      "image" : AppIcons.psychiatristIcon,
    },
    {
      "title" : "Oncologist",
      "subTitle" : "140 doctors",
      "image" : AppIcons.oncologistIcon,
    },
    {
      "title" : "Radiologist",
      "subTitle" : "110 doctors",
      "image" : AppIcons.radiologistIcon,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final findDoctorP = Provider.of<FindDoctorProvider>(context, listen: false);
    return StreamBuilder<List<SpecializeModel>>(
      stream: findDoctorP.fetchSpeciality(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No specialities found'));
        }

        // List of users
        final specs = snapshot.data!;

        return Consumer<FindDoctorProvider>(
          builder: (context, value, child) {
            return GridView.builder(
              shrinkWrap:true,
              padding: const EdgeInsets.symmetric(vertical: 10),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 160,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20
              ),
              itemCount: specs.length,
              itemBuilder: (context, index) {
                final spec = specs[index];
                final isSelected = value.selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    value.setDoctorCategory(index,spec.id,spec.specialty);
                    Get.to(()=>SpecificDoctorScreen(specialityName: spec.specialty,));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? themeColor : bgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: isSelected ? themeColor : greyColor
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(13),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: isSelected ? themeColor : greenColor
                              )
                          ),
                          child: SvgPicture.asset(AppIcons.surgeonIcon),
                        ),
                        const SizedBox(height: 5,),
                        TextWidget(
                          text: spec.specialty, fontSize: 12,
                          fontWeight: FontWeight.w600, isTextCenter: false,
                          textColor: isSelected ? bgColor : textColor,
                          fontFamily: AppFonts.semiBold,),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                                text: "", fontSize: 12,
                                fontWeight: FontWeight.w400, isTextCenter: false,
                                textColor: isSelected ? greyColor : textColor),
                            const SizedBox(width: 5,),
                            Icon(Icons.arrow_forward_outlined,
                              color: isSelected ? bgColor : textColor,size: 14,)
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },);
      },);
  }
}
