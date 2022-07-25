import 'package:flutter/material.dart';

class ExampleController {
  final ValueNotifier<int> counter = ValueNotifier<int>(0);
  final ValueNotifier<String> titulo = ValueNotifier<String>("Título");
}
