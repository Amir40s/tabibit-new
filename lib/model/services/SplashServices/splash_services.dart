import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tabibinet_project/constant.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/services/SharedPreference/shared_preference.dart';

import '../../../Providers/translation/translation_provider.dart';
import '../../../Screens/DoctorScreens/DoctorBottomNavBar/doctor_bottom_navbar.dart';
import '../../../Screens/PatientScreens/PatientBottomNavBar/patient_bottom_nav_bar.dart';
import '../../../Screens/StartScreens/OnboardingScreen/onboarding_screen.dart';
import '../../res/constant/app_text.dart';

class SplashServices {

  Future<void> isLogin() async {

    final user = FirebaseAuth.instance.currentUser;
    final profileProvider = GlobalProviderAccess.profilePro;
    final transP = GlobalProviderAccess.translationProvider;
    // final languageP = Provider.of<TranslationProvider>(context);

    await transP!.translateMultiple(AppText.appTextList);

    if (user != null) {
      CollectionReference userCollection = fireStore.collection("users");
      DocumentReference docRef = userCollection.doc(user.uid);

      try {
        // Query the collection to see if there are any documents
        QuerySnapshot querySnapshot = await userCollection.get();

        if (querySnapshot.docs.isNotEmpty) {
          // Collection has documents, now check if the specific document exists
          DocumentSnapshot docSnapshot = await docRef.get();

          if (docSnapshot.exists) {
            // Document exists, check the user type
            final type = docSnapshot.get("userType");
            Get.back(); // Dismiss the dialog

            if (type == "Patient") {
              await profileProvider!.getSelfInfo()
                  .whenComplete(() {
                Get.off(() => const PatientBottomNavBar());
              },);
            }
            else if (type == "Health Professional") {
              profileProvider!.getSelfInfo()
                  .whenComplete(() {
                Get.off(() => const DoctorBottomNavbar());
              },);

            }
          } else {
            Timer(const Duration(seconds: 3), () {
              Get.off(()=> OnboardingScreen());
            },);
            debugPrint("Document does not exist.");
          }
        } else {
          Timer(const Duration(seconds: 3), () {
            Get.off(()=> OnboardingScreen());
          },);
          // Collection is empty
          debugPrint("Collection is empty.");
        }
      } catch (e) {
        debugPrint("Error checking collection and document: $e");
      }
    }
    else{
      Timer(const Duration(seconds: 3), () {
        Get.off(()=> OnboardingScreen());
      },);
    }
  }

}