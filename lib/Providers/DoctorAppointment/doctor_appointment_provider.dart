import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';
import '../../model/data/appointment_model.dart';

class DoctorAppointmentProvider extends ChangeNotifier{

  int _selectedIndex = 0;
  String _selectedAppointmentStatus = "All";
  String _selectedDate = "";

  int get selectedIndex => _selectedIndex;
  String get selectedAppointmentStatus => _selectedAppointmentStatus;
  String get selectedDate => _selectedDate;

  void selectButton(int index,String status) {
    _selectedIndex = index;
    _selectedAppointmentStatus = status;
    log(_selectedAppointmentStatus);
    notifyListeners();
  }

  void selDate(DateTime date) {
    String formattedDate = DateFormat('EEEE, MMMM d').format(date);
    _selectedDate = formattedDate;
    log("**********$_selectedDate************");
    notifyListeners();
  }

  Stream<List<AppointmentModel>> fetchPatients() {

    if(_selectedDate.isEmpty){
      return fireStore.collection('appointment')
          .where("doctorId",isEqualTo: auth.currentUser!.uid)
          .where("status",isEqualTo: _selectedAppointmentStatus)
          .snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => AppointmentModel.fromDocumentSnapshot(doc)).toList();
      });
    }
    else{
      return fireStore.collection('appointment')
          .where("doctorId",isEqualTo: auth.currentUser!.uid)
          .where("status",isEqualTo: _selectedAppointmentStatus)
          .where("appointmentDate",isEqualTo: _selectedDate)
          .snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => AppointmentModel.fromDocumentSnapshot(doc)).toList();
      });
    }
  }

  Stream<List<AppointmentModel>> fetchPatientsSingle() {
    log("Doctor id is:: ${auth.currentUser!.uid}");
    return fireStore.collection('appointment')
        .where("doctorId",isEqualTo: auth.currentUser!.uid)
        .where("status",isEqualTo: "upcoming")
        .snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => AppointmentModel.fromDocumentSnapshot(doc)).toList();
    });
  }

  // Stream<List<AppointmentModel>> fetchAllPatients() {
  //   return fireStore
  //       .collection('appointment')
  //       .where("doctorId", isEqualTo: auth.currentUser!.uid)
  //       .snapshots()
  //       .map((snapshot) {
  //     // Filter locally on 'status' to exclude 'Requesting'
  //     return snapshot.docs
  //         .where((doc) => doc['status'] != 'Requesting')
  //         .map((doc) => AppointmentModel.fromDocumentSnapshot(doc))
  //         .toList();
  //   });
  // }

  Stream<List<AppointmentModel>> fetchAllPatients({int? limit}) {
    var query = fireStore
        .collection('appointment')
        .where("doctorId", isEqualTo: auth.currentUser!.uid)
        .where('status', isNotEqualTo: 'Requesting');

    // Apply the limit if it's passed
    if (limit != null) {
      query = query.limit(limit);
    }

    return query.snapshots().map((snapshot) {
      var appointments = snapshot.docs
          .map((doc) => AppointmentModel.fromDocumentSnapshot(doc))
          .toList();

      // Apply client-side filtering based on selected date
      if (_selectedDate.isNotEmpty) {
        appointments = appointments.where((appointment) {
          return appointment.appointmentDate == _selectedDate;
        }).toList();
      }

      return appointments;
    });
  }




}