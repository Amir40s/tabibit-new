import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/LabReport/lab_report_provider.dart';
import 'package:tabibinet_project/Providers/Medicine/medicine_provider.dart';
import 'package:tabibinet_project/Screens/SuccessScreen/success_screen.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/dotted_border_container.dart';
import 'package:tabibinet_project/model/res/widgets/header.dart';

import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class UploadReportFileScreen extends StatelessWidget {
  const UploadReportFileScreen({
    super.key,
    required this.appointmentId
  });

  final String appointmentId;

  @override
  Widget build(BuildContext context) {
    final medP = Provider.of<MedicineProvider>(context,listen: false);
    double height1 = 20.0;
    double height2 = 10.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            const Header(text: "Send Report"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height1,),
                  TextWidget(
                    text: "Upload Document", fontSize: 14.sp,
                    fontWeight: FontWeight.w600, isTextCenter: false,
                    textColor: textColor, fontFamily: AppFonts.semiBold,),
                  SizedBox(height: height2,),
                  Consumer<MedicineProvider>(
                      builder: (context, value, child) {
                        return InkWell(
                          onTap: () {
                            value.pickFile();
                          },
                          child: DottedBorderContainer(
                              width: 100.w,
                              height: 8.h,
                              borderColor: greyColor,
                              strokeWidth: 1.5,
                              dashWidth: 10,
                              borderRadius: 15,
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  const Icon(Icons.attach_file_outlined,color: themeColor,),
                                  SizedBox(
                                    width: value.selectedFilePath != null ? 60.w : 19.w,
                                    child: TextWidget(
                                        text: value.selectedFilePath != null ? "${value.selectedFilePath}"
                                            : "Add a file",
                                        maxLines: 1,
                                        fontFamily: AppFonts.medium,
                                        fontSize: 16.sp, fontWeight: FontWeight.w500,
                                        isTextCenter: false, textColor: themeColor),
                                  ),
                                  value.selectedFilePath == null ? TextWidget(
                                      text: " or drop it here",
                                      fontFamily: AppFonts.medium,
                                      fontSize: 16.sp, fontWeight: FontWeight.w500,
                                      isTextCenter: false, textColor: textColor)
                                      : const SizedBox(),
                                ],
                              )
                          ),
                        );
                    },),
                  SizedBox(height: height2,),
                  TextWidget(
                      text: "File should be pdf, docs or ppt", fontSize: 12.sp,
                      fontWeight: FontWeight.w500, isTextCenter: false,
                      textColor: textColor, fontFamily: AppFonts.regular,),
                  SizedBox(height: height1,),
                  Consumer<MedicineProvider>(
                    builder: (context, value, child) {
                      return value.isLoading ?
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ) :
                      SubmitButton(
                        title: "Send Document to Micheal",
                        press: () {
                          value.addFile(appointmentId)
                              .whenComplete(() {
                            Get.off(()=>const SuccessScreen(
                                title: "Document Sent Successfully!",
                                subTitle: "Document has been sent to the patient"));
                          },);
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
