import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/controller/audioController.dart';
import 'package:tabibinet_project/model/res/appUtils/appUtils.dart';
import 'package:tabibinet_project/model/res/widgets/input_field.dart';
import 'package:tabibinet_project/model/res/widgets/submit_button.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../../Providers/bankDetails/bank_details_provider.dart';
import '../../model/res/widgets/header.dart';

class AddBankDetailsScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardExpiryController = TextEditingController();
  final TextEditingController cardCVVController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BankDetailsProvider>(context);

    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.all(5.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Header(text: "Add Bank Detail",),
              SizedBox(height: 3.h,),
              Container(
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: DropdownButton<String>(
                  value: provider.selectedType,
                  dropdownColor: themeColor, // Changes the dropdown menu background color
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white), // Customize the dropdown icon color
                  isExpanded: true, // Ensure the dropdown expands to full width
                  underline: SizedBox(), // Removes the underline
                  style: TextStyle(
                    color: Colors.white, // Sets the color of the selected item
                    fontSize: 16.sp, // Adjust font size if needed
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'Bank Account',
                      child: Text(
                        'Bank Account',
                        style: TextStyle(
                          color: Colors.white, // Sets the color of dropdown item text to white
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Debit/Credit Card',
                      child: Text(
                        'Debit/Credit Card',
                        style: TextStyle(
                          color: Colors.white, // Sets the color of dropdown item text to white
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      provider.setSelectedType(value);
                    }
                  },
                ),
              ),

              SizedBox(height: 2.h),

              if (provider.selectedType == 'Bank Account') ...[
                InputField(
                  inputController: bankNameController,
                  hintText: "Bank Name",
                ),
                SizedBox(height:2.h),
                InputField(
                  inputController: accountNumberController,
                  hintText: "Bank Account Number",
                ),
              ] else
                if (provider.selectedType == 'Debit/Credit Card') ...[
                  InputField(
                    inputController: cardNumberController,
                    hintText: "Card Number",
                  ),
                  SizedBox(height:2.h),
                  InputField(
                    inputController: cardExpiryController,
                    hintText: "Expire Date",
                  ),
                  SizedBox(height:2.h),
                  InputField(
                    inputController: cardCVVController,
                    hintText: "CVV",
                  ),
                ],

              SizedBox(height: 10.h),

             SubmitButton(
                 width: 80.w,
                 title: "Save Now", press: (){
               if (_formKey.currentState!.validate()) {
                 Map<String, dynamic> details = provider.selectedType ==
                     'Bank Account'
                     ? {
                   'bankName': bankNameController.text,
                   'accountNumber': accountNumberController.text,
                   'type': 'Bank Account',
                 } : {
                   'cardNumber': cardNumberController.text,
                   'expiryDate': cardExpiryController.text,
                   'cvv': cardCVVController.text,
                   'type': 'Debit/Credit Card',
                 };

                 provider.saveDetails(details).then((_) {
                   ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(content: Text('Details Saved')));
                 });
               }
             }
             ),
            ],
          ),
        ),
      ),
    );
  }
}