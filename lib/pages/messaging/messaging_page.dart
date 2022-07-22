import 'package:firebase_playground/firebase_messaging/custom_local_notification.dart';
import 'package:flutter/material.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({Key? key}) : super(key: key);

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  bool valor = false;
  final customLocalNotification = CustomLocalNotification();

  void onTapCard() {
    setState(() {
      valor = !valor;
    });

    if (valor) {
      customLocalNotification.showNotificationScheduled(
          notification: LocalNotification(
            id: 1,
            title: "Finalizar mais tarde!",
            body: "Para finalizar a sua contratação clique aqui.",
            payload: "/notifications",
          ),
          duration: const Duration(seconds: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Messaging Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: ListTile(
                title: const Text("Finalizar mais tarde"),
                trailing: valor
                    ? const Icon(Icons.check_box, color: Colors.green)
                    : const Icon(Icons.check_box_outline_blank),
                onTap: onTapCard,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/notifications");
        },
        tooltip: 'Navigate to Notifications',
        child: const Icon(Icons.notifications_active_outlined),
      ),
    );
  }
}
