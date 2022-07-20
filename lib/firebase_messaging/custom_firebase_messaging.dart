import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_playground/main.dart';
import 'custom_local_notification.dart';

class CustomFirebaseMessaging {
  final CustomLocalNotification _customLocalNotification;

  CustomFirebaseMessaging(this._customLocalNotification);

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        AppleNotification? apple = message.notification?.apple;

        if (notification != null && android != null) {
          _customLocalNotification.showNotification(
            LocalNotification(
              id: android.hashCode,
              title: notification.title!,
              body: notification.body!,
              payload: message.data["route"],
            ),
          );
        }

        if (notification != null && apple != null) {
          _customLocalNotification.showNotification(
            LocalNotification(
              id: apple.hashCode,
              title: notification.title!,
              body: notification.body!,
              payload: message.data["route"],
            ),
          );
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        if (message.data['route'] != null) {
          navigatorKey.currentState?.pushNamed(message.data['route']);
        }
      },
    );
  }

  getTokenFirebase() async => debugPrint(
      'Firebase Token: ${await FirebaseMessaging.instance.getToken()}');
}
