import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  if (notification!.title!.contains('Hello')) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_notification_title', notification.title ?? '');
    await prefs.setString('last_notification_body', notification.body ?? '');
    print('Notification saved in SharedPreferences');
  }
  await Firebase.initializeApp();

}