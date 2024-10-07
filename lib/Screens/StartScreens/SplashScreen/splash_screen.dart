import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/global_provider.dart';
import 'package:tabibinet_project/model/res/constant/app_text.dart';
import '../../../constant.dart';
import '../../../main.dart';
import '../../../model/res/constant/app_assets.dart';
import '../../../model/services/NotificationServices/flutter_local_notification.dart';
import '../../../model/services/SplashServices/splash_services.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
    FlutterLocalNotification.initialize(flutterLocalNotificationsPlugin);
  }

  Future<void> _initialize() async {
    await Firebase.initializeApp();
    splashServices.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.splashImage,height: 30.h,),
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  height: 7,
                  width: 14,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
