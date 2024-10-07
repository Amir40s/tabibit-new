import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../model/data/appointment_model.dart';

class MyAppointmentProvider extends ChangeNotifier{

  String _filterValue = "";
  String? _appointmentStatus = "pending";

  String get filterValue => _filterValue;
  String? get appointmentStatus => _appointmentStatus;


  filterAppointment(value){
    _filterValue = value;
    notifyListeners();
  }

  setAppointmentStatus(value){
    _appointmentStatus = value;
    notifyListeners();
  }

  cancelAppointment(String id)async{
    await fireStore.collection("appointment").doc(id).update({
      "status" : "cancel"
    });
  }

  Stream<List<AppointmentModel>> fetchMyAppointment() {
    return fireStore.collection('appointment')
        .where("patientId",isEqualTo: auth.currentUser!.uid)
        .where("status",isEqualTo: _appointmentStatus)
        .snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => AppointmentModel.fromDocumentSnapshot(doc)).toList();
    });
  }

  Stream<List<AppointmentModel>> fetchFilterAppointment() {
    return fireStore.collection('appointment')
        .where("patientId", isEqualTo: auth.currentUser!.uid)
        .where("status", isEqualTo: _appointmentStatus)
        .snapshots()
        .map((snapshot) {
      // Fetch appointments and filter by doctorName locally (case-insensitive)
      return snapshot.docs
          .map((doc) => AppointmentModel.fromDocumentSnapshot(doc))
          .where((appointment) =>
          appointment.doctorName.toLowerCase().startsWith(_filterValue.toLowerCase()))
          .toList();
    });
  }

}