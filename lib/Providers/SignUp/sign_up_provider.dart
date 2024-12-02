import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabibinet_project/Screens/DoctorScreens/DoctorBottomNavBar/doctor_bottom_navbar.dart';
import 'package:tabibinet_project/Screens/PatientScreens/PatientBottomNavBar/patient_bottom_nav_bar.dart';
import 'package:tabibinet_project/Screens/StartScreens/PayWallScreens/paywall_screen.dart';
import 'package:tabibinet_project/model/res/widgets/toast_msg.dart';
import '../../Screens/DoctorScreens/DoctorHomeScreen/Components/patient_detail_chart.dart';
import '../../constant.dart';
import '../../global_provider.dart';
import '../../model/puahNotification/push_notification.dart';
import '../../model/services/FirebaseServices/auth_services.dart';
import '../../model/services/NotificationServices/flutter_local_notification.dart';

class SignUpProvider extends ChangeNotifier{


  final AuthServices authServices = AuthServices();
  final profileProvider = GlobalProviderAccess.profilePro;
  final patientNotificationProvider = GlobalProviderAccess.patientNotificationPro;

  final String title = "Congratulations!";
  final String subTitle = "Your Account Created Successfully";
  final String type = "Account Registration";

  String _otp = "";
  bool _isCheck = false;
  bool _isPrivacy = false;
  bool _isLoading = false;
  bool _isSignUpPasswordShow = true;
  bool _isSignUpConfirmPasswordShow = true;

  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();
  String get otp => _otp;
  bool get isCheck => _isCheck;
  bool get isPrivacy => _isPrivacy;
  bool get isLoading => _isLoading;
  bool get isSignUpPasswordShow => _isSignUpPasswordShow;
  bool get isSignUpConfirmPasswordShow => _isSignUpConfirmPasswordShow;

  setOTP(value){
    _otp = value;
    notifyListeners();
  }

  setLoading(value){
    _isLoading = value;
    notifyListeners();
  }

  checkRememberPassword(bool isCheck){
    _isCheck = isCheck;
    notifyListeners();
  }

  checkPrivacy(bool isCheck){
    _isPrivacy = isCheck;
    notifyListeners();
  }

  showSignUpPassword(){
    _isSignUpPasswordShow = !_isSignUpPasswordShow;
    notifyListeners();
  }

  showSignUpConfirmPassword(){
    _isSignUpConfirmPasswordShow = !_isSignUpConfirmPasswordShow;
    notifyListeners();
  }

  Future<void> signUp({
    required speciality, required specialityDetail, required specialityId,
    required yearsOfExperience, required appointmentFrom,
    required appointmentTo, required appointmentFee,
    required type, required country, required location,
    required latitude, required longitude, required diploma,required language,
    required professionalExperience, required inOfficeFee, required homeVisitFee,required phoneNumber
  }) async{
    _isLoading = true;
    notifyListeners();

    final phones = fireStore.collection("users").
    where("phoneNumber", isEqualTo: phoneC.text.toString())

        .snapshots();
    phones.listen((querySnapshot) {
      final phones = querySnapshot.docs;
      log("Length: ${phones.length}");
      if(int.parse(phones.length.toString()) <= 0){
        auth.createUserWithEmailAndPassword(
            email: emailC.text.toString(),
            password: passwordC.text.toString()
        )
            .then((value) async {
          final fcmService = FCMService();
          String? deviceToken = await fcmService.getDeviceToken();
          String? userUID = auth.currentUser!.uid;
          await fireStore.collection("users").doc(userUID).set(
              {
                "creationDate": DateTime.now(),
                "userUid": userUID,
                "email": emailC.text.toString(),
                "name": nameC.text,
                "phoneNumber": phoneNumber,
                "country": country,
                "birthDate": "",
                "memberShip": "No",
                "profileUrl": "https://res.cloudinary.com/dz0mfu819/image/upload/v1725947218/profile_xfxlfl.png",
                "rating": "0.0",
                "totalRating": "0.0",
                "isOnline": false,
                "location": location,
                "latitude": latitude,
                "longitude": longitude,
                "specialityId": specialityId ?? "",
                "speciality": speciality,
                "specialityDetail": specialityDetail,
                "experience": yearsOfExperience,
                "availabilityFrom": appointmentFrom ?? "",
                "availabilityTo": appointmentTo ?? "",
                "appointmentFee": appointmentFee,
                "reviews": "0",
                "patients": "0",
                "diploma": diploma,
                "language": language,
                "professionalExperience": professionalExperience,
                "inOfficeFee": inOfficeFee,
                "homeVisitFee": homeVisitFee,
                "userType": type,
                "balance": "0.0",
                "accountType": "Custom",
                "password": passwordC.text.toString().trim(),
                "deviceToken": deviceToken ?? "",
              }
          )
              .whenComplete(() async {
            if (type == "Patient") {
              sendNotification();
              await patientNotificationProvider!.storeNotification(
                  title: title,
                  subTitle: subTitle,
                  type: type);
              await profileProvider!.getSelfInfo()
                  .whenComplete(() {
                Get.offAll(()=>const PatientBottomNavBar());
              },);
              // Get.off(() => const PatientBottomNavBar());
            }
            else if (type == "Health Professional") {
              sendNotification();
              await patientNotificationProvider!.storeNotification(
                  title: title,
                  subTitle: subTitle,
                  type: type);
              profileProvider!.getSelfInfo()
                  .whenComplete(() {
                Get.offAll(() => PaywallScreen());
              },);
              // Get.off(() => const DoctorBottomNavbar());
            }
            log("*********** Complete ************");
            _isLoading = false;
            notifyListeners();
          },)
              .onError((error, stackTrace) {
            ToastMsg().toastMsg(error.toString());
            log("*********** Error ************");
            _isLoading = false;
            log(error.toString());
            notifyListeners();
          },);
        },)
            .onError((error, stackTrace) {
          ToastMsg().toastMsg(error.toString());
          log("*********** Error ************");
          _isLoading = false;
          log(error.toString());
          notifyListeners();
        },);
      }else{
        _isLoading = false;
        ToastMsg().toastMsg("Phone Number already exists");
        notifyListeners();
      }
    });

  }

  sendNotification(){
    FlutterLocalNotification.showBigTextNotification(
        title: title,
        body: subTitle,
        fln: flutterLocalNotificationsPlugin);
  }

  Future<void> memberShip(memberShip)async{
    await fireStore.collection("users").doc(auth.currentUser!.uid).update(
        {
          "memberShip" : memberShip.toString()
        }
    ).whenComplete(() => Get.to(()=>const DoctorBottomNavbar()),);
  }

}


