import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';
import '../../global_provider.dart';
import '../../model/res/widgets/toast_msg.dart';
import '../../model/services/CloudinaryServices/cloudinary_services.dart';

class ProfileProvider extends ChangeNotifier{

  final languageP = GlobalProviderAccess.languagePro;
  final CloudinaryService _cloudinaryService = CloudinaryService();

  final TextEditingController nameC = TextEditingController();
  final TextEditingController diplomaC = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final List<String> nameFields = [
    "Full Name",
    "Diploma",
    "Video Consultation Fee",
    "In Office Consultation Fee",
    "Home Visit Consultation Fee",
    "Language",
    // "Phone Number",
  ];
  final List<TextEditingController> _controllers = [];


  ProfileProvider(){
    for (int i = 0; i < nameFields.length; i++) {
      _controllers.add(TextEditingController());
    }
  }

  TextEditingController getNameController(int index) {
    return _controllers[index];
  }

  String _doctorName = "";
  String _doctorPhone = "";
  String _doctorCountry = "";
  String _doctorDOB = "";
  String _imageUrl = "";
  String _doctorEmail = "";
  String _name = "";
  String _email = "";
  String _userType = "";
  String _phoneNumber = "";
  String _country = "";
  String _birthDate = "";
  String _speciality = "";
  String _specialityId = "";
  String _availabilityFrom = "";
  String _availabilityTo = "";
  String _specialityDetail = "";
  String _appointmentFee = "";
  String _memberShip = "";
  String _experience = "";
  String _patients = "";
  String _reviews = "";
  String _profileUrl = "";
  String _rating = "";
  String _isOnline = "";
  String _location = "";
  String _latitude = "";
  String _longitude = "";
  String _accountType = "";
  String _balance = "";
  File? _image;
  bool _isDataFetched = true;
  bool _isLoading = false;

  String get name => _name;
  String get email => _email;
  String get userType => _userType;
  String get phoneNumber => _phoneNumber;
  String get dateOfBirth => _doctorDOB;
  String get country => _country;
  String get birthDate => _birthDate;
  String get speciality => _speciality;
  String get specialityId => _specialityId;
  String get availabilityFrom => _availabilityFrom;
  String get availabilityTo => _availabilityTo;
  String get specialityDetail => _specialityDetail;
  String get appointmentFee => _appointmentFee;
  String get memberShip => _memberShip;
  String get experience => _experience;
  String get patients => _patients;
  String get reviews => _reviews;
  String get profileUrl => _profileUrl;
  String get rating => _rating;
  String get isOnline => _isOnline;
  String get location => _location;
  String get latitude => _latitude;
  String get longitude => _longitude;
  String get accountType => _accountType;
  bool get isLoading => _isLoading;
  String get doctorEmail => _doctorEmail;
  String get balance => _balance;
  File? get image => _image;
  bool get isDataFetched => _isDataFetched;

  Future<void> getSelfInfo() async {
    languageP?.loadSavedLanguage();
    _isDataFetched = true;
    if(_isDataFetched ){
      await fireStore.collection("users").doc(auth.currentUser!.uid).get()
          .then((value) {
        _doctorName = value.get("name");
        _doctorEmail = value.get("email");
        _doctorPhone = value.get("phoneNumber");
        _doctorCountry = value.get("country");
        _doctorDOB = value.get("birthDate");
        _imageUrl = value.get("profileUrl");
        nameC.text = _doctorName;
        _name = value.get("name");
        _balance = value.get("balance") ?? "0.0";
        _phoneNumber = value.get("phoneNumber");
        _country = value.get("country");
        _birthDate = value.get("birthDate");
        _email = value.get("email");
        _profileUrl = value.get("profileUrl");

        _controllers[0].text = value.get('name') ?? '';
        _controllers[1].text = value.get('diploma') ?? '';
        _controllers[2].text = value.get('appointmentFee') ?? '';
        _controllers[3].text = value.get('inOfficeFee') ?? '';
        _controllers[4].text = value.get('homeVisitFee') ?? '';
        _controllers[5].text = value.get('language') ?? '';
        // _controllers[6].text = value.get('phoneNumber') ?? '';

        _isDataFetched = false;
        notifyListeners();
      },);
      log(_name);
      log(_phoneNumber);
      log(_email);
      log(_profileUrl);
    }
  }

  Future<void> updateProfileWithImage()async{
    _isLoading = true;
    notifyListeners();

    // final cloudinaryP = GlobalProviderAccess.

    uploadFile().whenComplete(() {
      fireStore.collection("users").doc(auth.currentUser!.uid).update({
        "name" : _controllers[0].text,
        "diploma" : _controllers[1].text,
        "appointmentFee" : _controllers[2].text,
        "inOfficeFee" : _controllers[3].text,
        "homeVisitFee" : _controllers[4].text,
        "language" : _controllers[5].text,
        // "phoneNumber" : _controllers[6].text,
        "birthDate" : _birthDate,
        "profileUrl" : _imageUrl,
      })
          .whenComplete(() async{
        _isLoading = false;
        await getSelfInfo();
        _imageUrl = "";
        _image = null;
        ToastMsg().toastMsg("Profile Update Successfully!");
        notifyListeners();
      },);
    },);

  }

  Future<void> updateProfile()async{
    _isLoading = true;
    notifyListeners();
    await fireStore.collection("users").doc(auth.currentUser?.uid).update({
      "name" : _controllers[0].text,
      "diploma" : _controllers[1].text,
      "appointmentFee" : _controllers[2].text,
      "inOfficeFee" : _controllers[3].text,
      "homeVisitFee" : _controllers[4].text,
      "language" : _controllers[5].text,
      // "phoneNumber" : _controllers[6].text,
      "birthDate" : _doctorDOB,
    })
        .whenComplete(() async{
      ToastMsg().toastMsg("Profile Update Successfully!");
      await getSelfInfo();
      log("Updated info");
      _isLoading = false;
      notifyListeners();
    },);
  }

  Future<void> uploadFile() async {
    _isLoading = true;
    notifyListeners();

    try {
      String? url = await _cloudinaryService.uploadFile(_image!);
      if (url != null) {
        _imageUrl = url;
        log("message:: $url");
        notifyListeners();
      }
    } catch (e) {
      log("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> uploadFileReturn() async {
    _isLoading = true;
    notifyListeners();

    try {
      String? url = await _cloudinaryService.uploadFile(_image!);
      if (url != null) {
        _imageUrl = url;
        log("message:: $url");
        notifyListeners();
        return url;
      }
    } catch (e) {

      log("Error: $e");
      return "";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return null;
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      Get.back();
      notifyListeners();
    }
  }

  Future<void> pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      Get.back();
      notifyListeners();
    }
  }

  void setDate(DateTime date) {
    String format = DateFormat('yyyy-MM-dd').format(date);
    _doctorDOB = format;
    log("Pick Date:: $_doctorDOB");
    notifyListeners();
  }

  void clearImage() {
    _image = null;
    notifyListeners();
  }

  //clear all when sign out
  Future<void> clearAll() async{

    final bottomNav =  GlobalProviderAccess.bottomNavProvider;

    bottomNav!.setIndex(0);

    _doctorName = "";
    _doctorPhone = "";
    _doctorCountry = "";
    _doctorDOB = "";
    _imageUrl = "";
    _doctorEmail = "";
    _name = "";
    _email = "";
    _userType = "";
    _phoneNumber = "";
    _country = "";
    _birthDate = "";
    _speciality = "";
    _specialityId = "";
    _availabilityFrom = "";
    _availabilityTo = "";
    _specialityDetail = "";
    _appointmentFee = "";
    _memberShip = "";
    _experience = "";
    _patients = "";
    _reviews = "";
    _profileUrl = "";
    _rating = "";
    _isOnline = "";
    _location = "";
    _latitude = "";
    _longitude = "";
    _accountType = "";
    _isDataFetched = true;
    _isLoading = false;
    _image = null;
    notifyListeners(); // Notify listeners when data is cleared
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  void disposeControllers() {
    for (var controller in _controllers) {
      controller.dispose();
    }
  }

}
