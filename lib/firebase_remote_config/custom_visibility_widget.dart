import 'package:firebase_playground/firebase_remote_config/custom_firebase_remote_config.dart';
import 'package:flutter/material.dart';

class CustomVisibilityWidget extends StatelessWidget {
  final Widget child;
  final String remoteConfigKey;
  final dynamic defaultValue;

  const CustomVisibilityWidget({
    Key? key,
    required this.child,
    required this.remoteConfigKey,
    required this.defaultValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: CustomFirebaseRemoteConfig().getValueOrDefault(
        key: remoteConfigKey,
        defaultValue: defaultValue,
      ),
      child: child,
    );
  }
}
