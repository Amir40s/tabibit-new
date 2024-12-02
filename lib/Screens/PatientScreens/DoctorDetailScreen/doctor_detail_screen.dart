import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../constant.dart';
import '../../../../model/res/widgets/header.dart';
import '../../../Providers/Language/new/translation_new_provider.dart';
import '../../../controller/translation_controller.dart';
import '../../../model/data/user_model.dart';
import 'Components/about_section.dart';
import 'Components/info_section.dart';

class DoctorDetailScreen extends StatelessWidget {
  const DoctorDetailScreen({
    super.key,
    required this.doctorName,
    required this.specialityName,
    required this.doctorDetail,
    required this.yearsOfExperience,
    required this.patients,
    required this.reviews,
    required this.image,
    required this.model,
  });

  final String doctorName;
  final String specialityName;
  final String doctorDetail;
  final String yearsOfExperience;
  final String patients;
  final String reviews;
  final String image;
  final UserModel model;

  @override
  Widget build(BuildContext context) {
    final providerP = Provider.of<TranslationNewProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryGreenColor,
        body: Column(
          children: [
            const Header(text: ""),
            Flexible(
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: skyBlueColor,
                    ),
                    child: Column(
                      children: [
                        Image.network(image,width: 100.w,height: 50.h,),
                      ],
                    ),
                  ),
                  InfoSection(
                    doctorName: providerP.translations[doctorName] ?? doctorName,
                    specialityName: providerP.translatedTexts[specialityName] ?? specialityName,
                    yearsOfExperience: yearsOfExperience,
                    patients: patients,
                    reviews: reviews,
                    model: model,
                  ),
                  AboutSection(
                    doctorDetail: providerP.translations[doctorDetail] ?? doctorDetail,
                    image: image,
                    model: model,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
