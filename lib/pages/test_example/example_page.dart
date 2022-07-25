import 'package:firebase_playground/pages/test_example/example_controller.dart';
import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final controller = ExampleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<String>(
          valueListenable: controller.titulo,
          builder: (context, value, child) {
            return Text(
              value,
              key: const Key("titulo"),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                key: const Key("titulo_input"),
                initialValue: controller.titulo.value,
                onChanged: (value) {
                  controller.titulo.value = value;
                },
                decoration: const InputDecoration(
                  label: Text("Título"),
                ),
              ),
              const SizedBox(height: 100.0),
              ValueListenableBuilder<int>(
                valueListenable: controller.counter,
                builder: (context, value, child) {
                  return Text(
                    value.toString(),
                    key: const Key("contador"),
                    style: Theme.of(context).textTheme.headline5,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () {
          controller.counter.value++;
        },
      ),
    );
  }
}
