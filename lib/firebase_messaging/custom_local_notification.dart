// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_playground/main.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class LocalNotification {
  final int id;
  final String title;
  final String body;
  final String? payload;
  // final RemoteMessage? remoteMessage;

  LocalNotification({
    required this.id,
    required this.title,
    required this.body,
    this.payload,
    // this.remoteMessage,
  });
}

class CustomLocalNotification {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  CustomLocalNotification() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _initializeTimeZone();
    _initializeNotifications();
  }

  _initializeTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _initializeNotifications() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = IOSInitializationSettings();

    flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
        iOS: ios,
      ),
      onSelectNotification: _onSelectNotification,
    );
  }

  _onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      navigatorKey.currentState?.pushNamed(payload);
    }
  }

  showNotification(LocalNotification notification) {
    flutterLocalNotificationsPlugin.show(
      notification.id,
      notification.title,
      notification.body,
      const NotificationDetails(
        android: androidNotificationDetails,
        iOS: iosNotificationDetails,
      ),
      payload: notification.payload,
    );
  }

  // showNotificationScheduled({
  //   required LocalNotification notification,
  //   required Duration duration,
  // }) {
  //   final date = DateTime.now().add(duration);

  //   flutterLocalNotificationsPlugin.zonedSchedule(
  //     notification.id,
  //     notification.title,
  //     notification.body,
  //     tz.TZDateTime.from(date, tz.local),
  //     const NotificationDetails(
  //       android: androidNotificationDetails,
  //       iOS: iosNotificationDetails,
  //     ),
  //     payload: notification.payload,
  //     androidAllowWhileIdle: true,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }

//   checkForNotifications() async {
//     final details =
//         await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//     if (details != null && details.didNotificationLaunchApp) {
//       _onSelectNotification(details.payload);
//     }
//   }
}

/// Notification Details
const androidNotificationDetails = AndroidNotificationDetails(
  'notification_channel_id',
  'Notification Channel Name',
  channelDescription: 'This channel is used for important notifications.',
  importance: Importance.max,
  priority: Priority.max,
  enableVibration: true,
);

const iosNotificationDetails = IOSNotificationDetails(
  threadIdentifier: 'thread_id',
  presentAlert: true,
  presentBadge: true,
  presentSound: true,
);
