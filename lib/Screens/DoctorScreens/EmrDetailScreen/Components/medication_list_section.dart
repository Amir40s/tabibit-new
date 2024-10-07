import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/constant/app_assets.dart';

import '../../../../constant.dart';
import '../../../../model/data/medicine_model.dart';
import '../../../../model/res/constant/app_fonts.dart';
import '../../../../model/res/constant/app_icons.dart';
import '../../../../model/res/widgets/text_widget.dart';
import '../../../PatientScreens/patient_medication_screen/patient_medication_screen.dart';

class MedicationListSection extends StatelessWidget {
  const MedicationListSection({
    super.key,
    required this.appointmentId,
    this.doctorName,
    this.isDel = true,
    this.onTap,
  });

  final String appointmentId;
  final String? doctorName;
  final bool isDel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double height1 = 20.0;
    double height2 = 10.0;
    return ListView(
      shrinkWrap: true,
      children: [
        TextWidget(
          text: "Medication List", fontSize: 18.sp,
          fontWeight: FontWeight.w600, isTextCenter: false,
          textColor: textColor, fontFamily: AppFonts.semiBold,),
        SizedBox(height: height1,),
        StreamBuilder<List<MedicineModel>>(
          stream: getMedicinesStream(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  Image.asset(AppAssets.medicineImage,height: 100,),
                  SizedBox(height: 20,),
                  Center(child: Text('No Medication Suggest'))
                ],
              );
            }

            // List of users
            final meds = snapshot.data!;

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: meds.length,
              itemBuilder: (context, index) {
                final med = meds[index];
                return InkWell(
                  onTap: (){
                    if(!isDel){
                      Get.to(()=> PatientMedicationScreen(
                        doctorName: doctorName ?? "",
                        medicineName: med.tabletName,
                        dose: med.dosage,
                        duration: med.duration,
                        repeat: med.repeat,
                        timeOfDay: med.timeDay,
                        taken: med.taken,
                      ));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: greyColor)
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      leading: SvgPicture.asset(AppIcons.radioOffIcon),
                      title: TextWidget(
                        text: med.tabletName, fontSize: 16.sp,
                        fontWeight: FontWeight.w500, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.medium,),
                      subtitle: TextWidget(
                        text: "Dosage: ${med.dosage} tablets", fontSize: 12.sp,
                        fontWeight: FontWeight.w400, isTextCenter: false,
                        textColor: textColor, fontFamily: AppFonts.regular,),
                      trailing: Visibility(
                        visible: isDel ?? true,
                        child: IconButton(
                            onPressed: () {
                              deleteMed(med.id);
                            },
                            icon: const Icon(CupertinoIcons.delete,color: textColor,)
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: height2,),
            );
          },),
      ],
    );
  }

  Stream<List<MedicineModel>> getMedicinesStream() {
    return fireStore
        .collection('appointment')
        .doc(appointmentId)
        .collection("prescription")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        // Pass document ID (doc.id) to the MedicineModel constructor
        return MedicineModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }


  Future<void> deleteMed(id) async{
    fireStore.collection("appointment")
        .doc(appointmentId)
        .collection("prescription")
        .doc(id).delete();
  }

}
