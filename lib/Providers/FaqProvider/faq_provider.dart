import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tabibinet_project/model/data/faq_model.dart';

import '../../constant.dart';

class FaqProvider extends ChangeNotifier{

  int? _selectFaq;
  int? _selectFaqCat;

  int? get selectFaq => _selectFaq;
  int? get selectFaqCat => _selectFaqCat;

  setFaq(index){
    _selectFaq = index;
    notifyListeners();
  }

  setFaqCat(int index){
    _selectFaqCat = index;
    notifyListeners();
  }

  Stream<List<FaqModel>> fetchFaq() {
    return fireStore.collection('faq')
        .snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => FaqModel.fromDocumentSnapshot(doc)).toList();
    });
  }

}