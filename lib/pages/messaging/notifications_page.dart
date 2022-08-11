import 'package:firebase_playground/main.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications Page'),
      ),
      body: Center(
          child: ValueListenableBuilder(
        valueListenable: notificationsList,
        builder: (_, __, ___) {
          return ListView.separated(
            itemCount: notificationsList.value.length,
            itemBuilder: (context, index) {
              final notification = notificationsList.value[index];
              return ListTile(
                leading: CircleAvatar(child: Text("${index + 1}")),
                title: Text(notification.title),
                subtitle: Text(notification.body),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      )),
    );
  }
}
