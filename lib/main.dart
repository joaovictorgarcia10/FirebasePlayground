import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_playground/i18n/i18n_localizations.dart';
import 'package:firebase_playground/pages/auth/auth_page.dart';
import 'package:firebase_playground/pages/crashlytics/crashlytics_page.dart';
import 'package:firebase_playground/pages/firestore/firestore_page.dart';
import 'package:firebase_playground/pages/home_page.dart';
import 'package:firebase_playground/pages/messaging/messaging_page.dart';
import 'package:firebase_playground/pages/messaging/notifications_page.dart';
import 'package:firebase_playground/pages/remote_config/remote_config_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_playground/pages/example/example_page.dart';
import 'package:firebase_playground/services/firebase_messaging/custom_firebase_messaging.dart';
import 'package:firebase_playground/services/firebase_remote_config/custom_firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'services/firebase_messaging/custom_local_notification.dart';

Future<void> main() async {
  // runZonedGuarded para registrar erros no FirebaseCrashlytics
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // i18n
      I18nLocalizations(
        packages: [
          "",
          "",
          //...
        ],
      );

      // Firebase Services
      await Firebase.initializeApp();
      await CustomFirebaseRemoteConfig().initialize();
      await CustomFirebaseMessaging().initialize(
          callback: () => CustomFirebaseRemoteConfig().forceFetch());
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      // Check for Scheculed Notifications
      CustomLocalNotification().checkForNotifications();
    },
    // onError
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Playground',
      navigatorKey: navigatorKey,
      theme: ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/notifications': (context) => const NotificationsPage(),
        '/remote_config': (context) => const RemoteConfigPage(),
        '/cloud_messaging': (context) => const MessagingPage(),
        '/crashlytics': (context) => const CrashlyticsPage(),
        '/auth': (context) => const AuthPage(),
        '/firestore': (context) => const FirestorePage(),
        '/test_example': (context) => const ExamplePage(),
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("pt", "BR"),
        Locale("en", "US"),
      ],
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
