import 'package:flutter/material.dart';

import '../../constant.dart';

class DoctorHomeProvider extends ChangeNotifier {

  int _numberOfPatients = 0;
  int _numberOfReminders = 0;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  int get numberOfPatients => _numberOfPatients;
  int get numberOfReminders => _numberOfReminders;
  DateTime? get selectedStartDate => _selectedStartDate;
  DateTime? get selectedEndDate => _selectedEndDate;

  void selectDateRange(DateTime start, DateTime end) {
    _selectedStartDate = start;
    _selectedEndDate = end;
    notifyListeners();
  }

  void clearRange() {
    _selectedStartDate = null;
    _selectedEndDate = null;
    notifyListeners();
  }

  void setNumberOfPatients(){
    fireStore.collection('appointment')
        .where("doctorId",isEqualTo: auth.currentUser!.uid)
        .snapshots().listen((snapshot) {
      _numberOfPatients = snapshot.docs.length; // Get the length of the documents
      notifyListeners(); // Notify listeners to rebuild widgets when data changes
    });
  }
  void setNumberOfReminders(){
    fireStore.collection('appointmentReminder')
        .where("userUid",isEqualTo: auth.currentUser!.uid)
        .snapshots().listen((snapshot) {
      _numberOfReminders = snapshot.docs.length; // Get the length of the documents
      notifyListeners(); // Notify listeners to rebuild widgets when data changes
    });
  }

}
