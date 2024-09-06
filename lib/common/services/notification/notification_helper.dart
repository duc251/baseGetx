import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'channels.dart';

class LocalNotificationHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static LocalNotificationHelper? _localNotificationHelper;
  static int _notificationId = 0;

  LocalNotificationHelper._();

  factory LocalNotificationHelper.init() {
    return _localNotificationHelper ?? LocalNotificationHelper._();
  }

  Future<void> init() async {
    final initializationSettings = await _getPlatformSettings();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    // /// get message when app kill
    // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    //
    // if (notificationAppLaunchDetails != null) {
    //   handlerSelectNotification(notificationAppLaunchDetails.payload);
    // }

    _createNotificationChannel(
      id: NotificationConfig.channelId,
      channelName: NotificationConfig.highImportance,
      description: NotificationConfig.description,
      // soundPath: notificationSoundPath,
      importance: Importance.max,
    );
  }

  Future<void> _createNotificationChannel({
    required String id,
    required String channelName,
    required String description,
    // String? soundPath,
    Int64List? vibrationPattern,
    Importance? importance,
  }) async {
    final androidNotificationChannel = AndroidNotificationChannel(
      id,
      channelName,
      description: description,
      vibrationPattern: vibrationPattern,
      importance: importance ?? Importance.high,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  Future<InitializationSettings> _getPlatformSettings() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(NotificationConfig.icon);
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            // uncomment if want to support ios <10.
            // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
            );

    return const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
  }

  Future<void> showNotification({
    required String title,
    required String body,
    String channelId = NotificationConfig.channelId,
    String? payload,
    Importance? importance,
    Priority? priority,
  }) async {
    final vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 200;
    vibrationPattern[2] = 200;
    vibrationPattern[3] = 200;

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      NotificationConfig.highImportance,
      channelDescription: NotificationConfig.description,
      // icon: NotificationConfig.notificationIconPath,
      color: Colors.blue, //TODO: initial colors
      vibrationPattern: vibrationPattern,
      // sound: RawResourceAndroidNotificationSound(
      //   notificationSoundPath.split('.').first,
      // ),
    );
    final DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentBadge: true,
      // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      presentSound: true,
      // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
      // sound:
      //     notificationSoundPath, // Specifics the file pat  h to play (only from iOS 10 onwards)
      badgeNumber: 1,
      // The application's icon badge number
      //attachments: List<IOSNotificationAttachment>?, (only from iOS 10 onwards)
      //subtitle: String?, //Secondary description  (only from iOS 10 onwards)
      threadIdentifier: _notificationId.toString(),
    );

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      _notificationId++,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
