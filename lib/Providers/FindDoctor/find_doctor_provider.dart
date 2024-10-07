import 'dart:developer';
import 'package:flutter/cupertino.dart';

import '../../constant.dart';
import '../../model/data/specialize_model.dart';
import '../../model/data/user_model.dart';

class FindDoctorProvider extends ChangeNotifier{

  String _filterValue = "";
  String? _selectSpecialityId;
  String _selectDoctorCategory = "All";
  int? _selectedIndex;
  int _numberOfDoctors = 0;

  int? get selectedIndex => _selectedIndex;
  int get numberOfDoctors => _numberOfDoctors;
  String get filterValue => _filterValue;
  String? get selectDoctorId => _selectSpecialityId;
  String get selectDoctorCategory => _selectDoctorCategory;

  filterDoctor(value){
    _filterValue = value;
    notifyListeners();
  }

  void setDoctorCategory(int index,String categoryId,String category) {
    _selectedIndex = index;
    _selectSpecialityId = categoryId;
    _selectDoctorCategory = category;
    setNumberOfDoctors();
    log(categoryId);
    notifyListeners();
  }

  Stream<List<SpecializeModel>> fetchSpeciality() {
    return fireStore.collection('doctorsSpecialty')
        .orderBy("id",descending: true)
        .snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => SpecializeModel.fromDocumentSnapshot(doc)).toList();
    });
  }

  Stream<List<UserModel>> fetchSelectedCatDoc(String doctorCat) {
    if(_filterValue.isEmpty){
      return fireStore
          .collection('users')
          .where("userType", isEqualTo: "Health Professional")
          .where("specialityId", isEqualTo: doctorCat) // Example of another filter
          .snapshots()
          .map((snapshot) {
        // setNumberOfDoctors(snapshot.docs.map((doc) => UserModel.fromDocumentSnapshot(doc)).toList().length);
        return snapshot.docs.map((doc) => UserModel.fromDocumentSnapshot(doc)).toList();
      });
    }else{
      return fireStore
          .collection('users')
          .where("userType", isEqualTo: "Health Professional")
          .where("specialityId", isEqualTo: doctorCat) // Example of another filter
          .snapshots()
          .map((snapshot) {
        // setNumberOfDoctors(snapshot.docs.map((doc) => UserModel.fromDocumentSnapshot(doc)).toList().length);
        return snapshot.docs
            .map((doc) => UserModel.fromDocumentSnapshot(doc))
            .where((appointment) =>
            appointment.name.toLowerCase().startsWith(_filterValue.toLowerCase()))
            .toList();
      });
    }
  }

  // Stream to fetch users from FireStore
  Stream<List<UserModel>> fetchDoctors() {

    if(_filterValue.isEmpty){
      return fireStore.collection('users')
          .where( "userType", isEqualTo: "Health Professional")
          .snapshots().map((snapshot) {
        // setNumberOfDoctors(snapshot.docs.map((doc) => UserModel.fromDocumentSnapshot(doc)).toList().length);
        return snapshot.docs.map((doc) => UserModel.fromDocumentSnapshot(doc)).toList();
      });
    }else{

      return fireStore.collection('users')
          .where( "userType", isEqualTo: "Health Professional")
          .snapshots().map((snapshot) {
        // setNumberOfDoctors(snapshot.docs.map((doc) => UserModel.fromDocumentSnapshot(doc)).toList().length);
        return snapshot.docs
            .map((doc) => UserModel.fromDocumentSnapshot(doc))
            .where((appointment) =>
            appointment.name.toLowerCase().startsWith(_filterValue.toLowerCase()))
            .toList();
      });
    }
  }

  void setNumberOfDoctors(){
    if(_selectDoctorCategory == "All"){
      fireStore.collection('users')
          .where("userType",isEqualTo: "Health Professional")
          .snapshots().listen((snapshot) {
        _numberOfDoctors = snapshot.docs.length; // Get the length of the documents
        notifyListeners(); // Notify listeners to rebuild widgets when data changes
      });
    }else{
      fireStore.collection('users')
          .where("userType",isEqualTo: "Health Professional")
          .where("specialityId",isEqualTo: _selectSpecialityId)
          .snapshots().listen((snapshot) {
        _numberOfDoctors = snapshot.docs.length; // Get the length of the documents
        notifyListeners(); // Notify listeners to rebuild widgets when data changes
      });
    }
  }

}