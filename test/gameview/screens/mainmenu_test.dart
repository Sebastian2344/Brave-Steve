import 'package:brave_steve/game/presentation/screens/game_view.dart';
import 'package:brave_steve/game/presentation/screens/introduction.dart';
import 'package:brave_steve/game/presentation/screens/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  group('Test MainMenu Widget', () { 
     testWidgets('View page', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainMenu()));

      // Sprawdź, czy tytuł jest widoczny
      expect(find.text('Brave Steve'), findsOneWidget);

      // Sprawdź, czy przycisk "Start New Game" jest widoczny
      expect(find.text('Start New Game'), findsOneWidget);

      // Sprawdź, czy przycisk "Continue Game" jest widoczny
      expect(find.text('Continue Game'), findsOneWidget);

      // Sprawdź, czy przycisk "Exit" jest widoczny
      expect(find.text('Exit'), findsOneWidget);

    });

    
    testWidgets('Navigate to next page when you press new game', (WidgetTester tester) async {
      await tester.pumpWidget(const ProviderScope(child:MaterialApp(home: MainMenu())));

      // Wywołaj kliknięcie na przycisk "Start New Game"
      await tester.tap(find.text('Rozpocznij Nową Grę'));
      await tester.pumpAndSettle();
      // Sprawdź, czy nowa strona gry została wyrenderowana po naciśnięciu przycisku
      
      expect(find.byType(IntroductionScreen), findsOneWidget);
    });

    testWidgets('Navigate to next page when you press continue game', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child:MaterialApp(home: MainMenu())));

    // Wywołaj kliknięcie na przycisk "Start New Game"
    await tester.tap(find.text('Continue Game'));
    await tester.pumpAndSettle();
    // Sprawdź, czy nowa strona gry została wyrenderowana po naciśnięciu przycisku
    expect(find.byType(GameView), findsOneWidget);
    });

    testWidgets('Exit app when you press exit', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainMenu()));

    // Wywołaj kliknięcie na przycisk "Exit"
    await tester.tap(find.text('Exit'));
    await tester.pumpAndSettle();

    // Sprawdź, czy wróciliśmy do poprzedniego ekranu (brak strony gry)
    expect(find.byType(MainMenu), findsNothing);
    });
  });
}