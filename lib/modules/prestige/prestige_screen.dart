import 'package:brave_steve/modules/prestige/prestige_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrestigeScreen extends StatelessWidget {
  const PrestigeScreen({super.key, required this.level});
  final int level;

  @override
  Widget build(BuildContext context) {
    // Definiowanie podstawowych stylów
    final textTheme = Theme.of(context).textTheme;
    const Color primaryColor = Color(0xFF4A2B1A); // Ciemniejszy brąz
    const Color accentColor = Color(0xFFD4AF37); // Złoty
    const Color textColor = Colors.white;
    const Color buttonColor = Color(0xFF6B4228); // Ciemniejszy brąz dla przycisków
    const Color disabledColor = Colors.grey;

    return Scaffold(
      backgroundColor: Colors.grey, // Użyj koloru głównego dla tła
      appBar: AppBar(
        foregroundColor: textColor,
        backgroundColor: Colors.brown.shade900,
        elevation: 0, // Usuń cień spod appbara
        centerTitle: true,
        title: Text(
          'Reset Progresu Postaci',
          style: textTheme.headlineSmall?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final p = ref.watch(prestigeNotifierProvider);
            final int calculatedPoints = (level / 3).round();

            return Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF301b0a).withValues(alpha:0.9), // Lekko przezroczyste tło panelu
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Minimalna wysokość kolumny
                children: [
                  // Sekcja z punktami do zdobycia
                  _buildSectionCard(
                    context,
                    title: 'Punkty Prestiżu',
                    content: Column(
                      children: [
                        Text(
                          'Zgarnij $calculatedPoints punktów prestiżu w zamian za twój poziom $level',
                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge?.copyWith(color: textColor.withValues(alpha:0.8)),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor,
                                  foregroundColor: textColor,
                                  disabledBackgroundColor: disabledColor,
                                  disabledForegroundColor: Colors.white70,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: !p.isGivePoints
                                    ? () {
                                        ref.read(prestigeNotifierProvider.notifier).givePoints(level);
                                      }
                                    : null,
                                child: Text(
                                  'Zgarnij punkty',
                                  style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor,
                                  foregroundColor: textColor,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () {
                                  ref.read(prestigeNotifierProvider.notifier).resetPoints(level);
                                },
                                child: Text(
                                  'Rozdaj jeszcze raz',
                                  textAlign: TextAlign.center,
                                  style: textTheme.bodyMedium?.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Sekcja z dostępnymi punktami
                  _buildSectionCard(
                    context,
                    title: 'Dostępne Punkty',
                    content: Text(
                      '${p.points}',
                      style: textTheme.displaySmall?.copyWith(color: accentColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Sekcja z rozdawaniem statystyk
                  _buildSectionCard(
                    context,
                    title: 'Rozdaj Statystyki',
                    content: Column(
                      children: [
                        _buildStatRow(
                          context,
                          label: 'Atak',
                          value: p.attack,
                          bonus: '+1',
                          canIncrement: p.points > 0,
                          onPressed: () {
                            ref.read(prestigeNotifierProvider.notifier).incrementAttack();
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildStatRow(
                          context,
                          label: 'Życie',
                          value: p.health,
                          bonus: '+10',
                          canIncrement: p.points > 0,
                          onPressed: () {
                            ref.read(prestigeNotifierProvider.notifier).incrementHealth();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Przycisk resetu
                  SizedBox(
                    width: double.infinity, // Przycisk na całą szerokość
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor, // Złoty kolor dla akcji głównej
                        foregroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
                      ),
                      onPressed: () {
                        ref.read(prestigeNotifierProvider.notifier).savePrestige();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Resetuj Postać!',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Pomocniczy widget do tworzenia sekcji
  Widget _buildSectionCard(BuildContext context, {required String title, required Widget content}) {
    final textTheme = Theme.of(context).textTheme;
    const Color borderColor = Color(0xFFD4AF37); // Złoty
    const Color cardColor = Color(0xFF4A2B1A); // Ciemniejszy brąz

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: textTheme.titleMedium?.copyWith(
              color: borderColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const Divider(color: borderColor, thickness: 1, height: 20),
          content,
        ],
      ),
    );
  }

  // Pomocniczy widget do tworzenia wiersza statystyk
  Widget _buildStatRow(
    BuildContext context, {
    required String label,
    required double value,
    required String bonus,
    required bool canIncrement,
    required VoidCallback onPressed,
  }) {
    final textTheme = Theme.of(context).textTheme;
    const Color textColor = Colors.white;
    const Color iconColor = Color(0xFFD4AF37); // Złoty
    const Color disabledIconColor = Colors.white38;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: textTheme.titleMedium?.copyWith(color: textColor.withValues(alpha:0.9)),
        ),
        Text(
          '$value',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        IconButton(
          onPressed: canIncrement ? onPressed : null,
          icon: Icon(Icons.add_circle, color: canIncrement ? iconColor : disabledIconColor),
          iconSize: 30,
        ),
        Text(
          bonus,
          style: textTheme.titleMedium?.copyWith(color: textColor.withValues(alpha:0.7)),
        ),
      ],
    );
  }
}