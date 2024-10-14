import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:logger/logger.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../../Screens/SuccessScreen/success_screen.dart';
import '../../model/data/withdraw_request.dart';

class BankDetailsProvider extends ChangeNotifier {
  String _selectedType = 'Bank Account'; // Default selection
  String get selectedType => _selectedType;

  void setSelectedType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  Future<void> saveDetails(Map<String, dynamic> details) async {
    final String userID = auth.currentUser?.uid.toString() ?? "";
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('bankDetails')
        .add(details);
  }


  String? _selectedBankDetailId; // ID of the selected bank detail

  String? get selectedBankDetailId => _selectedBankDetailId;

  void setSelectedBankDetail(String? id) {
    _selectedBankDetailId = id;
    notifyListeners();
  }

  Stream<List<WithdrawRequest>> getWithdrawRequests() {
    return FirebaseFirestore.instance
        .collection('withdrawRequests')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => WithdrawRequest.fromFirestore(doc))
        .toList());
  }

  Future<void> submitWithdrawRequest(double amount) async {
    final String userID = auth.currentUser?.uid.toString() ?? "";
    final String withdrawID = FirebaseFirestore.instance.collection("withdrawRequests").doc().id;
    final provider = GlobalProviderAccess.profilePro;
    if (_selectedBankDetailId != null) {
      await FirebaseFirestore.instance
          .collection('withdrawRequests')
          .doc(withdrawID)
          .set({
        'bankDetailId': _selectedBankDetailId,
        'type': _selectedType,
        'amount': amount.toString(),
        'timestamp': FieldValue.serverTimestamp(),
        'userUID': userID,
        'status': "pending",
        'withdrawID': withdrawID,
        'name': provider!.name,
        'email': provider.email,
        'profile': provider.profileUrl,
        'speciality': provider.speciality,
      });

      if(provider !=null){
        double balance = double.parse(provider.balance);
        balance = balance - amount;
        await FirebaseFirestore.instance.collection("users")
        .doc(userID)
        .update({
          "balance" : balance.toString()
        });
        await provider.getSelfInfo();
      }else{
        var logger = Logger();
        logger.d("Profile Provider Null in Bank Details Provider");
      }
      Get.to(()=> SuccessScreen(
        title: "Transaction Successful",
        subTitle: "Your withdrawal has been successfully down\n\nTotal Withdrawn",
        title3: "${amount.toString()} MAD",
      ));

    }
  }
}
