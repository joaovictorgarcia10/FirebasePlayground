import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_playground/main.dart';
import 'custom_local_notification.dart';

class CustomFirebaseMessaging {
  late CustomLocalNotification _customLocalNotification;

  CustomFirebaseMessaging._internal(this._customLocalNotification);

  static final CustomFirebaseMessaging _singleton =
      CustomFirebaseMessaging._internal(CustomLocalNotification());

  factory CustomFirebaseMessaging() => _singleton;

  getTokenFirebase() async => debugPrint(
      'Firebase Token: ${await FirebaseMessaging.instance.getToken()}');

  Future<void> initialize({VoidCallback? callback}) async {
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

        if (message.data["remoteConfigForceFetch"] != null) {
          callback?.call();
          return;
        }

        /// Android
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

        /// TODO: Integração para Remote Push Notifications no IOS (necessita da Apple Developer Key para funcionar)
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
        if (message.data["remoteConfigForceFetch"] != null) {
          callback?.call();
          return;
        }

        if (message.data['route'] != null) {
          navigatorKey.currentState?.pushNamed(message.data['/']);
          navigatorKey.currentState?.pushNamed(message.data['route']);
        }
      },
    ).onData((data) {
      // TODO: salvar notificação em local storage para criar "área de notificações"
      final notification = data.notification;

      if (notification != null) {
        notificationsList.value.add(
          LocalNotification(
            id: notification.hashCode,
            title: notification.title!,
            body: notification.body!,
            payload: data.data["route"],
          ),
        );
      }

      print("""
          Notificação Recebida... 
          ID: ${notification.hashCode}, 
          Title: ${notification?.title},
          Body: ${notification?.body},
          Payload: ${data.data},
          """);
    });
  }
}
