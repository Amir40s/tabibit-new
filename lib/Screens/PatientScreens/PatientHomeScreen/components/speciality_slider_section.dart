import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/Language/new/translation_new_provider.dart';
import 'package:tabibinet_project/Providers/translation/translation_provider.dart';
import 'package:tabibinet_project/Screens/PatientScreens/SpecificDoctorScreen/specific_doctor_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/controller/doctor/appdata_provider.dart';
import 'package:tabibinet_project/model/data/specialize_model.dart';
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
    final appData = Provider.of<AppDataProvider>(context,listen: false);

    return SizedBox(
      height: 78,
      width: 100.w,
      child: Consumer<TranslationNewProvider>(
       builder: (context,provider,child){
         return StreamBuilder<List<SpecializeModel>>(
             stream: docp.fetchSpeciality(), // Assume this is the stream of specialties
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
               }

               if (!snapshot.hasData || snapshot.data!.isEmpty) {
                 return const Center(child: Text('No specialties found'));
               }

               final specs = snapshot.data!;

               // Translate the specialties only once when available
               if (provider.translatedTexts.isEmpty) {
                 provider.translateMultiple(specs.map((e) => e.specialty).toList());
               }

               return ListView.builder(
                 padding: const EdgeInsets.only(left: 20),
                 shrinkWrap: true,
                 scrollDirection: Axis.horizontal,
                 itemCount: specs.length,
                 itemBuilder: (context, index) {
                   final spec = specs[index];
                   final translatedText = provider.translatedTexts[spec.specialty] ?? spec.specialty;

                   return GestureDetector(
                     onTap: () {
                       Get.to(() => SpecificDoctorScreen(specialityName: translatedText));
                       appData.setDoctorCategory(index, spec.id, spec.specialty);
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
             });
       },
      ),
    );
  }
}
