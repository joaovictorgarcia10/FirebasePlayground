// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:firebase_playground/main.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class I18nLocalizations {
  final List<String> packages;

  I18nLocalizations({
    this.packages = const [
      "app",
    ],
  });

  ///
  var _locales = <String, dynamic>{};

  Locale currentLocale() =>
      Localizations.localeOf(navigatorKey.currentContext!);

  Future<String> loadStringByPath(String path) => rootBundle.loadString(path);

  ///
  Future<void> _loadLocalJson(Locale locale, [String? package]) async {
    final path = (package != "app")
        ? "packages/$package/lang/$locale.json"
        : "lang/$locale.json";

    try {
      final json = await loadStringByPath(path);
      final key = (package != null) ? package : "app";

      _locales.addAll({key: Map.from(jsonDecode(json))});
    } catch (e) {
      final error =
          "ERROR i18n LOAD $path!\n1- Verify if you create folder lang and add json.\n2- Verify if you add in pubspec.yaml assets: ... - lang/";
      print(error);
      throw ErrorHint(error);
    }
  }

  Future<void> load() async {
    final locale = currentLocale();

    for (var item in packages) {
      await _loadLocalJson(locale, item);
    }

    try {
      for (var item in packages) {
        try {
          await startRemoteConfig(locale, item);
        } catch (e) {}
      }
    } catch (e) {
      const error =
          "ERROR i18n REMOTE CONFIG \n1- Verify add GoogleService-Info.plist for iOS and GoogleService.json for android";
      print(error);
    }

    return;
  }

  Future<void> startRemoteConfig(Locale locale,
      [String package = "app"]) async {
    try {
      final instance = FirebaseRemoteConfig.instance;
      await instance.setDefaults(_locales);
      await instance.fetchAndActivate();
      print("${package}_$locale");

      final value = instance.getString("${package}_$locale");
      if (value.isNotEmpty) _locales.addAll({package: jsonDecode(value)});
      return;
    } catch (e) {
      const error =
          "ERROR i18n GET VALUE REMOTE CONFIG \n1- Verify if is correct locale create in REMOTE CONFIG";
      throw ErrorHint(error);
    }
  }

  String getValue(String key) {
    String stringLocale = "NOT FOUND [$key]";
    for (var item in packages) {
      if (_locales[item].containsKey(key)) {
        stringLocale = _locales[item][key];
        break;
      }
    }

    return stringLocale;
  }
}
