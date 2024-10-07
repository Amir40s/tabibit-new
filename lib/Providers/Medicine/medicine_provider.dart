import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';

import '../../constant.dart';

class MedicineProvider extends ChangeNotifier{

  final tabletC = TextEditingController();

  final List<String> repeatList = [
    "Everyday",
    "Alternative day",
    "Specific days",
  ];

  final List<String> dayList = [
    "Morning",
    "Noon",
    "Evening",
    "Night",
  ];

  final List<String> takenList = [
    "After food",
    "Before food",
  ];

  int _dosage = 1;
  int _duration = 1;
  List<String> _selectDay = [];
  List<String> _selectedRepeats = [];
  List<String> _selectTaken = [];
  String _timeOfDay = "";
  String _repetition = "";
  String _taken = "";
  bool _isLoading = false;
  String? _selectedFile;
  String? _selectedFilePath;


  String? get selectedFilePath => _selectedFilePath;
  String? get selectedFile => _selectedFile;
  int get dosage => _dosage;
  int get duration => _duration;
  List<String> get selectDay => _selectDay;
  List<String> get selectedRepeats => _selectedRepeats;
  List<String> get selectTaken => _selectTaken;
  String get timeOfDay => _timeOfDay;
  String get repetition => _repetition;
  String get taken => _taken;
  bool get isLoading => _isLoading;

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'ppt'],
      );

      if (result != null) {
        _selectedFilePath = result.files.single.path;
        notifyListeners();
      } else {
        // User canceled the picker
        _selectedFilePath = null;
        notifyListeners();
      }
    } catch (e) {
      log("Error picking file: $e");
    }
  }

  Future<String?> uploadFile() async {

    File file = File(_selectedFilePath.toString());

    try {
      _isLoading = true;
      notifyListeners();
      // Create a reference to Firebase Storage
      final storageRef = storage.ref();
      // Create a reference to the file you want to upload
      final fileRef = storageRef.child('reports/${file.uri.pathSegments.last}');

      // Upload the file
      await fileRef.putFile(file);

      // Get the download URL
      final String downloadUrl = await fileRef.getDownloadURL();

      // await addFile(appointmentId, downloadUrl);

      log('File uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      log('Error uploading file: $e');
      return "";
    }
  }

  Future<void> addFile(appointmentId) async {
    final String id = DateTime.now().millisecondsSinceEpoch.toString();
    String fileUrl = await uploadFile() ?? "";
    fireStore.collection("appointment")
        .doc(appointmentId)
        .collection("report")
        .doc(id).set({
      "id" : id,
      "fileUrl" : fileUrl,
    }).whenComplete(() {
      _isLoading = false;
      notifyListeners();
    },);
  }

  addDosage(){
    if(_dosage > 0){
      _dosage++;
      notifyListeners();
      log(_dosage.toString());
    }
  }

  addDuration(){
    if(_duration > 0){
      _duration++;
      notifyListeners();
      log(_duration.toString());
    }
  }

  decDosage(){
    if(_dosage > 1){
      _dosage--;
      notifyListeners();
      log(_dosage.toString());
    }
  }

  decDuration(){
    if(_duration > 1){
      _duration--;
      notifyListeners();
      log(_duration.toString());
    }
  }

  void selectDayButton(String item) {
    if (_selectDay.contains(item)) {
      _selectDay.remove(item); // Deselect if already selected
    } else {
      _selectDay.add(item); // Select if not selected
    }
    log(_selectDay.toString());
    notifyListeners();
  }
  // Select multiple items for repetition
  void selectRepeatButton(String item) {
    if (_selectedRepeats.contains(item)) {
      _selectedRepeats.remove(item); // Deselect if already selected
    } else {
      _selectedRepeats.add(item); // Select if not selected
    }
    log(_selectedRepeats.toString());
    notifyListeners();
  }
  // Select multiple items for taken (before/after food)
  void selectTakenButton(String item) {
    if (_selectTaken.contains(item)) {
      _selectTaken.remove(item); // Deselect if already selected
    } else {
      _selectTaken.add(item); // Select if not selected
    }
    log(_selectTaken.toString());
    notifyListeners();
  }

  Future sendPrescription(appointmentId) async {

    final id = DateTime.now().millisecondsSinceEpoch.toString();

    if(_selectedRepeats.isNotEmpty &&
        _selectDay.isNotEmpty &&
        _selectTaken.isNotEmpty)
    {
      _isLoading = true;
      notifyListeners();

      await fireStore.collection("appointment")
          .doc(appointmentId)
          .collection("prescription").doc(id).set({
        "tabletName" : tabletC.text,
        "dosage" : _dosage.toString(),
        "duration" : _duration.toString(),
        "repeat" : _selectedRepeats,
        "timeDay" : _selectDay,
        "taken" : _selectTaken,
      }).whenComplete(() {
        _isLoading = false;
        // Get.back();
        // clearData();
        ToastMsg().toastMsg("Prescription Send Successfully!");
        notifyListeners();
      },);
    }else{
      ToastMsg().toastMsg("Something is Missing!");
    }
  }

  clearData(){
    _selectedRepeats.clear();
    _selectDay.clear();
    _selectTaken.clear();
    tabletC.clear();
    _duration = 1;
    _dosage = 1;
  }

}