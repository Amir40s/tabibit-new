import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/Providers/payment/payment_provider.dart';
import 'package:tabibinet_project/Providers/schedule/schedule_provider.dart';
import 'package:tabibinet_project/chart_screen.dart';
import 'package:tabibinet_project/model/api_services/url/baseurl.dart';

import 'Providers/AudioPlayerProvider/audio_player_provider.dart';
import 'Providers/BottomNav/bottom_navbar_provider.dart';
import 'Providers/DoctorAppointment/doctor_appointment_provider.dart';
import 'Providers/DoctorHome/doctor_home_provider.dart';
import 'Providers/FaqProvider/faq_provider.dart';
import 'Providers/Favorite/favorite_doctor_provider.dart';
import 'Providers/FindDoctor/find_doctor_provider.dart';
import 'Providers/LabReport/lab_report_provider.dart';
import 'Providers/Language/language_provider.dart';
import 'Providers/Location/location_provider.dart';
import 'Providers/Medicine/medicine_provider.dart';
import 'Providers/MyAppointment/my_appointment_provider.dart';
import 'Providers/Onboard/onboard_provider.dart';
import 'Providers/PatientAppointment/patient_appointment_provider.dart';
import 'Providers/PatientHome/patient_home_provider.dart';
import 'Providers/PatientNotification/patient_notification_provider.dart';
import 'Providers/PayWall/paywall_provider.dart';
import 'Providers/Profile/profile_provider.dart';
import 'Providers/SignIn/sign_in_provider.dart';
import 'Providers/SignUp/sign_up_provider.dart';

import 'Providers/TwilioProvider/twilio_provider.dart';
import 'Providers/subscription_provider.dart';
import 'Providers/translation/translation_provider.dart';

import 'Providers/chatProvider/chat_provider.dart';

import 'Screens/StartScreens/SplashScreen/splash_screen.dart';
import 'constant.dart';
import 'controller/doctor/appdata_provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

import 'global_provider.dart';
import 'model/LifeCycle/life_cycle.dart';
import 'model/puahNotification/message_handle.dart';
import 'model/puahNotification/push_notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await dotenv.load(fileName: ".env");
  Stripe.publishableKey=BaseUrl.STRIPE_PUBLISH_KEY;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final fcmService = FCMService();
  await fcmService.initialize();


  String? deviceToken = await fcmService.getDeviceToken();
  
  log("Message Token:: $deviceToken");
  // await dotenv.load(fileName: ".env").whenComplete((){
  //   log("ENV Loaded");
  // });
  
  // FirebaseMessaging.onBackgroundMessage(handler)



  // StripePayment.setOptions(StripeOptions(
  //   publishableKey: "YOUR_PUBLISHABLE_KEY", // Replace with your publishable key
  //   androidPayMode: 'test', // Set to 'production' in a live environment
  // ));

  runApp(const MyApp());

  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp
      ]
  );


  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => const MyApp(), // Wrap your app
  // ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
      return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => OnboardProvider(),),
            ChangeNotifierProvider(create: (context) => LanguageProvider(),),
            ChangeNotifierProvider(create: (context) => LocationProvider(),),
            ChangeNotifierProvider(create: (context) => SignUpProvider(),),
            ChangeNotifierProvider(create: (context) => SignInProvider(),),
            ChangeNotifierProvider(create: (context) => PaywallProvider(),),
            ChangeNotifierProvider(create: (context) => BottomNavBarProvider(),),
            ChangeNotifierProvider(create: (context) => PatientHomeProvider(),),
            ChangeNotifierProvider(create: (context) => DateProvider(),),
            ChangeNotifierProvider(create: (context) => PatientNotificationProvider(),),
            ChangeNotifierProvider(create: (context) => DoctorHomeProvider(),),
            ChangeNotifierProvider(create: (context) => DoctorAppointmentProvider(),),
            ChangeNotifierProvider(create: (context) => MedicineProvider(),),
            ChangeNotifierProvider(create: (context) => PatientAppointmentProvider(),),
            ChangeNotifierProvider(create: (context) => FindDoctorProvider(),),
            ChangeNotifierProvider(create: (context) => FavoritesProvider(),),
            ChangeNotifierProvider(create: (context) => AppStateProvider(),),
            ChangeNotifierProvider(create: (context) => LabReportProvider(),),
            ChangeNotifierProvider(create: (context) => FaqProvider(),),
            ChangeNotifierProvider(create: (context) => MyAppointmentProvider(),),
            ChangeNotifierProvider(create: (context) => ChatProvider(),),
            ChangeNotifierProvider(create: (context) => ProfileProvider(),),
            ChangeNotifierProvider(create: (context) => AppDataProvider(),),
            ChangeNotifierProvider(create: (context) => SubscriptionProvider(),),

            ChangeNotifierProvider(create: (context) => TwilioProvider(
                accountSid: BaseUrl.SID_TWILLO,
                authToken: BaseUrl.AUTH_TOKEN_TWILLO,
                twilioPhoneNumber: BaseUrl.PHONE_TWILLO
            ),),

            ChangeNotifierProvider(create: (context) => TranslationProvider(),),

            ChangeNotifierProvider(create: (context) => AudioPlayerProvider(),),
            ChangeNotifierProvider(create: (context) => PaymentProvider(),),
            ChangeNotifierProvider(create: (context) => ScheduleProvider(),),

          ],
        child: GetMaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'TabibiNet',
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: themeColor,primary: themeColor),
            useMaterial3: true,
          ),
          // home: PatientStatusChart(),
          home: const SplashScreen(),
          // home: const DoctorBottomNavbar(),
          // home: const PatientBottomNavBar(),
        ),
      );
    },);
  }
}


