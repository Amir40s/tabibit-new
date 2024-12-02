import 'package:flutter/material.dart';

class CountryPickerProvider with ChangeNotifier {
  String _enteredPhoneNumber = '';
  FocusNode _phoneNumberFocusNode = FocusNode();

  String get enteredPhoneNumber => _enteredPhoneNumber;
  FocusNode get phoneNumberFocusNode => _phoneNumberFocusNode;

  void updatePhoneNumber(String phoneNumber) {
    _enteredPhoneNumber = phoneNumber;
    notifyListeners();
  }

  void dispose() {
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }
}
