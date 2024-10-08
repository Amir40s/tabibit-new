// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC4paZlhPhuJUcOkq4B0TXGWAmoRCddohs',
    appId: '1:996553373997:web:0c9ecd23d68dad34463ba4',
    messagingSenderId: '996553373997',
    projectId: 'tabibinet',
    authDomain: 'tabibinet.firebaseapp.com',
    storageBucket: 'tabibinet.appspot.com',
    measurementId: 'G-5ST4F98X09',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQ5e5fnwU_rQz9JxIqNONW6f-hsqpYpe8',
    appId: '1:996553373997:android:5cb26c3e2c085e97463ba4',
    messagingSenderId: '996553373997',
    projectId: 'tabibinet',
    storageBucket: 'tabibinet.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyACImQpKdveZrqPqetavgCy4Rqb_VhSeRg',
    appId: '1:996553373997:ios:372449e13b2003ed463ba4',
    messagingSenderId: '996553373997',
    projectId: 'tabibinet',
    storageBucket: 'tabibinet.appspot.com',
    iosBundleId: 'com.tabibinet.tabibinetProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyACImQpKdveZrqPqetavgCy4Rqb_VhSeRg',
    appId: '1:996553373997:ios:372449e13b2003ed463ba4',
    messagingSenderId: '996553373997',
    projectId: 'tabibinet',
    storageBucket: 'tabibinet.appspot.com',
    iosBundleId: 'com.tabibinet.tabibinetProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC4paZlhPhuJUcOkq4B0TXGWAmoRCddohs',
    appId: '1:996553373997:web:cb5b3da8b5aab57e463ba4',
    messagingSenderId: '996553373997',
    projectId: 'tabibinet',
    authDomain: 'tabibinet.firebaseapp.com',
    storageBucket: 'tabibinet.appspot.com',
    measurementId: 'G-78MKTG51GR',
  );
}