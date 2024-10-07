import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/controller/audioController.dart';

import '../../constant.dart';
import '../../model/res/constant/app_fonts.dart';
import '../../model/res/widgets/input_field.dart';
import '../../model/res/widgets/text_widget.dart';

class DoctorAddPaymentScreen extends StatelessWidget {
   DoctorAddPaymentScreen({super.key});

  final nameC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 2.h
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h,width: 100.w,),
            Container(
              width: 100.w,
              child: const TextWidget(
                text: "Add Bank Details", fontSize: 18,
                fontWeight: FontWeight.w600, isTextCenter: true,
                align: TextAlign.center,
                textColor: Colors.black,fontFamily: AppFonts.semiBold,),
            ),
            SizedBox(height: 2.h,width: 100.w,),
            const TextWidget(
              text: "Bank Name", fontSize: 14,
              fontWeight: FontWeight.w600, isTextCenter: false,
              textColor: Colors.black,fontFamily: AppFonts.semiBold,),
            SizedBox(height: 1.h,),
            InputField(
              inputController: nameC,
              hintText: "Enter Bank Name",
            ),

            SizedBox(height: 1.h,),
            const TextWidget(
              text: "IBAN", fontSize: 14,
              fontWeight: FontWeight.w600, isTextCenter: false,
              textColor: Colors.black,fontFamily: AppFonts.semiBold,),
            SizedBox(height: 1.h,),
            InputField(
              inputController: nameC,
              hintText: "Enter IBAN",
            ),

            SizedBox(height: 1.h,),
            const TextWidget(
              text: "Branch Code", fontSize: 14,
              fontWeight: FontWeight.w600, isTextCenter: false,
              textColor: Colors.black,fontFamily: AppFonts.semiBold,),
            SizedBox(height: 1.h,),
            InputField(
              inputController: nameC,
              hintText: "Enter branch Code",
            ),
          ],
        ),
      ),
    );
  }
}
