import 'package:brave_steve/game/presentation/widgets/action_buttons_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets('Test ActionInGame Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Column(
            children: [
              ActionInGame(isNewGame:true),
            ],
          ),
        ),
      ),
    );

    // Expect to find the Atak button.
    expect(find.text('Atak'), findsOneWidget);

    // Trigger the battle function for the Atak button.
    await tester.runAsync(() => tester.tap(find.text('Atak')));
    await tester.pumpAndSettle();
    // Add additional expectations or checks as needed.
  });

  testWidgets('Test ButtonWidget Widget', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ButtonWidget(
            fontSize: 20.0,
            ignore: false,
            battle: () {},
            textButton: 'Test Button',
            color: Colors.blue,
            width: 100.0,
            height: 50.0,
          ),
        ),
      ),
    );

    // Expect to find the Test Button.
    expect(find.text('Test Button'), findsOneWidget);

    // Trigger the battle function for the Test Button.
    await tester.tap(find.text('Test Button'));
    await tester.pumpAndSettle();

    // Add additional expectations or checks as needed.
  });
}