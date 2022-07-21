import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsPage extends StatefulWidget {
  const CrashlyticsPage({Key? key}) : super(key: key);

  @override
  State<CrashlyticsPage> createState() => _CrashlyticsPageState();
}

class _CrashlyticsPageState extends State<CrashlyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crashlytics Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Clique aqui!'),
          onPressed: () {
            FirebaseCrashlytics.instance
                .log('Erro ao processar clique no botão');

            throw Exception('Erro ao processar clique no botão');
          },
        ),
      ),
    );
  }
}
