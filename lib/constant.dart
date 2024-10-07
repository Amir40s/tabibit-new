import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'global_provider.dart';

const Color themeColor = Color(0xff0596DE);
const Color bgColor = Color(0xffFFFFFF);
const Color textColor = Color(0xff0E0D39);
const Color greyColor = Color(0xffD9D9D9);
const Color greenColor = Color(0xff96D2Cb);
const Color redColor = Color(0xffB71D18);
const Color lightRedColor = Color(0xffF75555);
const Color secondaryGreenColor = Color(0xffE6F4F2);
const Color gradientGreenColor = Color(0xffC5E6E2);
const Color purpleColor = Color(0xff5554DB);
const Color skyBlueColor = Color(0xffCBE2FF);
const Color green1Color = Color(0xff39F20A);
const Color yellow1Color = Color(0xffE5EA01);
const Color red1Color = Color(0xffE30505);


FirebaseFirestore fireStore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;

String? getCurrentUid(){
  final provider = GlobalProviderAccess.profilePro;
  String email = provider!.doctorEmail;
  return email;
}

String convertTimestamp(String timestampString) {
  DateTime parsedTimestamp = parseTimestamp(timestampString);
  final now = DateTime.now();
  final difference = now.difference(parsedTimestamp);

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h';
  } else if (difference.inDays < 30) {
    return '${difference.inDays}d';
  } else if (difference.inDays < 365) {
    final months = difference.inDays ~/ 30;
    return '${months}mm';
  } else {
    final years = difference.inDays ~/ 365;
    return '${years}y';
  }
}

DateTime parseTimestamp(String timestampString) {
  return DateTime.parse(timestampString);
}


class Statics {
  static const String appSign = '20f64cab5f1c6c3927f7b2633b465379dfb440b0ca971dd77d63217a4cc4b499';
  static const int appID = 1249013883; //Your appID
}