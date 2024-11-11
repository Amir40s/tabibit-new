import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/data/schedule_model.dart';

class PatientHomeProvider extends ChangeNotifier{

  int? _currentOption;
  int? _currentExperience;
  int? _currentRating;
  int? _currentTime;
  int? _selectCancelReason;
  int _currentIndex = 0;
  bool _isFilter = false;
  DateTime _selectedDate = DateTime.now();
  String? _review;
  String? _selectedAppointmentType;

  int get currentIndex => _currentIndex;
  int? get currentOption => _currentOption;
  int? get currentExperience => _currentExperience;
  int? get currentRating => _currentRating;
  int? get currentTime => _currentTime;
  int? get selectCancelReason => _selectCancelReason;
  DateTime get selectedDate => _selectedDate;
  bool get isFilter => _isFilter;
  String? get review => _review;
  String? get selectedAppointmentType => _selectedAppointmentType;

  void selectReview(String review) {
    _review = review;
    notifyListeners();
  }

  setFilter(bool filter){
    _isFilter = filter;
    notifyListeners();
  }

  setIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }

  setOption(int index){
    _currentOption = index;
    notifyListeners();
  }

  setExperience(int index){
    _currentExperience = index;
    notifyListeners();
  }

  setRating(int index){
    _currentRating = index;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void selectTime(int index) {
    _currentTime = index;
    notifyListeners();
  }

  void setAppointmentType(String index) {
    _selectedAppointmentType = index;
    notifyListeners();
  }

  void setCancelReason(int index) {
    _selectCancelReason = index;
    notifyListeners();
  }

}

// **************** Calender Provider Class ****************

class DateProvider extends ChangeNotifier {
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void updateSelectedDate(DateTime date) {

    _selectedDate = date;
    log("Date::${date.toString()}");
    notifyListeners();
  }


  List<ScheduleItem> _schedulesData = [];
  int _currentScheduleIndex = 0;

  List<ScheduleItem> get schedulesData => _schedulesData;
  int get currentScheduleIndex => _currentScheduleIndex;

  // Fetch schedules from Firestore
  Future<void> fetchSchedulesData() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('bannerAds').get();
      _schedulesData = snapshot.docs.map((doc) => ScheduleItem.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
      notifyListeners();
    } catch (e) {
      log("Error fetching schedules: $e");
    }
  }

  void setScheduleIndex(int index) {
    _currentScheduleIndex = index;
    notifyListeners();
  }
}
