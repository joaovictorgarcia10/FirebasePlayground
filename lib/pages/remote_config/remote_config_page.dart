import 'package:firebase_playground/firebase_remote_config/custom_firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfigPage extends StatefulWidget {
  const RemoteConfigPage({Key? key}) : super(key: key);

  @override
  State<RemoteConfigPage> createState() => _RemoteConfigPageState();
}

class _RemoteConfigPageState extends State<RemoteConfigPage> {
  bool _isLoading = false;

  void _startRemoteConfig() async {
    setState(() => _isLoading = true);
    await CustomFirebaseRemoteConfig().forceFetch();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Config Page'),
        backgroundColor: CustomFirebaseRemoteConfig().getValueOrDefault(
          key: 'isAppBarBlue',
          defaultValue: false,
        )
            ? Colors.blue
            : Colors.red,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    CustomFirebaseRemoteConfig()
                        .getValueOrDefault(
                          key: 'novaString',
                          defaultValue: 'defaultValue',
                        )
                        .toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startRemoteConfig,
        tooltip: 'Start Remote Config',
        child: const Icon(Icons.download_outlined),
      ),
    );
  }
}
