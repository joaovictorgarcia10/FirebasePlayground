// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_playground/firebase_messaging/custom_firebase_messaging.dart';
import 'package:firebase_playground/firebase_messaging/custom_local_notification.dart';
import 'package:firebase_playground/pages/home_page.dart';
import 'package:firebase_playground/pages/second_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final customLocalNotification = CustomLocalNotification();
  // await CustomFirebaseMessaging(customLocalNotification).initialize();
  // await CustomFirebaseMessaging(customLocalNotification).getTokenFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/notifications': (context) => const NotificationsPage(),
      },
    );
  }
}
