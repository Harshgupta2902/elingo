import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocablury/utilities/navigation/go_paths.dart';
import 'package:vocablury/utilities/navigation/my_navigator.dart';
import 'package:vocablury/utilities/theme/app_colors.dart';

// final controller = Get.put(LoginController());
// final _fcmTokenController = Get.put(FcmTokenController());
// final _cartController = Get.put(CartController());

class FCMNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> updateFCMToken() async {
    _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    print("FCM TOKEN $fcmToken ");
    print("Firebase Instance Id : ---------=>  ${fcmToken?.split(":").first}-------- <= ");

    // _fcmTokenController.fcmTokenApi(fcmToken);
  }

  Future<void> clearFCMToken() async {
    _firebaseMessaging.deleteToken();
  }

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    const AndroidInitializationSettings initializationSettingsAndroid =
        // AndroidInitializationSettings('mipmap/ic_notification');
        AndroidInitializationSettings('mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // ------- Android notification click handler
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        try {
          print("Notification clicked ${details.payload}");

          final Map payload = json.decode(details.payload ?? "flutterLocalNotificationsPlugin");
          onNotificationClicked(payload: payload, path: "flutterLocalNotificationsPlugin");
        } catch (e) {
          print("onDidReceiveNotificationResponse error $e");
        }
      },
    );
  }

  onNotificationClicked({required Map payload, required String path}) async {
    print("----------------------------- called from || $path -----------------------------------");

    var sharedPref = await SharedPreferences.getInstance();

    // var isLoggedIn = sharedPref.getBool(controller.isLoggedIn.value);
    print("payload data --------------------------------- $payload -------------------------------------- ");

    // TODO : To handle a click event on a notification and navigate to a web view when the notification is clicked

    // if (payload.containsKey("launchUrl")) {
    //   launchUrl(Uri.parse(payload['launchUrl']), mode: LaunchMode.externalApplication);
    //   return;
    // }

    MyNavigator.pushNamed(GoPaths.splash);
  }

  fcmListener() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        debugPrint("notification received");

        createNotification(message);
      },
    );
  }

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    try {
      final Map payLoadMap = json.decode(payload ?? "");

      onNotificationClicked(payload: payLoadMap, path: "fcmListener()");
    } catch (e) {
      print("onDidReceiveNotificationResponse error $e");
    }
  }

  //-------------------------------------------------------------------

  static void createNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const androidNotificationDetails = AndroidNotificationDetails(
        'pushNotification',
        'pushNotification',
        importance: Importance.max,
        priority: Priority.high,
        largeIcon: DrawableResourceAndroidBitmap('mipmap/ic_launcher'),
        color: AppColors.zircon,
      );

      const iosNotificationDetail = DarwinNotificationDetails();

      const notificationDetails = NotificationDetails(
        iOS: iosNotificationDetail,
        android: androidNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: json.encode(message.data),
      );
    } catch (error) {
      print("Notification Create Error $error");
    }
  }
}
