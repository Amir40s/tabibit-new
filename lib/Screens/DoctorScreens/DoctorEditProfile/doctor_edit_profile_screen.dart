import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Providers/Profile/profile_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/image_loader.dart';
import '../../../model/res/widgets/input_field.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class DoctorEditProfileScreen extends StatelessWidget {
  const DoctorEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final profileP = Provider.of<PatientProfileProvider>(context,listen: false);
    double height1 = 20;
    double height2 = 10;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Edit Profile"),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Consumer<ProfileProvider>(
                    builder: (context, value, child) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            Get.bottomSheet(
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                      color: bgColor,
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SubmitButton(
                                        title: "Gallery",
                                        press: () {
                                          value.pickImage();
                                        },),
                                      const SizedBox(height: 20,),
                                      SubmitButton(
                                        title: "Camera",
                                        press: () {
                                          value.pickImageFromCamera();
                                        },),
                                    ],
                                  ),
                                )
                            );
                          },
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: const BoxDecoration(
                                        color: greyColor,
                                        shape: BoxShape.circle
                                    ),
                                    child: value.image != null ?
                                    Image.file(value.image!,fit: BoxFit.cover,) :
                                    ImageLoaderWidget(imageUrl: value.profileUrl)
                                  // value.image != null ? Image.file(
                                  //   value.image!,
                                  //   fit: BoxFit.cover,)
                                  //     : const SizedBox(),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(10.sp),
                                decoration: const BoxDecoration(
                                    color: themeColor,
                                    shape: BoxShape.circle
                                ),
                                child: const Icon(Icons.camera_alt_outlined,color: bgColor,),
                              )
                            ],
                          ),
                        ),
                      );
                    },),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "Full Name", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  Consumer<ProfileProvider>(
                    builder: (context, value, child) {
                      return InputField(
                        inputController: value.nameC,
                        hintText: "Enter name",
                      );
                    },),
                  SizedBox(height: height1,),
                  const TextWidget(
                    text: "Date of Birth", fontSize: 14,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  Consumer<ProfileProvider>(
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () async {
                          DateTime? picked = await showDatePicker(
                              context: context,
                              firstDate: DateTime(1980),
                              lastDate: DateTime.now()
                          );
                          if (picked != null) {
                            // Update the selected date in the Provider
                            value.setDate(picked);
                          }
                        },
                        child: Container(
                          width: 100.w,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: greyColor
                              )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: value.dateOfBirth, fontSize: 12,
                                fontWeight: FontWeight.w600, isTextCenter: false,
                                textColor: textColor, fontFamily: AppFonts.medium,),
                              const Icon(Icons.calendar_month_rounded,color: greyColor,)
                            ],
                          ),
                        ),
                      );
                    },),
                  SizedBox(height: height1,),
                  Consumer<ProfileProvider>(
                    builder: (context, value, child) {
                      return value.isLoading ?
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ) :
                      SubmitButton(
                        title: "Save Changes",
                        press: () {
                          if(value.image != null){
                            value.updateProfileWithImage();
                          }else{
                            value.updateProfile();
                          }
                        },);
                    },)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
