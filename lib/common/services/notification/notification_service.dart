import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../routes/app_routes.dart';
import '/common/util/localNotiPlugin.dart';
import 'channels.dart';
import 'notification_helper.dart';

class NotificationService {
  //------------- Handle Event Noti when Device on Background mode ----------
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  //-------------- Initialize Noti service -----------------
  static Future<void> initializeNotificationService() async {
    await Firebase.initializeApp();
    final firebaseMessaging = FirebaseMessaging.instance;

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        localNotificationsPlugin.flutterLocalNotificationsPlugin;
    // icon notification
    var androidInitialize =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
        android: androidInitialize, iOS: const DarwinInitializationSettings());

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // create a new chanel for android, must add channel id in android/app/src/main/AndroidManifest.xml
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'com.example.lhe_npp.urgent', // id
      'High Importance Notifications', // title
      description: 'Thông báo terminated', // description
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // setting notification
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // request permission for device
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    final RemoteMessage? initMessage =
        await firebaseMessaging.getInitialMessage();
    if (initMessage != null) {
      if (initMessage.data["roles_code"] == "IMPORT" ||
          initMessage.data["roles_code"] == "EXPORT") {
        if (initMessage.data["roles_code"] == "IMPORT") {
          Get.back();
          Get.toNamed(Routes.routeOrderDetail,
              arguments: int.parse(initMessage.data["system_order_id"]));
        } else {
          Get.toNamed(Routes.routeExportOrderDetail,
              arguments: int.parse(initMessage.data["system_order_id"]));
        }
      }
    }

    // event listening when have noti when device on fore
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await showNotification(flutterLocalNotificationsPlugin, message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        if (message.data["roles_code"] == "IMPORT" ||
            message.data["roles_code"] == "EXPORT") {
          if (message.data["roles_code"] == "IMPORT") {
            Get.toNamed(Routes.routeOrderDetail,
                arguments: int.parse(message.data["system_order_id"]));
          } else {
            Get.toNamed(Routes.routeExportOrderDetail,
                arguments: int.parse(message.data["system_order_id"]));
          }
        }
      },
    );
  }

  // ------------ event to show local noti pop model -----------
  static Future showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(

            // import channels.dart
            Channels.channel_1.id,
            Channels.channel_1.name,
            importance: Channels.channel_1.importance,
            priority: Priority.high,
            ticker: 'ticker',
            icon: android?.smallIcon);

    final NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      notification!.title,
      notification.body,
      notificationDetails,
      payload: 'item x',
    );
  }

  // ---------- get device token to push notification ----------
  static Future getDeviceToken() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await firebaseMessage.getToken();
    return (deviceToken == null) ? '' : deviceToken;
  }
}

// class NotificationService {
//   late final FirebaseMessaging _firebaseMessaging;
//   Function(String)? handleNotificationOnTap;
//
//   Future<void> initialize() async {
//     await Firebase.initializeApp();
//     _firebaseMessaging = FirebaseMessaging.instance;
//     await _fcmInitialization();
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );
//   }
//
//   Future _fcmInitialization() async {
//     try {
//       final localNotificationHelper = LocalNotificationHelper.init();
//       localNotificationHelper.init();
//       final RemoteMessage? initMessage =
//           await _firebaseMessaging.getInitialMessage();
//       if (initMessage != null) {
//         _handleTapNotification(initMessage);
//       }
//
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         if (message.notification != null) {
//           localNotificationHelper.showNotification(
//             title: message.notification?.title ?? '',
//             body: message.notification?.body ?? '',
//           );
//         }
//       });
//       FirebaseMessaging.onMessageOpenedApp.listen(
//         (RemoteMessage message) {
//           _handleTapNotification(message);
//         },
//       );
//     } catch (e) {
//       if (kDebugMode) {
//         print(e.toString());
//       }
//     }
//   }
//
//   Future<void> unSubscribeFromTopic(String topic) async {
//     await _firebaseMessaging.unsubscribeFromTopic(topic);
//   }
//
//   Future<void> subscribeToTopic(String topic) async {
//     await _firebaseMessaging.subscribeToTopic(topic);
//   }
//
//   void removeBadgeCount() {
//     if (Platform.isIOS) {
//       ///todo: handle for ios
//     } else if (Platform.isAndroid) {
//       ///todo: handle for android
//     }
//   }
//
//   void _handleTapNotification(RemoteMessage message) {
//     if (message.data["roles_code"] == "IMPORT" ||
//         message.data["roles_code"] == "EXPORT") {
//       if (message.data["roles_code"] == "IMPORT") {
//         Get.offAndToNamed(Routes.routeOrderDetail,
//             arguments: int.parse(message.data["system_order_id"]));
//       } else {
//         Get.offAndToNamed(Routes.routeExportOrderDetail,
//             arguments: int.parse(message.data["system_order_id"]));
//       }
//     }
//   }
// }
//
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(
//   RemoteMessage remoteMessage,
// ) async {
//   await Firebase.initializeApp();
// }
