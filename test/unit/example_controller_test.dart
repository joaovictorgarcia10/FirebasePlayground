import 'package:firebase_playground/pages/example/example_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test ExampleController', () {
    test('Contador deve inicializar em 0', () {
      expect(ExampleController().counter.value, 0);
    });

    test('Incrementar o contador em 1x', () {
      final controller = ExampleController();
      controller.counter.value++;
      expect(controller.counter.value, 1);
    });

    test('Titulo inicial deve ser Título', () {
      expect(ExampleController().titulo.value, 'Título');
    });

    test('Alterar o titulo Home para Home Page', () {
      final controller = ExampleController();
      controller.titulo.value = 'Home Page';
      expect(controller.titulo.value, 'Home Page');
    });
  });
}
