import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/constant/app_fonts.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import '../../../../Providers/SignIn/sign_in_provider.dart';
import '../../../../constant.dart';

class SpecialityDropdown extends StatelessWidget {
  const SpecialityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.grey.withOpacity(0.4),
                  width: 1
              )
          ),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("doctorsSpecialty").snapshots(),
              builder: (context,snapshot){
                List<DropdownMenuItem> spcItems = [];
                if(!snapshot.hasData){
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  );
                }else{
                  final categories = snapshot.data!.docs.reversed.toList();

                  for(var category in categories){
                    spcItems.add(DropdownMenuItem(
                        value: category.id,
                        child: Text(category["specialty"])));
                  }
                }
                return DropdownButton(
                    hint: TextWidget(
                        text: "Select Speciality",
                        fontSize: 14.sp,fontFamily: AppFonts.medium,
                        fontWeight: FontWeight.w600, isTextCenter: false,
                        textColor: greyColor
                    ),
                    style: TextStyle(
                        fontFamily: AppFonts.medium,
                        fontSize: 14.sp,
                        color: textColor
                    ),
                    value: provider.specialityId,
                    isExpanded: true,
                    dropdownColor: bgColor,
                    borderRadius: BorderRadius.circular(10),
                    icon: const Icon(CupertinoIcons.chevron_down,size: 15,),
                    underline: const SizedBox(),
                    items: spcItems,
                    onChanged: (value){
                      provider.setSpeciality(value);
                    });
              }
          ),
        );
      },);
  }
}


// setState(() {
//   selectedId = newValue;
//   selectedName = snapshot.data!.docs
//       .firstWhere((doc) => doc['id'] == newValue)['name']; // Store the selected name
// });

// print('Selected ID: $selectedId');
// print('Selected Name: $selectedName');