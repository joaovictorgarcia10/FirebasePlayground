import 'package:firebase_playground/i18n/i18n_localizations.dart';
import 'package:firebase_playground/main.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final i18n = I18nLocalizations();

  Future<void> initI18n() async {
    await Future.delayed(const Duration(seconds: 5));

    I18nLocalizations.startWithPackages(
      [
        "app",
      ],
      [
        const Locale("pt", "BR"),
        const Locale("en", "US"),
      ],
      localeResolutionCallback,
    );

    await i18n.load();
  }

  @override
  void initState() {
    super.initState();

    initI18n()
        .then((_) => navigatorKey.currentState?.pushReplacementNamed("/home"));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(size: 56.0),
      ),
    );
  }
}

Locale localeResolutionCallback(locale, supportedLocales) {
  for (var supportedLocale in supportedLocales) {
    if (locale != null &&
        supportedLocale.languageCode == locale.languageCode &&
        supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }

  return supportedLocales.first;
}
