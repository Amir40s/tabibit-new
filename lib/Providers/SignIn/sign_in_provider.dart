import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tabibinet_project/Screens/StartScreens/PayWallScreens/paywall_screen.dart';

import '../../Screens/DoctorScreens/DoctorBottomNavBar/doctor_bottom_navbar.dart';
import '../../Screens/DoctorScreens/DoctorHomeScreen/Components/patient_detail_chart.dart';
import '../../Screens/PatientScreens/PatientBottomNavBar/patient_bottom_nav_bar.dart';
import '../../constant.dart';
import '../../global_provider.dart';
import '../../model/puahNotification/push_notification.dart';
import '../../model/res/widgets/toast_msg.dart';
import '../../model/services/FirebaseServices/auth_services.dart';
import '../../model/services/NotificationServices/flutter_local_notification.dart';

class SignInProvider extends ChangeNotifier{

  final AuthServices authServices = AuthServices();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final profileProvider = GlobalProviderAccess.profilePro;
  final patientNotificationProvider = GlobalProviderAccess.patientNotificationPro;

  final String title = "Congratulations!";
  final String subTitle = "Your Account Created Successfully";
  final String type = "Account Registration";

  String _userType = "Patient";
  String? _appointmentFrom;
  String? _appointmentTo;
  String? _speciality;
  String? _specialityId;
  // String _signInType = "Custom";
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController specialityC = TextEditingController();
  TextEditingController specialityDetailC = TextEditingController();
  TextEditingController yearsOfExperienceC = TextEditingController();
  TextEditingController appointmentFeeC = TextEditingController();
  bool _isSignInPasswordShow = true;
  bool _isLoading = false;

  String get userType => _userType;
  String? get appointmentFrom => _appointmentFrom;
  String? get appointmentTo => _appointmentTo;
  String? get speciality => _speciality;
  String? get specialityId => _specialityId;
  // String get signInType => _signInType;
  bool get isSignInPasswordShow => _isSignInPasswordShow;
  bool get isLoading => _isLoading;

  setSpeciality(speciality) async {

    _specialityId = speciality;

    await fireStore.collection("doctorsSpecialty").doc(speciality)
        .get().then((value) {
      _speciality = value.get("specialty");
      notifyListeners();
    },);
    log(_specialityId!);
    log(_speciality!);
    notifyListeners();
  }

  showSignInPassword(){
    _isSignInPasswordShow = !_isSignInPasswordShow;
    notifyListeners();
  }

  setUserType(String userType){
    _userType = userType;
    notifyListeners();
  }

  setAppointmentFrom(String from){
    _appointmentFrom = from;
    notifyListeners();
  }

  setAppointmentTo(String to){
    _appointmentTo = to;
    notifyListeners();
  }

  Future<void> signIn() async {
    _isLoading = true;
    notifyListeners();

    try{
      await auth.signInWithEmailAndPassword(
          email: emailC.text.toString(),
          password: passwordC.text.toString()
      );
      DocumentReference docRef =  fireStore.collection("users").doc(auth.currentUser!.uid);
      DocumentSnapshot docSnapshot = await docRef.get();

      log("current User:: ${auth.currentUser?.uid.toString()}");
      if (docSnapshot.exists) {
        final type = docSnapshot.get("userType");
        log("User type: $type");
        if(type == _userType){
          if (type == "Patient") {
            await profileProvider!.getSelfInfo()
                .whenComplete(() {
              Get.offAll(() => const PatientBottomNavBar());
            },);
          }
          else if (type == "Health Professional") {
            profileProvider!.getSelfInfo()
                .whenComplete(() {
              Get.offAll(() => const DoctorBottomNavbar());
            },);
          }
          emailC.text = "";
          passwordC.text = "";
        }else{
          auth.signOut();
          Get.snackbar(
              "Error!",
              "Your account is already created on another Type"
          );
        }
      }

      debugPrint('Successfully signed in with Custom');
      _isLoading = false;
      notifyListeners();
      log("*********Login********");
    }on FirebaseAuthException catch (e) {
      _isLoading =false;
      ToastMsg().toastMsg(_handleFirebaseAuthException(e));
      notifyListeners();
    }
  }

  String _handleFirebaseAuthException(FirebaseAuthException e) {
    log("Firebase Error Code: ${e.code}");
    log("Firebase Error Message: ${e.message}");

    switch (e.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-credential':

        if (e.message != null && e.message!.contains('auth credential is incorrect')) {
          return 'The email or password you entered is incorrect.';
        }
        return 'Invalid credentials. Please check your email and password.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  Future<void> signInWithGoogle(
      BuildContext context,
      String country,
      String location,
      String latitude,
      String longitude,
      ) async {
    // Show the loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // Sign out from Google to ensure the account selection dialog appears
      await googleSignIn.signOut();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the sign-in process, dismiss the dialog
        Get.back();
        return;
      }
      final fcmService = FCMService();
      String? deviceToken = await fcmService.getDeviceToken();

      log("Message Token:: $deviceToken");

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential
      UserCredential userCredential = await auth.signInWithCredential(credential);

      // Get a reference to the user's document
      DocumentReference docRef = fireStore.collection("users").doc(auth.currentUser!.uid);

      // Check if the document exists
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Document exists, check the user type
        final type = docSnapshot.get("userType");
        // Get.back(); // Dismiss the dialog

        if(type == userType){
          if (type == "Patient") {
            Get.off(() => const PatientBottomNavBar());
          } else if (type == "Health Professional") {
            Get.off(() => const DoctorBottomNavbar());
          }
        }else{
          auth.signOut();
          Get.snackbar(
              "Error!",
              "Your account is already created on another Type"
          );
        }
      } else {
        // Document does not exist, create a new one
        await docRef.set({
          "creationDate": DateTime.now(),
          "userUid": auth.currentUser!.uid,
          "email": auth.currentUser!.email,
          "profileUrl": "https://res.cloudinary.com/dz0mfu819/image/upload/v1725947218/profile_xfxlfl.png",
          "rating": "0.0",
          "isOnline": false,
          "specialityId": _specialityId ?? "",
          "specialityName": _speciality ?? "",
          "country": country,
          "birthDate": "",
          "memberShip": "No",
          "location": location,
          "latitude": latitude,
          "longitude": longitude,
          "name" : auth.currentUser!.displayName,
          "phoneNumber" : auth.currentUser!.phoneNumber ?? "",
          "speciality": specialityC.text.toString(),
          "experience": yearsOfExperienceC.text.toString(),
          "availabilityFrom": _appointmentFrom ?? "",
          "availabilityTo": _appointmentTo ?? "",
          "appointmentFee": appointmentFeeC.text.toString(),
          "specialityDetail": specialityDetailC.text.toString(),
          "reviews": "0",
          "patients": "0",
          "userType": _userType,
          "accountType": "Google",
          "deviceToken": deviceToken ?? "",
        }).whenComplete(() async {
          Get.back(); // Dismiss the dialog
          if (_userType == "Patient") {
            sendNotification();
            await patientNotificationProvider!.storeNotification(
                title: title,
                subTitle: subTitle,
                type: type);
            profileProvider!.getSelfInfo()
                .whenComplete(() {
              Get.offAll(() => const PatientBottomNavBar());
            },);
          }
          else{
            sendNotification();
            await patientNotificationProvider!.storeNotification(
                title: title,
                subTitle: subTitle,
                type: type);
            profileProvider!.getSelfInfo()
                .whenComplete(() {
              Get.offAll(() => PaywallScreen());
            },);
          }
        });
      }
      debugPrint('Successfully signed in with Google');
    } catch (e) {
      // Dismiss the dialog in case of error
      Get.back();
      debugPrint("Error: ${e.toString()}");
    }
  }

  sendNotification(){
    FlutterLocalNotification.showBigTextNotification(
        title: title,
        body: subTitle,
        fln: flutterLocalNotificationsPlugin);
  }

}


//else {
//         // Document does not exist, create a new one
//         await docRef.set({
//           "userUid": auth.currentUser!.uid,
//           "email": auth.currentUser!.email,
//           "country": country,
//           "userType": _userType,
//           "accountType": _userType
//         }).whenComplete(() {
//           Get.back(); // Dismiss the dialog
//           if (_userType == "Patient") {
//             Get.to(() => const PatientBottomNavBar());
//           } else {
//             Get.to(() => const DoctorBottomNavbar());
//           }
//         });
//       }