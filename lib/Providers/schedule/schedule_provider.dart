import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tabibinet_project/model/services/FirebaseServices/firestore_services.dart';

import '../../model/data/schedule_model.dart';

class ScheduleProvider extends ChangeNotifier{
  final FireStoreServices _firestoreService = FireStoreServices();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<ScheduleItem> _schedules = [];
  int _currentIndex = 0;

  ScheduleProvider() {
    _firestoreService.getSchedules().listen((schedules) {
      _schedules = schedules;
      notifyListeners();
    });
  }

  Stream<List<ScheduleItem>> get schedules => _firestoreService.getSchedules();

  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    log("index:: $_currentIndex");
    notifyListeners();
  }



}