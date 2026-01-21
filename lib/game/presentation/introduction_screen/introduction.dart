import 'package:brave_steve/game/presentation/fight_screen/fight_screen.dart';
import 'package:brave_steve/game/presentation/menu_screen/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state_menegment/game_state.dart';

class IntroductionScreen extends ConsumerWidget {
  IntroductionScreen({super.key, required this.isNewGame});
  final bool isNewGame;
  final ScrollController firstController = ScrollController();
  final ScrollController firstController2 = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double fontSize = MediaQuery.of(context).textScaler.scale(16.0);
    double fontSizeTitle = MediaQuery.of(context).textScaler.scale(18.0);

    // Używamy tych samych kolorów i stylów, tylko poprawiamy layout
    const dividerStyle = Divider(
      height: 30,       // Większy odstęp pionowy dla linii
      thickness: 1,
      indent: 30,       // Odsunięcie linii od lewej krawędzi
      endIndent: 30,    // Odsunięcie linii od prawej krawędzi
      color: Colors.white38, // Lekko przezroczysty biały dla subtelności
    );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text('Wprowadzenie',
            style: TextStyle(
                fontSize: MediaQuery.of(context).textScaler.scale(40.0),
                color: const Color.fromARGB(255, 57, 44, 30),
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        foregroundColor: const Color.fromARGB(255, 57, 44, 30),
        backgroundColor: Colors.grey,
      ),
      body: ColoredBox(
        color: Colors.brown,
        child: SafeArea( // SafeArea chroni przed "notchem" i dolnym paskiem gestów
          child: Column(
            children: [
              // Dodatkowy odstęp od góry, żeby było "niżej"
              const SizedBox(height: 20),

              Text(
                'Czym jest ta gra?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSizeTitle,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  // Zwiększone wcięcia (horizontal: 32) dla schludniejszego wyglądu
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: RawScrollbar(
                    thickness: 6, // Trochę cieńszy pasek przewijania
                    thumbColor: Colors.grey,
                    controller: firstController,
                    thumbVisibility: true,
                    radius: const Radius.circular(20),
                    child: SingleChildScrollView(
                      controller: firstController,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(
                          textAlign: TextAlign.justify,
                          '''Jest to gra turowa w krórej wcielasz się w Steave'a. Pewnego dnia zombie w diamentowej zbroi ukradł ci złoto. Zdenerwowany sytuacją postanawiasz go dorwać i odzyskać stracony kruszec. Tutaj gra się rozpoczyna.Po drodze możesz napotkać potwory,które są na usługach zombie. Mają one za zadanie powstrzymać Ciebie. Twoim zadaniem jest odzyskanie złota pozostając żywym.''',
                          style: TextStyle(fontSize: fontSize, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              dividerStyle, // Użycie poprawionego separatora

              Text(
                'Ekran gry',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSizeTitle,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  // Zwiększone wcięcia
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Center( // Center pomaga, gdy tekst jest krótki
                    child: Text(
                      textAlign: TextAlign.justify,
                      'Elementy ekranu gry: górny pasek [przycisk powrotu do menu(strzałka w lewo), przycisk zapisu(dyskietka), ekwipunek(ikona ludzika)], pole bitwy, statystyki postaci, opcje podczas bitwy [atak, superatak, osłabienie, oczyszczenie]',
                      style: TextStyle(fontSize: fontSize, color: Colors.white),
                    ),
                  ),
                ),
              ),

              dividerStyle, // Użycie poprawionego separatora

              Text(
                'Ekran z zapisami gier',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSizeTitle,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  // Zwiększone wcięcia
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: RawScrollbar(
                    thickness: 6,
                    thumbColor: Colors.grey,
                    controller: firstController2,
                    radius: const Radius.circular(20),
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: firstController2,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(
                          textAlign: TextAlign.justify,
                          'Ekran z zapisami ma kafelki. Każdy z nich to zapis gry. Gre można wczytać klikając na kafelek bądź usunąć wciskając na nim ikone kosza. Do ekranu zapisów można dostać się przez menu klikając przycisk "Kontynuuj Grę" lub zapisując gre w ekranie gry.',
                          style: TextStyle(fontSize: fontSize, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center, // Wycentrowanie przycisków w ich przestrzeni
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return const MainMenu();
                              }));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 70, 50, 42),
                            foregroundColor: Colors.white,
                            fixedSize: Size(
                              MediaQuery.of(context).size.width / 2.5,
                              MediaQuery.of(context).size.height / 12,
                            )),
                        child: const Text(
                          'Powrót',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await ref.read(myStateProvider.notifier).newGame();
                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) {
                                    return FightScreen(isNewGame);
                                  }));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 70, 50, 42),
                              foregroundColor: Colors.white,
                              fixedSize: Size(
                                MediaQuery.of(context).size.width / 2.5,
                                MediaQuery.of(context).size.height / 12,
                              )),
                          child: const Text(
                            'Start',
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}