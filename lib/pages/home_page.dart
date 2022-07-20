import 'package:firebase_playground/firebase_messaging/custom_local_notification.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool valor = false;
  final customLocalNotification = CustomLocalNotification();

  void onTap() {
    setState(() {
      valor = !valor;
    });

    if (valor) {
      customLocalNotification.showNotification(
        LocalNotification(
          id: 1,
          title: "Finalizar mais tarde!",
          body: "Para finalizar a sua contratação clique aqui.",
          payload: "/notifications",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
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
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/notifications");
        },
        tooltip: 'Navigate',
        child: const Icon(Icons.notifications_active_outlined),
      ),
    );
  }
}
