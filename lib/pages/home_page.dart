import 'package:firebase_playground/firebase_remote_config/custom_firebase_remote_config.dart';
import 'package:firebase_playground/firebase_remote_config/custom_visibility_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    CustomFirebaseRemoteConfig().forceFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/cloud_messaging"),
                child: const Text("Firebase Cloud Messaging"),
              ),
              const SizedBox(height: 20.0),

              // Feature Toggle com Firebase Remote Config
              CustomVisibilityWidget(
                defaultValue: false,
                remoteConfigKey: "remote_config_is_ready",
                child: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/remote_config"),
                  child: const Text("Firebase Remote Config"),
                ),
              ),
              const SizedBox(height: 20.0),

              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/crashlytics"),
                child: const Text("Firebase Crashlytics"),
              ),
              const SizedBox(height: 20.0),

              TextButton(
                onPressed: () => Navigator.pushNamed(context, "/auth"),
                child: const Text("Firebase Auth"),
              ),
              const SizedBox(height: 20.0),

              // Feature Toggle com Firebase Remote Config
              CustomVisibilityWidget(
                defaultValue: false,
                remoteConfigKey: "firestore_is_ready",
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, "/firestore"),
                  child: const Text("Firebase Firestore"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
