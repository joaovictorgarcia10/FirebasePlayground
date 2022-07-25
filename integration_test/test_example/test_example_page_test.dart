import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:firebase_playground/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Home Page E2E Test', () {
    testWidgets('Navegar da HomePage para a Examples Page',
        (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("button_test_example")));
      await Future.delayed(const Duration(seconds: 4));

      await tester.pumpAndSettle();

      //expect(find.byType(ExamplePage), findsOneWidget);
      expect(find.byKey(const Key("titulo")), findsOneWidget);
      expect(find.byKey(const Key("titulo_input")), findsOneWidget);
      expect(find.byKey(const Key("contador")), findsOneWidget);
      expect(find.byType(ValueListenableBuilder<String>), findsOneWidget);
      expect(find.byType(ValueListenableBuilder<int>), findsOneWidget);
    });

    testWidgets('Clique 5x no Botão Incrementar', (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key("button_test_example")));
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      for (var i = 0; i < 5; i++) {
        await tester.tap(find.byIcon(Icons.plus_one));
        await Future.delayed(const Duration(seconds: 4));
      }

      await tester.pumpAndSettle();
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('Escrever no campo de texto para alterar o titulo da pagina',
        (WidgetTester tester) async {
      // Initialize App
      await app.main();
      await tester.pumpAndSettle();

      // Navigating to Example Page
      await tester.tap(find.byKey(const Key("button_test_example")));
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Initial state of title
      var titulo =
          find.byKey(const Key('titulo')).evaluate().single.widget as Text;
      expect(titulo.data, equals('Título'));
      await Future.delayed(const Duration(seconds: 2));

      // Editing title
      await tester.enterText(
          find.byKey(const Key('titulo_input')), 'Título da Page');
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 4));

      // Title eddited
      titulo = find.byKey(const Key('titulo')).evaluate().single.widget as Text;
      expect(titulo.data, equals('Título da Page'));
    });
  });
}
