import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';

class LabReportProvider extends ChangeNotifier {

  String? _selectedFile;
  String? _selectedFilePath;

  String? get selectedFilePath => _selectedFilePath;
  String? get selectedFile => _selectedFile;

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

  setSelectedFile(file){
    _selectedFile = file;
    notifyListeners();
  }

  void clearSelectedFile() {
    _selectedFilePath = null;
    notifyListeners();
  }

}