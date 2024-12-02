import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabibinet_project/constant.dart';


class ActionProvider extends ChangeNotifier{
  int _selectedIndex = 0;
  final Map<int, bool> _isHovered = {};


  String _otpCode = "";

  String get otpCode => _otpCode;

  Map<int, bool> _isCardHovered = {};

  bool isCardHovered(int index) => _isCardHovered[index] ?? false;

  void setHover(int index, bool value) {
    _isCardHovered[index] = value;
    notifyListeners();
  }

  static final ActionProvider _instance = ActionProvider._internal();
  factory ActionProvider() => _instance;
  ActionProvider._internal();

  int get selectedIndex => _selectedIndex;
  bool  isHovered(int index) => _isHovered[index] ?? false;

  void selectMenu(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void onHover(int index,bool isHovered) {
    _isHovered[index] = isHovered;
    notifyListeners();
  }



  void setOtpCode(String code){
    _otpCode = code;
    notifyListeners();
  }

  ///to update the value of button on updating speciality
  String _buttonText = 'Add';
  String? _editingId;
  String get buttonText => _buttonText;
  String? get editingId => _editingId;

  void setEditingMode(String id) {
    _buttonText = 'Update';
    _editingId = id;
    notifyListeners();
  }

  void resetMode() {
    _buttonText = 'Add';
    _editingId = null;
    notifyListeners();
  }



  final Map<String, bool> _loadingStates = {};
  bool isLoadingState(String key) => _loadingStates[key] ?? false;

  void setLoadingState(String key, bool loading) {
    _loadingStates[key] = loading;
    notifyListeners();
  }


  bool _isFooterHovered = false;

  bool get isFooterHovered => _isFooterHovered;

  void setHovered(bool value) {
    _isFooterHovered = value;
    notifyListeners();
  }

  int _hoveredIndex = -1;

  int get hoveredIndex => _hoveredIndex;

  void setHoveredIndex(int index) {
    _hoveredIndex = index;
    notifyListeners();
  }

  void clearHover() {
    _hoveredIndex = -1;
    notifyListeners();
  }


  bool _isEditVisible = false;
  bool get isEditVisible => _isEditVisible;

  void setEditVisible(bool value) {
    _isEditVisible = value;
    notifyListeners();
  }


  final GlobalKey<ScaffoldState> _scaffoldKeyDashboard = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKeyDashboard;

  void controlMenuDashboard() {
    if (!_scaffoldKeyDashboard.currentState!.isDrawerOpen) {
      _scaffoldKeyDashboard.currentState!.openDrawer();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKeyInstructor = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKeyInstructor => _scaffoldKeyInstructor;

  void controlMenuInstructor() {
    if (!_scaffoldKeyInstructor.currentState!.isDrawerOpen) {
      _scaffoldKeyInstructor.currentState!.openDrawer();
    }
  }


  // date picker d
  DateTime? _selectedDateTime;

  DateTime? get selectedDateTime => _selectedDateTime;

  void setDateTime(DateTime dateTime) {
    _selectedDateTime = dateTime;
    notifyListeners();
  }

  DateTimeRange? _selectedDateTimeRange;

  DateTimeRange? get selectedDateTimeRange => _selectedDateTimeRange;

  // void setDateTimeRange(DateTimeRange dateTimeRange) {
  //   _selectedDateTimeRange = dateTimeRange;
  //   notifyListeners();
  // }

  // DateTimeRange? _selectedDateTimeRange;

  DateTime? _startDate;
  DateTime? _endDate;

  // Getter for start date
  DateTime? get startDate => _startDate;

  // Getter for end date
  DateTime? get endDate => _endDate;

  // Getter for the entire date range
  // DateTimeRange? get selectedDateTimeRange => _selectedDateTimeRange;

  // Method to set the date range and update start and end dates
  void setDateTimeRange(DateTimeRange dateTimeRange) {
    _selectedDateTimeRange = dateTimeRange;
    _startDate = dateTimeRange.start;
    _endDate = dateTimeRange.end;
    notifyListeners();  // Notify listeners (UI will be updated)
  }


  void setDoctorOnline() async{
    String uid = auth.currentUser?.uid.toString() ?? "";
    await fireStore.collection("users").doc(uid).update({
      "isOnline" : true
    });
  }

  void setDoctorOffline() async{
    String uid = auth.currentUser?.uid.toString() ?? "";
    await fireStore.collection("users").doc(uid).update({
      "isOnline" : false
    });
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }
}