import 'package:brave_steve/modules/prestige/prestige_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrestigeScreen extends ConsumerStatefulWidget {
  const PrestigeScreen({super.key, required this.level});
  final int level;

  @override
  ConsumerState<PrestigeScreen> createState() => _PrestigeScreenState();
}

class _PrestigeScreenState extends ConsumerState<PrestigeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
       ref
            .read(prestigeNotifierProvider.notifier)
            .calculatedPoints(widget.level);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Definiowanie podstawowych stylów
    final textTheme = Theme.of(context).textTheme;
    const Color primaryColor = Color(0xFF4A2B1A); // Ciemniejszy brąz
    const Color accentColor = Color(0xFFD4AF37); // Złoty
    const Color textColor = Colors.white;
    const Color buttonColor =
        Color(0xFF6B4228); // Ciemniejszy brąz dla przycisków
    const Color disabledColor = Colors.grey;
    final p = ref.watch(prestigeNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey, // Użyj koloru głównego dla tła
      appBar: AppBar(
        foregroundColor: textColor,
        backgroundColor: Colors.brown.shade900,
        automaticallyImplyLeading: false,
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
        leading: 
          !p.isGivePoints? IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
            tooltip: "Powrót",
          ): SizedBox.shrink()
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              // Sekcja z punktami do zdobycia
              _buildSectionCard(
                context,
                title: 'Punkty Prestiżu',
                content: Column(
                  children: [
                    Text(
                      'Zgarnij ${p.calculatedPoints} punktów prestiżu w zamian za twój poziom ${widget.level}',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyLarge
                          ?.copyWith(color: textColor.withValues(alpha: 0.8)),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      spacing: 10,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              foregroundColor: textColor,
                              disabledBackgroundColor: disabledColor,
                              disabledForegroundColor: Colors.white70,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: !p.isGivePoints && p.calculatedPoints > 0
                                ? () {
                                    ref
                                        .read(prestigeNotifierProvider.notifier)
                                        .givePoints(widget.level);
                                  }
                                : null,
                            child: Text(
                              'Zgarnij punkty',
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              foregroundColor: textColor,
                              disabledBackgroundColor: disabledColor,
                              disabledForegroundColor: Colors.white70,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: p.calculatedPoints > 0
                                ? () {
                                    ref
                                        .read(prestigeNotifierProvider.notifier)
                                        .resetPoints(widget.level);
                                  }
                                : null,
                            child: Text(
                              'Rozdaj ponownie',
                              textAlign: TextAlign.center,
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                foregroundColor: textColor,
                                disabledBackgroundColor: disabledColor,
                                disabledForegroundColor: Colors.white70,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: p.isGivePoints
                                  ? () {
                                      ref.read(prestigeNotifierProvider.notifier).stepBack();
                                    }
                                  : null,
                              child: Text(
                                'Anuluj',
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Sekcja z dostępnymi punktami
              _buildSectionCard(
                context,
                title: 'Dostępne Punkty',
                content: Text(
                  '${p.points}',
                  style: textTheme.displaySmall?.copyWith(
                      color: accentColor, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
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
                        ref
                            .read(prestigeNotifierProvider.notifier)
                            .incrementAttack();
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
                        ref
                            .read(prestigeNotifierProvider.notifier)
                            .incrementHealth();
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildStatRow(
                      context,
                      label: 'Szczęście',
                      value: p.lucky,
                      bonus: '+0.25%',
                      canIncrement: p.points > 0,
                      onPressed: () {
                        ref
                            .read(prestigeNotifierProvider.notifier)
                            .incrementLucky();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Przycisk resetu
              SizedBox(
                width: double.infinity, // Przycisk na całą szerokość
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        accentColor, // Złoty kolor dla akcji głównej
                    foregroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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
        ),
      ),
    );
  }

  // Pomocniczy widget do tworzenia sekcji
  Widget _buildSectionCard(BuildContext context,
      {required String title, required Widget content}) {
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
            color: Colors.black.withValues(alpha: 0.3),
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
          style: textTheme.titleMedium
              ?.copyWith(color: textColor.withValues(alpha: 0.9)),
        ),
        Text(
          '$value',
          style: textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        IconButton(
          onPressed: canIncrement ? onPressed : null,
          icon: Icon(Icons.add_circle,
              color: canIncrement ? iconColor : disabledIconColor),
          iconSize: 30,
        ),
        Text(
          bonus,
          style: textTheme.titleMedium
              ?.copyWith(color: textColor.withValues(alpha: 0.7)),
        ),
      ],
    );
  }
}
