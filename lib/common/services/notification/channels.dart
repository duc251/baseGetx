import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Channels {
  static const AndroidNotificationChannel channel_1 =
      AndroidNotificationChannel(
    'channel test', 'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.max,
  );
}

class NotificationConfig {
  static const highImportance = 'High Importance Notifications';
  static const channelId = 'com.example.lhe_npp.urgent';
  static const importance = Importance.max;
  static const description = 'This channel is used for important notifications';
  static const icon = "mipmap/ic_launcher";
}
