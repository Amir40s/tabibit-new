import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tabibinet_project/Providers/Profile/profile_provider.dart';
import 'dart:developer';

import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

class ForgotProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String _name = '';
  String _email = '';
  String _password = '';
  String _phoneNumber = '';

  // Getters
  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get phoneNumber => _phoneNumber;


  bool _isPasswordVisible = false;
  bool _isPasswordConfirmVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isPasswordConfirmVisible => _isPasswordConfirmVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void togglePasswordConfirmVisibility() {
    _isPasswordConfirmVisible = !_isPasswordConfirmVisible;
    notifyListeners();
  }

  // void clear and reset
  void clearAndReset() {
    _isPasswordVisible = false;
    _isPasswordConfirmVisible = false;
    notifyListeners();
  }
  // Setters
  void setUserData({required String name, required String email, required String password}) {
    _name = name;
    _email = email;
    _password = password;
    notifyListeners();
  }

  Future<bool> checkPhoneNumberExistsAndFetchData(
      String phoneNumber) async {
    try {
      var userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        var userData = userSnapshot.docs.first.data();
        _name = userData['name'] ?? '';
        _email = userData['email'] ?? '';
        _phoneNumber = userData['phoneNumber'] ?? '';
        _password = userData['password'] ?? '';
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Error checking phone number and fetching data: $e");
      return false;
    }
  }

  Future<void> changePassword({
    required String newPassword,
  }) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        AuthCredential credential = EmailAuthProvider.credential(
          email: _email,
          password: _password,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(newPassword);
        await updatePasswordField(password: newPassword);
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> updatePasswordField({required String password}) async{

   await fireStore.collection("users").doc(auth.currentUser?.uid).update({
      "password" : password
    }).whenComplete((){
      ToastMsg().toastMsg("Password Update Successfully");
      clearData();
      _firebaseAuth.signOut();
      // Get.offAll();
    });

  }

  // clear all data
  void clearData() {
    _name = '';
    _email = '';
    _password = '';
    _phoneNumber = '';
    notifyListeners();
  }

}

