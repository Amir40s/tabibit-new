import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../Providers/actionProvider/country_code_picker.dart';
import '../../../constant.dart';

class PhoneNumberWidget extends StatelessWidget {
  final double? radius;
  final TextEditingController? controller;
  Color? fillColor;

  PhoneNumberWidget({super.key, this.radius, this.controller, this.fillColor});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDarkMode = brightness == Brightness.dark;
    return Consumer<CountryPickerProvider>(
      builder: (context, phoneNumberProvider, child) {
        return Container(
          width: double.infinity,
          child: Theme(
            data: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
                labelStyle: TextStyle(fontSize: 16, color: isDarkMode ? Colors.white : Colors.black),
              ),
              textTheme: TextTheme(
                bodyMedium: TextStyle(color: isDarkMode ?  Colors.white : Colors.black),
              ),
            ),
            child: IntlPhoneField(
              controller: controller,
              focusNode: phoneNumberProvider.phoneNumberFocusNode,
              initialCountryCode: 'MA',
              onChanged: (phone) {
                phoneNumberProvider.updatePhoneNumber(phone.completeNumber ?? '');
              },
              onCountryChanged: (country) {
                log('Country changed to: ' + country.name);
              },
              decoration: InputDecoration(
                hintText: 'Enter Phone Number...',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10),
                  borderSide: const BorderSide(color: greyColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10),
                  borderSide: const BorderSide(color: themeColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10),
                  borderSide:const  BorderSide(color: themeColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                fillColor: fillColor ?? Colors.grey.shade800,
                prefixIcon: const Icon(
                  Icons.phone,
                  color: Colors.grey,
                  size: 26,
                ),
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              keyboardType: TextInputType.phone,
              cursorColor: themeColor,
            ),
          ),
        );
      },
    );
  }
}
